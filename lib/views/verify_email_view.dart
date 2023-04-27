import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
        const Text("Please verify your email address:"),
        TextButton(
          onPressed: () async {
            final currentUser = FirebaseAuth.instance.currentUser;
            await currentUser?.sendEmailVerification();
          },
          child: const Text("Send verification email"),
        )
      ]),
    );
  }
}
