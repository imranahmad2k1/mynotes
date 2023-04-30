import 'package:flutter/material.dart';
import 'package:mynotes_practiceproject/utilities/dialogs/generic_dialog.dart';

Future<bool> showLogoutDialog(BuildContext context) {
  return genericDialog<bool>(
    context: context,
    title: 'Log out',
    content: 'Are you sure you want to Log out?',
    optionsBuilder: () => {
      'Cancel': false,
      'Log out': true,
    },
  ).then(
    (value) => value ?? false,
  );
}
