import 'package:etiqa_todo_list/screens/todo_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  // Set up from firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Etiqa TodoList',
        // remove debug logo on the app
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            // App Bar set to no shawdow
            appBarTheme: AppBarTheme(
          elevation: 0,
        )),
        // First Screen On Todo Screen
        home: TodoScreen());
  }
}
