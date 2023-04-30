import 'package:flutter/material.dart';
import 'package:mynotes_practiceproject/services/crud/notes_service.dart';
import 'package:mynotes_practiceproject/utilities/dialogs/delete_dialog.dart';

typedef NoteCallback = void Function(DatabaseNote note);

class NotesListView extends StatelessWidget {
  final List<DatabaseNote> notes;
  final NoteCallback onDeleteNote;
  final NoteCallback onTapNote;

  const NotesListView(
      {super.key,
      required this.notes,
      required this.onDeleteNote,
      required this.onTapNote});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes[index];
        return ListTile(
          title: Text(
            note.text,
            maxLines: 1,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: IconButton(
              onPressed: () async {
                final shouldDelete = await showDeleteDialog(context);
                if (shouldDelete) {
                  onDeleteNote(note);
                }
              },
              icon: const Icon(Icons.delete)),
          onTap: ()  {
            onTapNote(note);
          },
        );
      },
    );
  }
}
