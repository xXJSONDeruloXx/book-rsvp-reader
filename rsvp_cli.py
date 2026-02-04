#!/usr/bin/env python3
"""
RSVP CLI - Rapid Serial Visual Presentation reader
Reads text files and displays words one at a time for speed reading.
"""

import sys
import time
import os
from pathlib import Path


class RSVPEngine:
    """Handles RSVP display logic and timing"""
    
    def __init__(self, wpm=300):
        self.wpm = wpm
    
    def calculate_orp(self, word):
        """Calculate Optimal Reading Point (ORP) - where eye should focus"""
        length = len(word)
        if length <= 1:
            return 0
        elif length <= 5:
            return 1
        elif length <= 9:
            return 2
        elif length <= 13:
            return 3
        else:
            return 4
    
    def calculate_duration(self, word):
        """Calculate display duration in seconds based on word characteristics"""
        # Base duration from WPM
        base_duration = 60.0 / self.wpm
        
        # Adjust for punctuation (longer pauses)
        if word and word[-1] in '.!?':
            base_duration *= 2.0
        elif word and word[-1] in ',;:':
            base_duration *= 1.5
        
        # Adjust for word length
        length = len(word)
        if length > 8:
            base_duration *= 1.3
        elif length < 3:
            base_duration *= 0.8
        
        return base_duration
    
    def format_word_orp(self, word, width=40):
        """Format word with ORP highlighted and centered"""
        if not word:
            return ' ' * width
        
        orp = self.calculate_orp(word)
        
        # Split word at ORP
        before = word[:orp]
        focus = word[orp] if orp < len(word) else ''
        after = word[orp+1:] if orp+1 < len(word) else ''
        
        # Center the ORP position
        center = width // 2
        
        # Build the formatted string
        padding_before = ' ' * (center - len(before))
        padding_after = ' ' * (width - (center + len(focus) + len(after)))
        
        # Use ANSI codes for emphasis on the ORP character
        formatted = f"{padding_before}{before}\033[1;31m{focus}\033[0m{after}{padding_after}"
        
        return formatted


def clear_screen():
    """Clear the terminal screen"""
    os.system('clear' if os.name != 'nt' else 'cls')


def read_text_file(filepath):
    """Read and return text from file"""
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            return f.read()
    except FileNotFoundError:
        print(f"Error: File '{filepath}' not found")
        sys.exit(1)
    except Exception as e:
        print(f"Error reading file: {e}")
        sys.exit(1)


def prepare_words(text):
    """Split text into words, preserving punctuation"""
    # Simple split - keeps punctuation attached to words
    words = text.split()
    # Filter out empty strings
    return [w for w in words if w.strip()]


def display_rsvp(words, wpm=300):
    """Display words using RSVP technique"""
    engine = RSVPEngine(wpm=wpm)
    
    try:
        for i, word in enumerate(words):
            # Clear screen completely
            clear_screen()
            
            # Add vertical padding to center word on screen
            print("\n" * 12)
            
            # Display only the formatted word (centered and ORP-aligned)
            formatted = engine.format_word_orp(word)
            print(formatted.center(80))
            
            # Wait for calculated duration
            duration = engine.calculate_duration(word)
            time.sleep(duration)
        
        # Done
        clear_screen()
        print("\n" * 10)
        print("=" * 80)
        print("Reading complete!".center(80))
        print("=" * 80)
        print()
        
    except KeyboardInterrupt:
        clear_screen()
        print("\n" * 10)
        print("Reading interrupted.".center(80))
        print()
        sys.exit(0)


def main():
    """Main CLI entry point"""
    if len(sys.argv) < 2:
        print("Usage: python rsvp_cli.py <text_file> [wpm]")
        print("  text_file: Path to .txt file to read")
        print("  wpm: Words per minute (default: 300)")
        print()
        print("Example: python rsvp_cli.py sample.txt 400")
        sys.exit(1)
    
    filepath = sys.argv[1]
    wpm = int(sys.argv[2]) if len(sys.argv) > 2 else 300
    
    # Validate WPM
    if wpm < 50 or wpm > 1500:
        print(f"Error: WPM should be between 50 and 1500 (got {wpm})")
        sys.exit(1)
    
    # Read file
    text = read_text_file(filepath)
    
    # Prepare words
    words = prepare_words(text)
    
    if not words:
        print("Error: No words found in file")
        sys.exit(1)
    
    print(f"\nLoaded {len(words)} words from '{filepath}'")
    print(f"Reading speed: {wpm} WPM")
    print(f"Estimated time: {len(words) / wpm:.1f} minutes")
    print("\nStarting in 3 seconds...")
    time.sleep(3)
    
    # Start RSVP display
    display_rsvp(words, wpm)


if __name__ == "__main__":
    main()
