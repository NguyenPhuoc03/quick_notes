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
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[color_id],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[color_id],
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              hintText: "Note Title",
              counterText: '',
            ),
            maxLength: 75,
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            date,
            style: theme.textTheme.titleSmall,
          ),
          const SizedBox(
            height: 28,
          ),
          TextField(
            controller: _contentController,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: const InputDecoration(
              hintText: "Note Content",
            ),
            style: theme.textTheme.titleMedium,
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
        child: Icon(Icons.save),
        //# background: fab, color: colorSchema.onPrimary
      ),
    );
  }
}
