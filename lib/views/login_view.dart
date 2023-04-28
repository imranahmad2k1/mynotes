import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
      appBar: AppBar(title: const Text('Login')),
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
                await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: email, password: password);
                if (context.mounted) {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/notes', (route) => false);
                }
              } on FirebaseAuthException catch (e) {
                if (e.code == 'user-not-found') {
                  devtools.log("User not found");
                } else if (e.code == 'invalid-email') {
                  devtools.log("Invalid Email");
                } else if (e.code == 'wrong-password') {
                  devtools.log("Invalid password");
                }
              }
            },
            child: const Text("Login"),
          ),
          TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/register', (route) => false);
              },
              child: const Text("Not registered yet? Click here to Register")),
        ],
      ),
    );
  }
}
