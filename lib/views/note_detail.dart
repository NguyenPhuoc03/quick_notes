import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_notes/controllers/note_controllers.dart';
import 'package:quick_notes/styles/notes_colors_styles.dart';
import 'package:quick_notes/views/widgets/bottom_sheet_change_color.dart';

import '../models/notes_models.dart';

class NoteDetailPage extends StatefulWidget {
  final Note note;

  const NoteDetailPage({super.key, required this.note});

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
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: StyleNotes.cardsColor[color],
      appBar: AppBar(
        backgroundColor: StyleNotes.cardsColor[color],
        elevation: 0.0,
        actions: [
          IconButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
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
                  //# backgroundColor: theme.bottomSheetTheme.backgroundColor,
                );
              },
              icon: Icon(Icons.palette_outlined)),
          IconButton(
              onPressed: () async {
                FocusScope.of(context).unfocus();
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
              icon: Icon(Icons.check)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
              height: 4,
            ),
            Text(
              widget.note.createAt,
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
          ],
        ),
      ),
    );
  }
}
