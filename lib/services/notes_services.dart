import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quick_notes/models/notes_models.dart';

class NotesServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Note>> notesStream() {
    return _firestore.collection('Notes').snapshots().map((snapshot) {
      List<Note> notes = [];
      snapshot.docs.forEach((element) {
        notes.add(Note.fromJson(element.id, element.data()));
      });
      return notes;
    });
  }

  Future<bool> createNote(Note note) async {
    try {
      await _firestore.collection('Notes').add(note.toJson());
      return true;
    } catch (e) {
      print("Error: ${e.toString()}");
      return false;
    }
  }

  Future<bool> updateNote(Note note) async {
    try {
      await _firestore.collection('Notes').doc(note.id).update({
        'title': note.title,
        'content': note.content,
        'color_id': note.color,
        'createAt': note.createAt,
      });
      return true;
    } catch (e) {
      print("Error: ${e.toString()}");
      return false;
    }
  }

    Future<bool> updateColor(String id, int color) async {
    try {
      await _firestore.collection('Notes').doc(id).update({
        'color_id': color,
      });
      return true;
    } catch (e) {
      print("Error: ${e.toString()}");
      return false;
    }
  }

  Future<bool> deleteNote(Note note) async {
    try {
      await _firestore.collection('Notes').doc(note.id).delete();
      return true;
    } catch (e) {
      print("Error: ${e.toString()}");
      return false;
    }
  }
}
