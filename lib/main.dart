import 'package:flutter/material.dart';
import 'package:sqdlite_/addNotes.dart';
import 'package:sqdlite_/editNote.dart';

import 'home.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark, 
      debugShowCheckedModeBanner: false,
      title: 'sqflite',
      home: Home(),
      routes: {
        "home": (context) => Home(),
        "addnotes": (context) => const AddNotes(),
        "editnote": (context) => const EditNote(),
      },
    );
  }
}
