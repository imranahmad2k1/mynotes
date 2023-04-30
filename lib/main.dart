import 'package:flutter/material.dart';
import 'package:mynotes_practiceproject/constants/routes.dart';
import 'package:mynotes_practiceproject/services/auth/auth_service.dart';
import 'package:mynotes_practiceproject/views/login_view.dart';
import 'package:mynotes_practiceproject/views/notes/new_note_view.dart';
import 'package:mynotes_practiceproject/views/notes/notes_view.dart';
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
      loginRoute: (context) => const LoginView(),
      registerRoute: (context) => const RegisterView(),
      notesRoute: (context) => const NotesView(),
      verifyEmailRoute: (context) => const VerifyEmail(),
      newNoteRoute: (context) => const NewNoteView(), 
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final currentUser = AuthService.firebase().currentUser;
            if (currentUser != null) {
              if (currentUser.isEmailVerified) {
                return const NotesView();
              } else {
                return const VerifyEmail();
              }
            } else {
              return const LoginView();
            }
          default:
            // return const Text("Loading...");
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
