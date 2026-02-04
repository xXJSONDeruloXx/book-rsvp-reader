# Flutter Development Setup Guide

## Prerequisites Check

You're on a Mac Mini M1, so you have the right hardware. Let's get you set up for iOS development first.

## Step 1: Install Flutter

### Option A: Using Homebrew (Recommended)
```bash
# Install Flutter
brew install flutter

# Verify installation
flutter doctor
```

### Option B: Manual Install
```bash
# Download Flutter SDK
cd ~/development
git clone https://github.com/flutter/flutter.git -b stable

# Add to PATH (add to ~/.zshrc or ~/.bash_profile)
export PATH="$PATH:$HOME/development/flutter/bin"

# Verify
flutter doctor
```

## Step 2: Install Xcode Command Line Tools

**You DON'T need the full Xcode IDE**, but you need the command line tools and simulator:

```bash
# Install Xcode from App Store (unfortunately required for iOS Simulator)
# OR download from https://developer.apple.com/download/

# Once Xcode is installed, install command line tools
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -runFirstLaunch

# Accept license
sudo xcodebuild -license accept

# Install CocoaPods (iOS dependency manager)
sudo gem install cocoapods
```

## Step 3: Install VS Code Extensions

1. Open VS Code
2. Install these extensions:
   - **Flutter** (by Dart Code)
   - **Dart** (by Dart Code)

These give you:
- Syntax highlighting
- IntelliSense
- Debugging
- Hot reload
- Device selection

## Step 4: Verify Setup

```bash
cd ~/path/to/book-rsvp-reader
flutter doctor -v
```

You should see:
```
[✓] Flutter (Channel stable, 3.x.x)
[✓] Xcode - develop for iOS
[✓] VS Code (version x.x.x)
[✓] Connected device
```

**Don't worry if Android checks fail** - you're starting with iOS!

## Step 5: Create iOS Simulator

```bash
# List available simulators
xcrun simctl list devices

# Create an iPhone simulator (if none exist)
xcrun simctl create "iPhone 15" "iPhone 15"

# Open simulator
open -a Simulator
```

**Or:** Use VS Code's device picker (bottom right corner)

## Step 6: Run Your First Flutter App

```bash
cd ~/path/to/book-rsvp-reader

# Get dependencies
flutter pub get

# Run on simulator (with hot reload!)
flutter run
```

**VS Code Method:**
1. Open project in VS Code
2. Press `F5` or click "Run > Start Debugging"
3. Select iOS Simulator from device picker

## Development Workflow (The Fun Part!)

### Hot Reload = Game Changer 🔥

Unlike traditional iOS dev, Flutter has **hot reload**:

1. App is running on simulator
2. Edit Dart code
3. Save file or press `r` in terminal
4. Changes appear INSTANTLY (< 1 second)

No rebuilding, no recompiling, no waiting!

### VS Code Workflow

```
1. Open project in VS Code
2. Start simulator (if not running)
3. Press F5 to launch app
4. Edit code
5. Save (Cmd+S) → hot reload happens automatically
6. See changes instantly
```

### Testing on Real iPhone (Optional)

You CAN test on a physical iPhone, but it requires:
- Apple Developer account (free tier works)
- USB cable
- Trust certificate setup

**For MVP, stick with simulator** - it's easier.

## Android Setup (Later, When Needed)

When you're ready to support Android:

```bash
# Install Android Studio command line tools only
brew install --cask android-commandlinetools

# Set environment variables
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Install SDK components
sdkmanager "platform-tools" "platforms;android-33" "build-tools;33.0.0"

# Create emulator
avdmanager create avd -n Pixel_7 -k "system-images;android-33;google_apis;arm64-v8a"
```

But honestly, **cross that bridge when you get there**. iOS first!

## Common Issues & Fixes

### "Xcode version too old"
```bash
# Update Xcode from App Store
# Then re-run:
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
```

### "CocoaPods not found"
```bash
sudo gem install cocoapods
pod setup
```

### "Flutter command not found"
Add Flutter to PATH in `~/.zshrc`:
```bash
export PATH="$PATH:$HOME/development/flutter/bin"
```

### Simulator won't launch
```bash
# Reset simulator
xcrun simctl erase all

# Or open manually
open -a Simulator
```

## Your Actual Development Environment

**What you'll use:**
- ✅ **VS Code** - your main editor (same as regular coding)
- ✅ **Terminal** - for `flutter run`, `flutter pub get`, etc.
- ✅ **iOS Simulator** - for testing (runs in separate window)
- ❌ **Xcode IDE** - you won't actually use this (just needs to be installed)

**What it looks like:**
```
┌─────────────────────────────┐
│  VS Code                    │  ← Edit Dart code here
│  - Syntax highlighting      │
│  - IntelliSense             │
│  - Debugging                │
└─────────────────────────────┘
         ↓ Save (Cmd+S)
         ↓ Hot reload (< 1s)
         ↓
┌─────────────────────────────┐
│  iOS Simulator              │  ← See changes instantly
│  ┌─────────────────────┐    │
│  │                     │    │
│  │   Your App Running  │    │
│  │                     │    │
│  └─────────────────────┘    │
└─────────────────────────────┘
```

## Next Steps After Setup

1. **Run the skeleton app** to verify everything works
2. **Uncomment dependencies** in `pubspec.yaml`
3. **Add camera package** and test camera preview
4. **Implement OCR** with sample image
5. **Build RSVP display** (engine logic already done!)

## Resources

- **Flutter Docs:** https://docs.flutter.dev/get-started/install/macos
- **VS Code Flutter:** https://docs.flutter.dev/tools/vs-code
- **Flutter Samples:** https://flutter.github.io/samples/

## TL;DR

**You don't need to learn Xcode or Android Studio!**

Just:
1. Install Flutter CLI
2. Install Xcode (for iOS Simulator only)
3. Use VS Code like you normally would
4. Run `flutter run` and enjoy hot reload magic

It's much more similar to web development than traditional mobile dev. You're writing Dart (similar to JavaScript/TypeScript) and seeing instant changes.

**Start with iOS, worry about Android later.**
