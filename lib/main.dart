import 'package:etiqa_todo_list/screens/todo_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  // Start firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Etiqa TodoList',
        // removed debug logo on the app
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            // Appbar set to no shawdow
            appBarTheme: AppBarTheme(
          elevation: 0,
        )),
        //Set To-do-List screen as a home screen
        home: TodoScreen());
  }
}
