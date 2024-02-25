import 'package:big_notes/db/note_database.dart';
import 'package:big_notes/model/note.dart';
import 'package:big_notes/pages/widgets/note_tile.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final List<Note> notes = [];

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BigNotes"),
        backgroundColor: Colors.pink.shade800,
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        print(NoteDatabase.currentNote.length);
      }),
      body: SafeArea(
        child: gi(
          valueListenable: NoteDatabase.currentNote,
          builder: (context, value, child) {},
        ),
        //child: getChild(),
      ),
    );
  }

  Widget getChild() {
    if (NoteDatabase.currentNote.isEmpty) {
      return const Center(
        child: Text("Não há notas"),
      );
    } else {
      return ListView.builder(
        itemCount: NoteDatabase.currentNote.length,
        itemBuilder: (context, index) {
          Note note = NoteDatabase.currentNote[index];
          return NoteTile(
            note: note,
          );
        },
      );
    }
  }
}
