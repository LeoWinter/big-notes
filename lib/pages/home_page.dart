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

List<Note> notes = [];

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    NoteDatabase.isar.notes.watchLazy(fireImmediately: true).listen(
      (event) async {
        notes = await NoteDatabase.isar.notes.where().findAll();
        print(notes.length);
        setState(() {});
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BigNotes"),
        backgroundColor: Colors.pink.shade800,
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        NoteDatabase().addNote("NOahj", "Ben trucidado");
        setState(() {});
      }),
      body: SafeArea(
        child: getChild(),
      ),
    );
  }

  Widget getChild() {
    if (notes.isEmpty) {
      return const Center(
        child: Text("Não há notas"),
      );
    } else {
      return ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          Note note = notes[index];
          return NoteTile(
            note: note,
          );
        },
      );
    }
  }
}
