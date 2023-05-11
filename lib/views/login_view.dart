import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mynotes_practiceproject/constants/routes.dart';
import 'package:mynotes_practiceproject/services/auth/auth_exceptions.dart';
import 'package:mynotes_practiceproject/services/auth/bloc/auth_bloc.dart';
import 'package:mynotes_practiceproject/services/auth/bloc/auth_event.dart';
import 'package:mynotes_practiceproject/services/auth/bloc/auth_state.dart';
import 'package:mynotes_practiceproject/utilities/dialogs/error_dialog.dart';

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
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) async {
              if (state is AuthStateLoggedOut) {
                if (state.exception is UserNotFoundAuthException) {
                  await showErrorDialog(context, "User not found");
                } else if (state.exception is WrongPasswordAuthException) {
                  await showErrorDialog(context, "Invalid password");
                } else if (state.exception is GenericAuthException) {
                  await showErrorDialog(context, "Authentication error");
                }
              }
            },
            child: TextButton(
              onPressed: () async {
                final email = _email.text;
                final password = _pass.text;
                context.read<AuthBloc>().add(AuthEventLogIn(email, password));
              },
              child: const Text("Login"),
            ),
          ),
          TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, registerRoute, (route) => false);
              },
              child: const Text("Not registered yet? Click here to Register")),
        ],
      ),
    );
  }
}
