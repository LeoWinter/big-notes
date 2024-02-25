import 'package:big_notes/model/note.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NoteTile extends StatelessWidget {
  const NoteTile({super.key, required this.note});

  final Note note;

  @override
  Widget build(BuildContext context) {
    int hora = note.date.hour;
    int minute = note.date.minute;
    String horario = "$hora:$minute";
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * .15,
        decoration: BoxDecoration(
          color: Colors.greenAccent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    note.title,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Text(
                        DateFormat("dd/MM/yyyy").format(note.date),
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        horario,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    note.text,
                    softWrap: false,
                    overflow: TextOverflow.fade,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
