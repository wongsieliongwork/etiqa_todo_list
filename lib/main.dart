import 'package:etiqa_todo_list/screens/todo_screen.dart';
import 'package:etiqa_todo_list/utils/constants.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Etiqa TodoList',
        // remove debug logo on app
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            // Setting color and shadow for all appbar
            primaryColor: Constants.darkOrange,
            appBarTheme: AppBarTheme(
              elevation: 0,
            )),
        // First Screen On Todo Screen
        home: TodoScreen());
  }
}
