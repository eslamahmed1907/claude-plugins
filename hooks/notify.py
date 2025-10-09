#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.9"
# dependencies = [
#     "requests",
#     "psutil",
# ]
# ///
"""
Claude Code Notification Hook with Auto-Starting ChatterBox TTS
Automatically starts ChatterBox service when Claude Code starts
"""

import os
import sys
import json
import time
import subprocess
import tempfile
import signal
from pathlib import Path
from datetime import datetime

# ChatterBox configuration
CHATTERBOX_DIR = Path.home() / "Desktop" / "Devel" / "projects" / "chatterbox"
CHATTERBOX_URL = "http://127.0.0.1:8000"
MANAGER_SCRIPT = CHATTERBOX_DIR / "chatterbox_manager.py"

# Debug log
DEBUG_LOG = Path.home() / '.claude' / 'logs' / 'tts-hooks.log'
DEBUG_LOG.parent.mkdir(parents=True, exist_ok=True)

def log_debug(message):
    """Log debug messages."""
    with open(DEBUG_LOG, 'a') as f:
        timestamp = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        f.write(f"[{timestamp}] {message}\n")

def ensure_chatterbox_running():
    """Ensure ChatterBox service is running."""
    try:
        import requests
        
        # Quick check if already running
        try:
            response = requests.get(f"{CHATTERBOX_URL}/health", timeout=0.5)
            if response.status_code == 200:
                log_debug("ChatterBox already running")
                return True
        except:
            pass
        
        # Not running, start it
        log_debug("ChatterBox not running, starting service...")
        
        # Check if manager script exists
        if not MANAGER_SCRIPT.exists():
            log_debug(f"Manager script not found at {MANAGER_SCRIPT}")
            return False
        
        # Start the service using the manager (now a uv script)
        try:
            result = subprocess.run(
                [str(MANAGER_SCRIPT), "ensure"],
                cwd=CHATTERBOX_DIR,
                capture_output=True,
                text=True,
                timeout=40
            )
            
            if result.returncode == 0:
                log_debug("ChatterBox service started successfully")
                
                # Give it a moment to fully initialize
                time.sleep(2)
                
                # Verify it's running
                try:
                    response = requests.get(f"{CHATTERBOX_URL}/health", timeout=5)
                    if response.status_code == 200:
                        log_debug("ChatterBox service verified as running")
                        return True
                except:
                    log_debug("ChatterBox started but not yet responsive")
                    return False
            else:
                log_debug(f"Failed to start ChatterBox: {result.stderr}")
                return False
                
        except subprocess.TimeoutExpired:
            log_debug("Timeout starting ChatterBox service")
            return False
        except Exception as e:
            log_debug(f"Error starting ChatterBox: {e}")
            return False
            
    except ImportError:
        log_debug("requests module not available")
        return False

def speak_with_chatterbox(text: str) -> bool:
    """Use local ChatterBox TTS service to speak the notification."""
    try:
        import requests
        
        # Send text to ChatterBox service
        url = f"{CHATTERBOX_URL}/speak"
        data = {
            "text": text,
            "play": True
        }
        
        log_debug(f"Sending to ChatterBox: {text}")
        response = requests.post(url, json=data, timeout=30)
        
        if response.status_code == 200:
            log_debug("ChatterBox synthesis successful")
            return True
        else:
            log_debug(f"ChatterBox error: {response.status_code} - {response.text}")
            return False
            
    except Exception as e:
        log_debug(f"ChatterBox speak error: {e}")
        return False

def speak_with_elevenlabs(text: str) -> bool:
    """ElevenLabs is disabled - using ChatterBox only."""
    log_debug("ElevenLabs is disabled, ChatterBox only mode")
    return False

def get_project_name():
    """Get the project directory name."""
    project_dir = os.environ.get('CLAUDE_PROJECT_DIR', os.getcwd())
    return Path(project_dir).name

def main():
    """Process notification event."""
    try:
        # Start ChatterBox service if needed (only on SessionStart)
        hook_type = os.environ.get('CLAUDE_HOOK_TYPE', 'unknown')
        
        # Start service on SessionStart (when Claude Code starts)
        if 'SessionStart' in hook_type or hook_type == 'SessionStart':
            log_debug(f"SessionStart detected, ensuring ChatterBox is running...")
            ensure_chatterbox_running()
        
        # Read event data
        event_data = {}
        if not sys.stdin.isatty():
            try:
                input_data = sys.stdin.read()
                if input_data:
                    event_data = json.loads(input_data)
            except:
                pass
        
        project = get_project_name()
        
        # Determine message
        is_compact = False
        if 'SessionStart' in hook_type:
            source = event_data.get('source', '').lower()
            if 'compact' in source or 'compaction' in source or ':compact' in hook_type.lower():
                is_compact = True
        
        if 'message' in event_data:
            message = event_data['message']
            if "waiting for your input" in message.lower():
                message = f"David, I need your help in {project}"
        elif is_compact:
            message = f"David, we have compacted the context window in {project}"
        elif 'SessionStart' in hook_type:
            source = event_data.get('source', 'unknown')
            if source == 'startup':
                message = f"David, I am ready to work on {project}"
            elif source == 'resume':
                message = f"David, I am resuming work on {project}"
            elif source == 'clear':
                message = f"David, I have cleared the context and am ready for {project}"
            else:
                message = f"David, I am ready to work on {project}"
        elif 'SubagentStop' in hook_type:
            message = f"David, the subagent has completed its work in {project}, moving on now"
        elif 'Notification' in hook_type:
            message = f"David, I need your help in {project}"
        elif 'Stop' in hook_type:
            message = f"David, I have completed my work in {project}"
        elif 'PreCompact' in hook_type:
            message = f"David, preparing to compact the context window in {project}"
        else:
            message = f"David, Claude needs your input in {project}"
        
        log_debug(f"Message: {message}")
        
        # Use ChatterBox only (ElevenLabs disabled)
        if not speak_with_chatterbox(message):
            log_debug("ChatterBox failed - no audio notification available")
        
        sys.exit(0)
        
    except Exception as e:
        log_debug(f"Error: {e}")
        import traceback
        log_debug(f"Traceback: {traceback.format_exc()}")
        sys.exit(0)

if __name__ == "__main__":
    main()
