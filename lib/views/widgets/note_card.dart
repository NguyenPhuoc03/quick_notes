import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quick_notes/styles/style_app.dart';

import '../../models/notes_models.dart';

// ignore: must_be_immutable
class NoteCard extends StatelessWidget {
  final Note note;
  final Function()? onTap;
  NoteCard({super.key, required this.note, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: AppStyle.cardsColor[note.color],
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title,
                style: AppStyle.mainTitle,
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                note.createAt,
                style: AppStyle.dateTitle,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                note.content,
                style: AppStyle.mainContent,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
