import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _pass;

  @override
  void initState() {
    _email = TextEditingController();
    _pass = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: Column(
        children: [
          TextField(
            controller: _email,
            autocorrect: false,
            enableSuggestions: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: 'Enter your email'),
          ),
          TextField(
            controller: _pass,
            obscureText: true,
            decoration: const InputDecoration(hintText: 'Enter your password'),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _pass.text;
              try {
                final loginCredentials = await FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                        email: email, password: password);
                devtools.log(loginCredentials.toString());
              } on FirebaseAuthException catch (e) {
                if (e.code == 'weak-password'){
                  devtools.log("Weak password");
                }
                else if (e.code == 'email-already-in-use'){
                  devtools.log("Email is already in use");
                }
                else if (e.code == 'invalid-email') {
                  devtools.log("Invalid email");
                }
              }
            },
            child: const Text("Register Now"),
          ),
          TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/login', (route) => false);
              },
              child: const Text("Already registered? Click here to Login"))
        ],
      ),
    );
  }
}
