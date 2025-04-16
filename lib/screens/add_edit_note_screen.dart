import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/note.dart';
import '../services/note_service.dart';

class AddEditNoteScreen extends StatefulWidget {
  final Note? note;

  const AddEditNoteScreen({super.key, this.note});

  @override
  State<AddEditNoteScreen> createState() => _AddEditNoteScreenState();
}

class _AddEditNoteScreenState extends State<AddEditNoteScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final NoteService _noteService = NoteService();
  List<Note> _notes = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _contentController.text = widget.note!.content;
    }
  }

  Future<void> _loadNotes() async {
    _notes = await _noteService.getNotes();
  }

  Future<void> _saveNote() async {
    if (_titleController.text.isEmpty || _contentController.text.isEmpty) return;

    if (widget.note != null) {
      // Edit
      final index = _notes.indexWhere((n) => n.id == widget.note!.id);
      if (index != -1) {
        _notes[index] = Note(
          id: widget.note!.id,
          title: _titleController.text,
          content: _contentController.text,
        );
      }
    } else {
      // Tambah
      final newNote = Note(
        id: const Uuid().v4(),
        title: _titleController.text,
        content: _contentController.text,
      );
      _notes.add(newNote);
    }

    await _noteService.saveNotes(_notes);
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.note != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? "Edit Catatan" : "Tambah Catatan")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: "Judul"),
            ),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(labelText: "Isi Catatan"),
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveNote,
              child: const Text("Simpan"),
            )
          ],
        ),
      ),
    );
  }
}
