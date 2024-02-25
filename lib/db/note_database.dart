import 'package:big_notes/model/note.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class NoteDatabase {
  static late Isar isar;
  static List<Note> currentNote = [];

  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [NoteSchema],
      directory: dir.path,
    );
    await isar.txn(
      () async {
        final noteCollection = isar.notes;
        currentNote = await noteCollection.where().findAll();
      },
    );
  }

  Future<void> addNote(String title, String text) async {
    print('Adicionando nova nota: $title, $text');
    final newNote = Note()
      ..title = title
      ..text = text;
    await isar.writeTxn(() => isar.notes.put(newNote));
    currentNote.add(newNote);
    print('Nota adicionada com sucesso!');
  }

  Future<void> removeNote(int id) async {
    print('Removendo nota com ID: $id');
    Note? note = await isar.notes.get(id);
    bool delete = await isar.writeTxn(() => isar.notes.delete(id));
    if (delete) currentNote.remove(note);
    print('Removida a nota com ID: $id');
  }

  Future<void> updateNote(int id, String? title, String? text) async {
    final note = await isar.notes.get(id);
    if (note != null) {
      currentNote.remove(note);
      if (title != null) {
        note.title = title;
      }
      if (text != null) {
        note.text = text;
      }
      await isar.writeTxn(() => isar.notes.put(note));
      currentNote.add(note);
    }
  }
}
