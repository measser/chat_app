import 'package:chat_app/bloc/auth_bloc.dart';
import 'package:chat_app/cubits/chat/chat_cubit.dart';
import 'package:chat_app/cubits/register/register_cubit.dart';
import 'package:chat_app/observers.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/screens/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';

void main() async {
  Bloc.observer=SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ScholarChat());
}

class ScholarChat extends StatelessWidget {
  const ScholarChat({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
         BlocProvider(create: (context)=>AuthBloc()),
         BlocProvider(create: (context)=>ChatCubit()),
      ],
      child: MaterialApp(
        routes: {
          RegisterScreen.id: (context) => RegisterScreen(),
          ChatScreen.id: (context) => ChatScreen(),
          LoginScreen.id: (context) => LoginScreen(),
        },
        initialRoute: LoginScreen.id,
      ),
    );
  }
}

//Icon(Icons.lock_rounded),

// Scaffold(
// appBar: AppBar(),
// body: Align(
// alignment: Alignment.topCenter,
// child: Container(
// width: 250,
// padding: EdgeInsets.all(10),
// margin: EdgeInsets.all(20),
// decoration:BoxDecoration(
// borderRadius: BorderRadius.circular(20),
// color: Colors.blueGrey
// ) ,
// child:Text(
// 'Messages are end-to-end encrypted. No one outside of this chat, not even ChatApp, can red or listen to them. Tap to learn more',
// maxLines: 5,
// overflow: TextOverflow.clip,
// ),
// ),
// ))