import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes_practiceproject/firebase_options.dart';
import 'package:mynotes_practiceproject/views/login_view.dart';
import 'package:mynotes_practiceproject/views/register_view.dart';
import 'package:mynotes_practiceproject/views/verify_email_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const HomePage(),
    routes: {
      // '/':(context) => const HomePage(),
      '/login': (context) => const LoginView(),
      '/register': (context) => const RegisterView(),
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final currentUser = FirebaseAuth.instance.currentUser;
            if (currentUser != null) {
              if (currentUser.emailVerified) {
                print("Email is verified");
              } else {
                return const VerifyEmail();
              }
            } else {
              return const LoginView();
            }
            return const Text("Done");
          default:
            // return const Text("Loading...");
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
