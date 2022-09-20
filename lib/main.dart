import 'package:chatroom/screens/splash_screen.dart';
import 'package:chatroom/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:chatroom/screens/registration_screen.dart';
import 'package:chatroom/screens/chat_screen.dart';
import 'package:chatroom/screens/welcome_screen.dart';
import 'package:chatroom/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData.dark().copyWith(
      //   // textTheme: TextTheme(
      //   //   bodyText1: TextStyle(color: Colors.black54),
      //   // ),
      // ),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context)=>SplashScreen(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ChatScreen.id: (context) => ChatScreen(),
      },
    );
  }
}
