import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quick_notes/controllers/note_controllers.dart';
import 'package:quick_notes/models/notes_models.dart';
import 'package:quick_notes/views/note_create.dart';
import 'package:quick_notes/views/widgets/icon_button_column.dart';

import '../styles/style_app.dart';
import 'widgets/note_card.dart';
import 'note_detail.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isDragTargetVisible = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.mainColor,
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          "Quick Notes",
          style: TextStyle(
            color: AppStyle.textColor,
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppStyle.secondaryColor,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.settings,
                color: AppStyle.textColor,
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Consumer<NotesControllers>(
                builder: (context, notesControllers, child) {
                  if (notesControllers.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (notesControllers.notes.isEmpty) {
                    return Text(
                      "There's no Notes",
                      style: GoogleFonts.nunito(
                        color: Colors.white,
                      ),
                    );
                  }
                  return GridView.builder(
                    itemCount: notesControllers.notes.length,
                    itemBuilder: (context, index) {
                      final note = notesControllers.notes[index];
                      return GestureDetector(
                        child: NoteCard(
                          note: note,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NoteDetailPage(
                                        note: note,
                                      )),
                            );
                          },
                        ),
                        onLongPress: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                  color: Colors.white,
                                  height: 100,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      IconButtonColumn(
                                          onPressed: () {},
                                          icon: Icons.lock_outline,
                                          text: "Hide"),
                                      IconButtonColumn(
                                          onPressed: () {},
                                          icon: Icons.push_pin_outlined,
                                          text: "Pin"),
                                      IconButtonColumn(
                                          onPressed: () {},
                                          icon: Icons.share_outlined,
                                          text: "Share"),
                                      IconButtonColumn(
                                          onPressed: () async {
                                            Navigator.pop(context);
                                            await Provider.of<NotesControllers>(
                                                    context,
                                                    listen: false)
                                                .deleteNote(note);
                                            
                                          },
                                          icon: Icons.delete_outlined,
                                          text: "Delete"),
                                    ],
                                  ));
                            },
                          );
                        },
                      );
                    },
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NoteCreatePage()),
          );
        },
        label: const Text("Add Note"),
        icon: Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}
