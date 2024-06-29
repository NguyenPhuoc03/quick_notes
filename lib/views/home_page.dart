import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quick_notes/controllers/note_controllers.dart';
import 'package:quick_notes/views/widgets/icon_button_column.dart';

import 'widgets/note_card.dart';
import 'note_detail.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          "Quick Notes",
          style: theme.appBarTheme.titleTextStyle,
        ),
        backgroundColor: theme.appBarTheme.backgroundColor,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "/setting");
              },
              icon: Icon(
                Icons.settings,
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
                            //# backgroundColor: theme.bottomSheetTheme.backgroundColor,
                            context: context,
                            builder: (context) {
                              return SizedBox(
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
        //# backgroundColor: theme.floatingActionButtonTheme.backgroundColor,
        onPressed: () {
          Navigator.pushNamed(context, "/createNote");
        },
        //# color (label, icon) in theme.colorScheme.onPrimary
        label: const Text("Add Note",),
        icon: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
