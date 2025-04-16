import 'package:flutter/material.dart';
import '../models/note.dart';

class DetailNoteScreen extends StatelessWidget {
  final Note note;

  const DetailNoteScreen({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail Catatan")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(note.content),
          ],
        ),
      ),
    );
  }
}
