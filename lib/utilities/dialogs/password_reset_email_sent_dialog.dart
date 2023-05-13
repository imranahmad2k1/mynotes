import 'package:flutter/material.dart';
import 'package:mynotes_practiceproject/utilities/dialogs/generic_dialog.dart';

Future<void> showPasswordResetSentDialog(BuildContext context) {
  return genericDialog<void>(
    context: context,
    title: 'Password reset',
    content:
        'We have now sent an email to you containing password reset link. Please check your email',
    optionsBuilder: () => {
      'OK': null,
    },
  );
}
