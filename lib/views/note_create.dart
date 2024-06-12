import 'dart:math';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_notes/controllers/note_controllers.dart';
import 'package:quick_notes/models/notes_models.dart';
import 'package:quick_notes/styles/style_app.dart';

class NoteCreatePage extends StatefulWidget {
  const NoteCreatePage({super.key});

  @override
  State<NoteCreatePage> createState() => _NoteCreatePageState();
}

class _NoteCreatePageState extends State<NoteCreatePage> {
  int color_id = Random().nextInt(AppStyle.cardsColor.length);

  String date = DateTime.now().toString();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[color_id],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[color_id],
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Note Title",
            ),
            style: AppStyle.mainTitle,
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            date,
            style: AppStyle.dateTitle,
          ),
          SizedBox(
            height: 28,
          ),
          TextField(
            controller: _contentController,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Note Content",
            ),
            style: AppStyle.mainContent,
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final note = Note(
            title: _titleController.text,
            content: _contentController.text,
            createAt: date,
            color: color_id,
          );
          NotesControllers notesControllers =
              Provider.of<NotesControllers>(context, listen: false);
          await notesControllers.createNote(note);
          if (notesControllers.isSuccess) {
            AnimatedSnackBar.rectangle(
              'Success',
              notesControllers.message ?? '',
              type: AnimatedSnackBarType.success,
              brightness: Brightness.light,
              duration: const Duration(milliseconds: 2500),
            ).show(
              context,
            );
          } else {
            AnimatedSnackBar.rectangle(
              'Error',
              notesControllers.message ?? 'Error',
              type: AnimatedSnackBarType.error,
              brightness: Brightness.light,
              duration: const Duration(milliseconds: 2500),
            ).show(
              context,
            );
          }
          Navigator.pop(context);
        },
        backgroundColor: AppStyle.accentColor,
        child: Icon(Icons.save),
      ),
    );
  }
}
