import 'package:flutter/material.dart';
import 'screens/intro_screen.dart';

void main() {
  runApp(const NoteApp());
}

class NoteApp extends StatelessWidget {
  const NoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Catatan - Faizal Richi C',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const IntroScreen(),
    );
  }
}
