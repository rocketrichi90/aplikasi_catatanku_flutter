import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/note.dart';

class NoteService {
  static const _noteKey = 'notes';

  Future<List<Note>> getNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final notesString = prefs.getString(_noteKey);
    if (notesString != null) {
      final List decoded = jsonDecode(notesString);
      return decoded.map((e) => Note.fromJson(e)).toList();
    }
    return [];
  }

  Future<void> saveNotes(List<Note> notes) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(notes.map((e) => e.toJson()).toList());
    await prefs.setString(_noteKey, encoded);
  }
}
