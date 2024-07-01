import 'package:flutter/material.dart';
import 'package:quick_notes/styles/notes_colors_styles.dart';

import '../../models/notes_models.dart';

// ignore: must_be_immutable
class NoteCard extends StatelessWidget {
  final Note note;
  final Function()? onTap;
  NoteCard({super.key, required this.note, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: StyleNotes.cardsColor[note.color],
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                  color: theme.colorScheme.onSecondaryContainer,
                  spreadRadius: 1,
                  blurRadius: 5 // Mức độ lan tỏa của bóng đổ
                  ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title,
                style: theme.textTheme.titleLarge,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                note.createAt,
                style: theme.textTheme.titleSmall,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                note.content,
                style: theme.textTheme.titleMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
