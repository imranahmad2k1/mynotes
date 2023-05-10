import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mynotes_practiceproject/constants/routes.dart';
import 'package:mynotes_practiceproject/services/auth/bloc/auth_bloc.dart';
import 'package:mynotes_practiceproject/services/auth/bloc/auth_event.dart';
import 'package:mynotes_practiceproject/services/auth/bloc/auth_state.dart';
import 'package:mynotes_practiceproject/services/auth/firebase_auth_provider.dart';
import 'package:mynotes_practiceproject/views/login_view.dart';
import 'package:mynotes_practiceproject/views/notes/create_update_note_view.dart';
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
    home: BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(FirebaseAuthProvider()),
      child: const HomePage(),
    ),
    routes: {
      // '/':(context) => const HomePage(),
      loginRoute: (context) => const LoginView(),
      registerRoute: (context) => const RegisterView(),
      notesRoute: (context) => const NotesView(),
      verifyEmailRoute: (context) => const VerifyEmail(),
      createOrUpdateNoteRoute: (context) => const CreateOrUpdateNoteView(),
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          return const NotesView();
        } else if (state is AuthStateNeedsVerification) {
          return const VerifyEmail();
        } else if (state is AuthStateLoggedOut) {
          return const LoginView();
        } else {
          return const Scaffold(
            body: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
