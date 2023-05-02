import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mynotes_practiceproject/constants/routes.dart';
import 'package:mynotes_practiceproject/services/auth/auth_service.dart';
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
    home: const HomePage(),
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

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: AuthService.firebase().initialize(),
//       builder: (context, snapshot) {
//         switch (snapshot.connectionState) {
//           case ConnectionState.done:
//             final currentUser = AuthService.firebase().currentUser;
//             if (currentUser != null) {
//               if (currentUser.isEmailVerified) {
//                 return const NotesView();
//               } else {
//                 return const VerifyEmail();
//               }
//             } else {
//               return const LoginView();
//             }
//           default:
//             // return const Text("Loading...");
//             return const CircularProgressIndicator();
//         }
//       },
//     );
//   }
// }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Testing bloc'),
        ),
        body: BlocConsumer<CounterBloc, CounterState>(
          listener: (BuildContext context, Object? state) {
            _textEditingController.clear();
          },
          builder: (BuildContext context, state) {
            final invalidValue =
                (state is CounterStateInvalidNumber) ? state.invalidValue : '';
            return Column(children: [
              Text('Current value = ${state.value}'),
              Visibility(
                visible: state is CounterStateInvalidNumber,
                child: Text('Invalid value = $invalidValue'),
              ),
              TextField(
                controller: _textEditingController,
                keyboardType: TextInputType.number,
                decoration:
                    const InputDecoration(hintText: 'Write an integer value'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        context
                            .read<CounterBloc>()
                            .add(IncrementEvent(_textEditingController.text));
                      },
                      icon: const Icon(Icons.add)),
                  IconButton(
                      onPressed: () {
                        context
                            .read<CounterBloc>()
                            .add(DecrementEvent(_textEditingController.text));
                      },
                      icon: const Icon(Icons.remove))
                ],
              ),
            ]);
          },
        ),
      ),
    );
  }
}

@immutable
abstract class CounterState {
  final int value;

  const CounterState(this.value);
}

class CounterStateValid extends CounterState {
  const CounterStateValid(int value) : super(value);
}

class CounterStateInvalidNumber extends CounterState {
  final String invalidValue;

  const CounterStateInvalidNumber(
      {required this.invalidValue, required int previousValue})
      : super(previousValue);
}

@immutable
abstract class CounterEvent {
  final String value;
  const CounterEvent(this.value);
}

class IncrementEvent extends CounterEvent {
  const IncrementEvent(String value) : super(value);
}

class DecrementEvent extends CounterEvent {
  const DecrementEvent(String value) : super(value);
}

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterStateValid(0)) {
    on<IncrementEvent>((event, emit) {
      final integer = int.tryParse(event.value);
      if (integer != null) {
        emit(CounterStateValid(state.value + integer));
      } else {
        emit(CounterStateInvalidNumber(
          invalidValue: event.value,
          previousValue: state.value,
        ));
      }
    });
    on<DecrementEvent>((event, emit) {
      final integer = int.tryParse(event.value);
      if (integer != null) {
        emit(CounterStateValid(state.value - integer));
      } else {
        emit(CounterStateInvalidNumber(
          invalidValue: event.value,
          previousValue: state.value,
        ));
      }
    });
  }
}
