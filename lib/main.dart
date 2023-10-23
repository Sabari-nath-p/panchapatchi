//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:panthapatchi/Windows/homescreen.dart';
import 'package:panthapatchi/Windows/login.dart';
import 'package:panthapatchi/Windows/selector.dart';
//import 'package:panthapatchi/firebase_options.dart';
import 'package:panthapatchi/homescreen.dart';
import 'package:panthapatchi/login.dart';
import 'package:panthapatchi/newhome.dart';
import 'package:panthapatchi/selector.dart';
import 'package:shared_preferences/shared_preferences.dart';

String log = "";
void main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();
  log = pref.getString("LOGIN").toString();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  //);

  // await Firebase.initializeApp(options: firebaseOptions);

  runApp(panchapatchi());
}

class panchapatchi extends StatelessWidget {
  const panchapatchi({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: (log == "IN") ? windowSelector() : windowsLOgin(),
    );
  }
}
