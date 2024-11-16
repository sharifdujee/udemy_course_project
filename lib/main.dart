import 'package:chat_apps/firebase_options.dart';
import 'package:chat_apps/screen/auth_screen/login_screen.dart';
import 'package:chat_apps/screen/chat/chat_screen.dart';
import 'package:chat_apps/shared/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,

  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //title: 'Flutter Demo',
      theme: ThemeData().copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 63, 17, 177)),

      ),
      home: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return const SplashScreen();
        }
        if(snapshot.hasData){
          return const ChatScreen();
        }
        return const AuthScreen();
      }),
    );
  }
}

