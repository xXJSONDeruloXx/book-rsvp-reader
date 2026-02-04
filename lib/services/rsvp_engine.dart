/// RSVP Engine - handles word-by-word display timing and logic
class RSVPEngine {
  final int wordsPerMinute;
  
  RSVPEngine({this.wordsPerMinute = 200});
  
  /// Calculate optimal reading point (ORP) for a word
  /// ORP is the character position where the eye should focus
  int calculateORP(String word) {
    final length = word.length;
    if (length <= 1) return 0;
    if (length <= 5) return 1;
    if (length <= 9) return 2;
    if (length <= 13) return 3;
    return 4;
  }
  
  /// Calculate display duration for a word (in milliseconds)
  /// Adjusts based on word length and punctuation
  int calculateDuration(String word) {
    // Base duration from WPM
    double baseDuration = 60000.0 / wordsPerMinute;
    
    // Adjust for punctuation
    if (word.endsWith('.') || word.endsWith('!') || word.endsWith('?')) {
      baseDuration *= 2.0; // Long pause at sentence end
    } else if (word.endsWith(',') || word.endsWith(';') || word.endsWith(':')) {
      baseDuration *= 1.5; // Medium pause
    }
    
    // Adjust for word length
    if (word.length > 8) {
      baseDuration *= 1.3;
    } else if (word.length < 3) {
      baseDuration *= 0.8;
    }
    
    return baseDuration.round();
  }
  
  /// Split word into parts for ORP-aligned display
  /// Returns: [before_orp, focus_char, after_orp]
  List<String> splitWordAtORP(String word) {
    final orp = calculateORP(word);
    if (orp >= word.length) {
      return [word, '', ''];
    }
    
    return [
      word.substring(0, orp),
      word[orp],
      orp + 1 < word.length ? word.substring(orp + 1) : '',
    ];
  }
}
