# Book RSVP Speed Reader - MVP Research

## Concept Summary
Mobile app that:
1. Takes camera photo of book page
2. OCRs the text
3. Displays text using RSVP (Rapid Serial Visual Presentation) technique
4. Fixed speed for MVP (~200 WPM)
5. Black screen → single word display → ready for next page

## Key Technology: RSVP (Rapid Serial Visual Presentation)

**What it is:** Speed reading technique that displays one word at a time in the same position, aligned on the "Optimal Reading Point" (ORP) - typically around the first third of the word. This eliminates eye movement and allows much faster reading (300-1000+ WPM).

**Commercial example:** Spritz (spritzinc.com) - pioneered this, but closed/limited API

## Tech Stack Options

### Option 1: React Native (Recommended for MVP)
**Pros:**
- Single codebase for iOS & Android
- Large ecosystem
- Good OCR libraries available

**Key Libraries:**
- **OCR:** `react-native-tesseract-ocr` or `@devinikhiya/react-native-tesseractocr`
  - Wraps Tesseract OCR (open source, very mature)
  - Works on both iOS & Android
  - npm: https://www.npmjs.com/package/react-native-tesseract-ocr
  
- **Camera:** `react-native-camera` (built into most RN setups)

- **RSVP Display:** Roll your own (very simple - just JavaScript timing + text display)

**MVP Complexity:** ~2-3 days for basic working prototype

### Option 2: Flutter
**Pros:**
- Excellent performance
- Great UI framework
- Strong OCR support via ML Kit

**Key Libraries:**
- **OCR:** `google_mlkit_text_recognition` (official Google ML Kit wrapper)
  - More accurate than Tesseract in many cases
  - Better language support
  - Free
  - Package: https://pub.dev/packages/google_mlkit_text_recognition
  
- **Alternative:** `flutter_scalable_ocr` - wrapper around ML Kit with camera viewport control
  - Package: https://pub.dev/packages/flutter_scalable_ocr

- **Camera:** Built-in camera plugin

**MVP Complexity:** ~2-3 days for basic working prototype

### Option 3: Native iOS/Android
**Pros:**
- Maximum performance
- Full platform control

**Cons:**
- Need to build twice (Swift + Kotlin/Java)
- Much longer development time

**Not recommended for MVP**

## Open Source RSVP Implementations to Study

### 1. sprits-it (Most Feature-Complete)
- **Repo:** https://github.com/the-happy-hippo/sprits-it
- **Language:** Python/Flask + JavaScript frontend
- **Features:**
  - Full RSVP implementation with ORP alignment
  - Configurable speed (play/pause/rewind)
  - Punctuation-aware timing
  - Hyphenation for long words
  - Dark/light themes
  - Progress bar
  - Local storage for settings
- **Usefulness:** Can extract the JavaScript RSVP display logic for mobile app
- **License:** Check repo (appears open source)

### 2. speedread (Minimal Terminal Implementation)
- **Repo:** https://github.com/pasky/speedread
- **Language:** Perl (terminal-based)
- **Features:**
  - Basic RSVP with ORP
  - Interactive speed control ([ ] keys)
  - Pause with context
  - Very simple, easy to understand algorithm
- **Usefulness:** Great for understanding the core RSVP algorithm

### 3. OpenSpritz
- **Mentioned in sprits-it** as inspiration
- **Repo:** https://github.com/Miserlou/OpenSpritz
- **Language:** JavaScript bookmarklet
- **Usefulness:** Web-based RSVP implementation

## RSVP Display Algorithm (Simplified)

From studying the open source projects, here's the core algorithm:

```javascript
function displayWord(word, wpm) {
  // 1. Calculate Optimal Reading Point (ORP)
  let orp;
  if (word.length <= 1) orp = 0;
  else if (word.length <= 5) orp = 1;
  else if (word.length <= 9) orp = 2;
  else if (word.length <= 13) orp = 3;
  else orp = 4;
  
  // 2. Split word at ORP for alignment
  const before = word.substring(0, orp);
  const focus = word[orp];
  const after = word.substring(orp + 1);
  
  // 3. Display with focus character highlighted/bolded
  // (in practice: align all words so the focus char is at screen center)
  
  // 4. Calculate delay based on WPM and punctuation
  let baseDelay = 60000 / wpm; // ms per word
  
  // Adjust for punctuation
  if (word.endsWith('.') || word.endsWith('!') || word.endsWith('?')) {
    baseDelay *= 2.0; // Long pause at sentence end
  } else if (word.endsWith(',') || word.endsWith(';') || word.endsWith(':')) {
    baseDelay *= 1.5; // Medium pause
  }
  
  // Adjust for word length
  if (word.length > 8) {
    baseDelay *= 1.3;
  }
  
  setTimeout(() => displayNextWord(), baseDelay);
}
```

## OCR Considerations

### Tesseract vs Google ML Kit

**Tesseract:**
- Pros: Completely offline, free, works everywhere
- Cons: Slower, less accurate on complex layouts
- Best for: Simple book pages with clear text

**Google ML Kit:**
- Pros: Fast, accurate, handles complex layouts
- Cons: May require cloud API calls for best accuracy (but on-device mode exists)
- Best for: Any text, especially varied fonts/layouts

