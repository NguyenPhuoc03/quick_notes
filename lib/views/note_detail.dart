import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_notes/controllers/note_controllers.dart';
import 'package:quick_notes/styles/style_app.dart';
import 'package:quick_notes/views/widgets/bottom_sheet_change_color.dart';

import '../models/notes_models.dart';

class NoteDetailPage extends StatefulWidget {
  final Note note;

  const NoteDetailPage({required this.note});

  @override
  State<NoteDetailPage> createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  String date = DateTime.now().toString();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  late int color;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.note.title;
    _contentController.text = widget.note.content;
    color = widget.note.color;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[color],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[color],
        elevation: 0.0,
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return BottomSheetChangeColor(
                        onColorSelected: (int? selectedColor) {
                      setState(() {
                        color = selectedColor!;
                        Provider.of<NotesControllers>(context, listen: false)
                            .updateColor(widget.note.id!, color);
                      });
                    });
                  },
                  barrierColor: Colors.transparent,
                  backgroundColor: Colors.grey.shade200,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                );
              },
              icon: Icon(Icons.palette_outlined)),
          IconButton(onPressed: () {}, icon: Icon(Icons.check)),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
                controller: _titleController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Note Title",
                ),
                style: AppStyle.mainTitle),
            const SizedBox(
              height: 4,
            ),
            Text(
              widget.note.createAt,
              style: AppStyle.dateTitle,
            ),
            const SizedBox(
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
                style: AppStyle.mainContent),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final note = Note(
            id: widget.note.id,
            title: _titleController.text,
            content: _contentController.text,
            createAt: date,
            color: color,
          );
          NotesControllers notesControllers =
              Provider.of<NotesControllers>(context, listen: false);
          await notesControllers.updateNote(note);
          print(color);
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
              notesControllers.message ?? '',
              type: AnimatedSnackBarType.error,
              brightness: Brightness.light,
              duration: const Duration(milliseconds: 2500),
            ).show(
              context,
            );
          }
          notesControllers.resetStatus();
          Navigator.pop(context);
        },
        backgroundColor: AppStyle.accentColor,
        child: Icon(Icons.save),
      ),
    );
  }
}
