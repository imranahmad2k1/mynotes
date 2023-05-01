import 'package:flutter/material.dart';
import 'package:mynotes_practiceproject/utilities/dialogs/generic_dialog.dart';

Future<void> showCannotShareEmptyNoteDialog(BuildContext context) {
  return genericDialog<void>(
      context: context,
      title: 'Sharing',
      content: 'You cannot share an empty note',
      optionsBuilder: () => {
            'OK': null,
          });
}
