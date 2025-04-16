import 'add_edit_note_screen.dart';
import 'package:flutter/material.dart';
import '../models/note.dart';
import '../services/note_service.dart';
import 'detail_note_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NoteService _noteService = NoteService();
  List<Note> _notes = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final notes = await _noteService.getNotes();
    setState(() {
      _notes = notes;
    });
  }

  Future<void> _deleteNote(String id) async {
    _notes.removeWhere((note) => note.id == id);
    await _noteService.saveNotes(_notes);
    setState(() {});
  }

  void _navigateToAddEdit([Note? note]) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AddEditNoteScreen(note: note)),
    );
    if (result == true) {
      _loadNotes();
    }
  }

  void _navigateToDetail(Note note) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DetailNoteScreen(note: note)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Daftar Catatan")),
      body:
          _notes.isEmpty
              ? const Center(child: Text("Belum ada catatan"))
              : ListView.builder(
                itemCount: _notes.length,
                itemBuilder: (context, index) {
                  final note = _notes[index];
                  return ListTile(
                    title: Text(note.title),
                    onTap: () => _navigateToDetail(note),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _navigateToAddEdit(note),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteNote(note.id),
                        ),
                      ],
                    ),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddEdit(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
