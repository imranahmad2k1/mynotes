import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynotes_practiceproject/constants/routes.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify email')),
      body: Column(children: [
        const Text(
            "We've sent you a verification email. Please open the link in verification email to verify your account."),
        const Text(
            "If you haven't received a verification email yet, Press the button below:"),
        TextButton(
          onPressed: () async {
            final currentUser = FirebaseAuth.instance.currentUser;
            await currentUser?.sendEmailVerification();
          },
          child: const Text("Send verification email again"),
        ),
        TextButton(
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            if (context.mounted) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                registerRoute,
                (route) => false,
              );
            }
          },
          child: const Text("Restart"),
        ),
      ]),
    );
  }
}
