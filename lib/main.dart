import 'package:flutter/material.dart';
import 'screens/camera_screen.dart';

void main() {
  runApp(const BookRSVPApp());
}

class BookRSVPApp extends StatelessWidget {
  const BookRSVPApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book RSVP Reader',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CameraScreen(),
    );
  }
}
