// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'pages/Start_page.dart';

void main() async {
  // init the hive
  await Hive.initFlutter();

  // Open the box
  var box = await Hive.openBox<String>('mybox');
  var isCheckedBox = await Hive.openBox<bool>('isCheckedBox');

  runApp(TodoList());
}

class TodoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.black, // Customize the cursor color
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF7C2E62),
        ),
      ),
      home: StartPage(),
    );
  }
}
