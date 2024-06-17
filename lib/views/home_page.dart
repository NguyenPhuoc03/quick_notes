import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quick_notes/controllers/note_controllers.dart';
import 'package:quick_notes/models/notes_models.dart';
import 'package:quick_notes/views/note_create.dart';
import 'package:quick_notes/views/widgets/custom_note_card.dart';

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
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
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
                        onLongPress: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                color: Colors.white,
                                child: Wrap(
                                  children: <Widget>[
                                    ListTile(
                                      leading: Icon(Icons.delete),
                                      title: Text('Xóa'),
                                      //NotesControllers notesControllers =
                                      //Provider.of<NotesControllers>(context, listen: false);
                                      //await notesControllers.deleteNote(note.data);
                                      onTap: () {},
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.share),
                                      title: Text('Chia sẻ'),
                                      onTap: () {},
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
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
