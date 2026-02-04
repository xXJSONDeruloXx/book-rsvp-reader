# Book RSVP Speed Reader

for speed-reading physical books using camera OCR and RSVP (Rapid Serial Visual Presentation) technology.

currently a little POC webapp that accepts txt files or pasted in text

play with it at: https://xxjsonderuloxx.github.io/book-rsvp-reader/

## RSVP (Rapid Serial Visual Presentation)

Speed reading technique that displays one word at a time in a fixed position, aligned on the "Optimal Reading Point" (ORP). This eliminates eye movement and allows reading speeds of 300-1000+ words per minute.

- Words appear centered at the same spot
- ORP (typically 1st-3rd letter) stays fixed
- Timing adjusts for word length and punctuation
- Black background, white text, large font

## Tech Stack Maybe

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
