import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:chat_app/assets/theme.dart';
import 'package:chat_app/helpers/loading_indicator.dart';
import 'package:chat_app/screens/auth_screen.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _flutterFireInitialization =
      Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _flutterFireInitialization,
      builder: (_ctx, _snapshot) {
        if (_snapshot.hasError) {
          return const Text('Something Went Wrong');
        }
        if (_snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Baatein Karo',
            theme: themeData(),
            home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (_ctx, _user) {
                if (_user.connectionState == ConnectionState.waiting) {
                  return const SplashScreen();
                }
                if (_user.hasData) {
                  return const ChatScreen();
                } else {
                  return const AuthScreen();
                }
              },
            ),
          );
        }
        return const AdaptiveCircularProgressIndicator();
      },
    );
  }
}
