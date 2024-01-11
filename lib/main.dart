import 'package:chatting_app/Signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(apiKey: "AIzaSyCp-HXlG8c_Yyow-MlfzNH2LQMmGjCd0hs", 
    appId: "1:573921554526:android:615e027cc0739319c304cf", 
    messagingSenderId: "573921554526", 
    projectId: "my-firebase-project-76611")
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
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SignUpScreen(),
    );
  }
}

