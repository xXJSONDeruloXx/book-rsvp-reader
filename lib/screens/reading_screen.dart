import 'package:flutter/material.dart';

/// RSVP Reader Screen - displays text one word at a time
/// TODO: Implement RSVP display logic
class ReadingScreen extends StatefulWidget {
  final String text;
  final int wordsPerMinute;

  const ReadingScreen({
    super.key,
    required this.text,
    this.wordsPerMinute = 200,
  });

  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  int currentWordIndex = 0;
  bool isPaused = false;
  late List<String> words;

  @override
  void initState() {
    super.initState();
    // Split text into words
    words = widget.text.split(RegExp(r'\s+'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Progress indicator
            LinearProgressIndicator(
              value: words.isEmpty ? 0 : currentWordIndex / words.length,
              backgroundColor: Colors.grey[800],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            
            // RSVP display area
            Expanded(
              child: Center(
                child: Text(
                  currentWordIndex < words.length 
                      ? words[currentWordIndex] 
                      : 'Done!',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            
            // Controls
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(
                      isPaused ? Icons.play_arrow : Icons.pause,
                      color: Colors.white,
                      size: 40,
                    ),
                    onPressed: () {
                      setState(() {
                        isPaused = !isPaused;
                      });
                      // TODO: Implement pause/resume logic
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.replay,
                      color: Colors.white,
                      size: 40,
                    ),
                    onPressed: () {
                      setState(() {
                        currentWordIndex = 0;
                        isPaused = false;
                      });
                      // TODO: Restart RSVP from beginning
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 40,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: Clean up timer
    super.dispose();
  }
}
