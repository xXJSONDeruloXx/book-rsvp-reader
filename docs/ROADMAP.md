# Book RSVP Reader - Implementation Roadmap

## Phase 1: Project Setup ✅
- [x] Initialize Flutter project
- [x] Create basic app structure
- [x] Add placeholder screens
- [x] Document RSVP engine logic

## Phase 2: Camera Integration
- [ ] Add camera dependency
- [ ] Implement camera preview
- [ ] Add capture button
- [ ] Handle image storage
- [ ] Request camera permissions (iOS/Android)

## Phase 3: OCR Integration
- [ ] Add Google ML Kit dependency
- [ ] Implement OCR service
- [ ] Process captured images
- [ ] Handle OCR errors
- [ ] Add loading state

## Phase 4: RSVP Engine
- [ ] Implement word timer
- [ ] Calculate ORP positioning
- [ ] Add punctuation delays
- [ ] Implement pause/resume
- [ ] Add progress tracking

## Phase 5: UI Polish
- [ ] Style RSVP display
- [ ] Add visual feedback
- [ ] Implement "next page" flow
- [ ] Add error handling UI
- [ ] Test on real books

## Phase 6: Enhanced Features
- [ ] Variable speed control
- [ ] Skip forward/back
- [ ] Reading statistics
- [ ] Session persistence
- [ ] Settings screen

## Known TODOs

### Camera Screen
- Implement actual camera functionality
- Add flash toggle
- Handle permissions
- Optimize image quality

### Reading Screen
- Wire up RSVP timer
- Implement ORP alignment
- Add word highlighting
- Handle text overflow

### OCR Service
- Integrate ML Kit
- Handle multiple text blocks
- Filter out page numbers/headers
- Improve accuracy

### RSVP Engine
- Test timing accuracy
- Tune duration multipliers
- Handle edge cases (empty words, special chars)
- Add skip-to-sentence feature

## Testing Checklist
- [ ] Test with different book fonts
- [ ] Test with various lighting conditions
- [ ] Test with curved pages
- [ ] Test on iOS
- [ ] Test on Android
- [ ] Battery usage profiling
- [ ] Memory leak testing