**MVP Recommendation:** Start with Google ML Kit (Flutter) or Tesseract (React Native) - both are free for on-device processing.

### OCR Challenges for Books
- **Curved pages** - need to handle page curvature
- **Shadows** - camera flash/lighting
- **Font variety** - different book fonts
- **Page numbers/headers** - may want to filter these out

**MVP Solution:** For MVP, just accept "best effort" OCR. Users can retake photo if quality is bad.

## MVP Implementation Plan

### Phase 1: Basic Flow (Day 1)
1. Camera capture screen
2. Take photo on tap
3. Run OCR on photo
4. Display "Processing..." loader
5. Show RSVP display at fixed 200 WPM
6. "Ready for next page" button when done

### Phase 2: RSVP Polish (Day 2)
1. Implement proper ORP alignment
2. Add punctuation-aware pausing
3. Add progress indicator (word X of Y)
4. Black background with white text
5. Large, readable font

### Phase 3: Basic Controls (Day 3)
1. Pause/resume button
2. Replay current page button
3. Maybe: simple speed adjustment (150/200/250 WPM)

## Development Steps

### React Native Path

```bash
# 1. Create new React Native project
npx react-native init BookRSVP

# 2. Install dependencies
npm install react-native-tesseract-ocr
npm install react-native-camera
npm install react-native-fs  # for file handling

# 3. Project structure
src/
  components/
    CameraCapture.js
    RSVPReader.js
    ProcessingScreen.js
  utils/
    ocrService.js
    rsvpEngine.js
  screens/
    HomeScreen.js
    ReadingScreen.js
```

### Flutter Path

```bash
# 1. Create new Flutter project
flutter create book_rsvp

# 2. Add dependencies to pubspec.yaml
dependencies:
  google_mlkit_text_recognition: ^0.12.0
  camera: ^0.11.0
  
# 3. Project structure
lib/
  screens/
    camera_screen.dart
    reading_screen.dart
  widgets/
    rsvp_display.dart
  services/
    ocr_service.dart
    rsvp_engine.dart
```

## Key Implementation Details

### Camera → OCR Flow
```
1. User taps screen
2. Capture full-resolution image
3. Show loading screen
4. Pass image to OCR library
5. OCR returns recognized text blocks
6. Concatenate blocks into single text string
7. Split into words
8. Start RSVP engine
```

### RSVP Display Requirements
- **Fixed position:** Word anchor point (ORP) must stay in exact same spot
- **Large font:** 32-48pt minimum for comfortable reading
- **High contrast:** White text on black (or vice versa)
- **No animations/transitions:** Just instant word swaps
- **Centered vertically and horizontally**

### State Management
```javascript
// Minimal state for MVP
{
  mode: 'camera' | 'processing' | 'reading' | 'done',
  currentText: string,
  words: array,
  currentWordIndex: number,
  isPaused: boolean,
  wpm: 200
}
```

## Gotchas & Tips

1. **Camera permissions:** Handle properly on both iOS & Android
2. **OCR language:** Default to English for MVP, expand later
3. **Memory:** Clear captured images after OCR to avoid memory issues
4. **Orientation lock:** Lock to portrait for MVP
5. **Word splitting:** Handle hyphens, em-dashes, and contractions properly
6. **Timer accuracy:** Use high-resolution timer for consistent WPM

## Future Enhancements (Post-MVP)

- Variable speed adjustment
- Bookmarking / session saving
- Multiple language support
- OCR quality feedback ("retake photo")
- Advanced controls (skip back/forward by sentence)
- Reading statistics
- Integration with book tracking apps
- PDF import (skip camera entirely)
- Text highlighting/notes

## Similar Apps to Study

- **Spritz** (original, but SDK not freely available)
- **Reedy** (iOS speed reader with RSVP)
- **ReadMe!** (Android, has issues with e-ink per Reddit)
- **Moon+ Reader** (Android, has RSVP mode built in)

## Estimated Timeline

**MVP (camera → OCR → basic RSVP):**
- Setup & initial screens: 4-6 hours
- OCR integration: 3-4 hours
- RSVP engine: 4-6 hours
- Testing & polish: 4-6 hours
- **Total: 15-22 hours** (~2-3 full days)

**Beta (with controls & polish):**
- Add 2-3 more days for UX improvements, testing, bug fixes

## Recommendation

**Go with Flutter + Google ML Kit** for the MVP:
1. Fastest path to working prototype
2. ML Kit gives best OCR results out of the box
3. Flutter UI is beautiful by default
4. Single codebase for iOS & Android
5. Easy to iterate quickly

**Alternative:** React Native if you're already familiar with it, but Flutter will be faster for this specific use case.

## Next Steps

1. Choose framework (Flutter recommended)
2. Set up basic project with camera
3. Integrate OCR library and test with a book page
4. Build RSVP display component (reference sprits-it JavaScript)
5. Wire everything together
6. Test with various book types and lighting conditions
7. Polish and iterate

---

**Questions to Answer Before Starting:**

1. Target platforms? (iOS only, Android only, or both?)
2. Have you developed mobile apps before? (affects framework choice)
3. Do you want to start with a working proof-of-concept or go straight to polished UI?
4. Any specific books/fonts you want to test with?

Let me know if you want me to scaffold out actual starter code for either Flutter or React Native!
