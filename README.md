# Book RSVP Speed Reader

Mobile app for speed-reading physical books using camera OCR and RSVP (Rapid Serial Visual Presentation) technology.

## Concept

1. **Capture** - Point camera at book page, tap to capture
2. **Process** - OCR extracts text from image
3. **Read** - Display text one word at a time using RSVP technique
4. **Repeat** - Move to next page when done

## RSVP (Rapid Serial Visual Presentation)

Speed reading technique that displays one word at a time in a fixed position, aligned on the "Optimal Reading Point" (ORP). This eliminates eye movement and allows reading speeds of 300-1000+ words per minute.

- Words appear centered at the same spot
- ORP (typically 1st-3rd letter) stays fixed
- Timing adjusts for word length and punctuation
- Black background, white text, large font

## Tech Stack (Recommended)

### Flutter + Google ML Kit

**Why:**
- Single codebase for iOS & Android
- Google ML Kit provides excellent free OCR
- Beautiful UI out of the box
- Fast iteration

**Key Dependencies:**
- `google_mlkit_text_recognition` - OCR
- `camera` - Image capture
- Custom RSVP engine (~100 lines)

## Project Status

**Current:** Research & planning phase

**Next Steps:**
1. Set up Flutter project
2. Implement camera capture
3. Integrate OCR
4. Build RSVP display engine
5. Wire together full flow

## MVP Features

- ✅ Camera capture
- ✅ OCR text extraction
- ✅ Basic RSVP display (fixed 200 WPM)
- ✅ Progress indicator
- ✅ Pause/resume
- ✅ "Next page" prompt

## Future Enhancements

- Variable speed control (150-500+ WPM)
- Skip forward/backward by sentence
- Session bookmarking
- Reading statistics
- Multi-language support
- PDF import (skip camera)
- Dark/light theme toggle

## Development Timeline

**MVP:** 2-3 full days (~15-22 hours)
- Camera + OCR: 6-10 hours
- RSVP engine: 4-6 hours
- UI polish: 4-6 hours

## Documentation

See `docs/RESEARCH.md` for:
- Full technical analysis
- RSVP algorithm details
- OCR library comparison
- Implementation guide
- Open source references

## License

TBD

## Author

Kurt (@xXJSONDeruloXx)
