import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quick_notes/controllers/note_controllers.dart';
import 'package:quick_notes/models/notes_models.dart';
import 'package:quick_notes/views/note_create.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.mainColor,
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          "Quick Notes",
          style: TextStyle(
            color: Colors.white,
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppStyle.mainColor,
        actions: [],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your recent Notes",
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(
              height: 20,
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
                      return LongPressDraggable<Note>(
                        data: note,
                        //hien thi khi giu phan tu duoc keo
                        feedback: Material(
                          color: Colors.transparent,
                          child: NoteCard(
                            note: note,
                            onTap: () {},
                          ),
                        ),
                        //hien thi phan mat sau, sau khi keo
                        childWhenDragging: Container(
                          color: Colors.transparent,
                        ),
                        //hien thi sau sau khi load gridview
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
                        onDragStarted: () {
                          // set dieu kien khi keo
                          setState(() {
                            _isDragTargetVisible = true;
                          });
                        },
                        onDraggableCanceled: (_, __) {
                          // an DragTarget khi huy keo
                          setState(() {
                            _isDragTargetVisible = false;
                          });
                        },
                        onDragEnd: (_) {
                          setState(() {
                            _isDragTargetVisible = false;
                          });
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
            Visibility(
              visible: _isDragTargetVisible, // Hiển thị hoặc ẩn DragTarget
              child: DragTarget<Note>(
                onAcceptWithDetails: (DragTargetDetails<Note> note) async {
                  NotesControllers notesControllers =
                      Provider.of<NotesControllers>(context, listen: false);
                  await notesControllers.deleteNote(note.data);
                },
                builder: (context, candidateData, rejectedData) {
                  return Stack(children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 1,
                            color: Colors.white,
                          )),
                    ),
                    Positioned(
                      top: 25,
                      left: 25,
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 50,
                      ),
                    )
                  ]);
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
        icon: Icon(Icons.add),
      ),
    );
  }
}
