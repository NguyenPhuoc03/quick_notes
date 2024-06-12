import 'package:flutter/foundation.dart';
import 'package:quick_notes/models/notes_models.dart';
import 'package:quick_notes/services/notes_services.dart';

class NotesControllers extends ChangeNotifier {
  final NotesServices _notesServices = NotesServices();
  //check loi va da load tu cloud firestore
  bool _isLoading = false;
  bool _isSuccess = false;
  String? _message;
  List<Note> _notes = [];

  //getter
  List<Note> get notes => _notes;
  bool get isLoading => _isLoading;
  bool get isSuccess => _isSuccess;
  String? get message => _message;

  NotesControllers() {
    getNotes();
  }
  void resetStatus() {
    _isLoading = false;
    _isSuccess = false;
    _message = null;
    notifyListeners();
  }

  void getNotes() {
    resetStatus();
    _isLoading = true; //bat dau tai du lieu
    notifyListeners();
    _notesServices.notesStream().listen((list) {
      _notes = list;
      _isLoading = false; //da tai xong
      notifyListeners();
    }).onError((error) {
      _isLoading = true; //co loi va dung lai
      _message = error.toString();
      print("Error: ${_message}");
      notifyListeners();
    });
  }

  Future<void> createNote(Note note) async {
    resetStatus();
    try {
      _isSuccess = await _notesServices.createNote(note);
      _message = _isSuccess
          ? "New note created successfully!"
          : "New note created unsuccessfully!";
    } catch (e) {
      _message = "New note created unsuccessfully!";
      print("Error: ${e.toString()}");
    } finally {
      notifyListeners();
    }
  }

  Future<void> updateNote(Note note) async {
    resetStatus();
    try {
      _isSuccess = await _notesServices.updateNote(note);
      _message = _isSuccess
          ? "Update note successfully!"
          : "Update note unsuccessfully!";
    } catch (e) {
      _message = "Update note unsuccessfully!";
      print("Error: ${e.toString()}");
    } finally {
      notifyListeners();
    }
  }

  Future<void> deleteNote(Note note) async {
    resetStatus();
    try {
      _isSuccess = await _notesServices.deleteNote(note);
      _message = _isSuccess
          ? "Delete note successfully!"
          : "Delete note unsuccessfully!";
    } catch (e) {
      _message = "Delete note unsuccessfully!";
      print("Error: ${e.toString()}");
    } finally {
      notifyListeners();
    }
  }
}
