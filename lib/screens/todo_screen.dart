import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etiqa_todo_list/screens/add_edit_todo_screen.dart';
import 'package:etiqa_todo_list/utils/constants.dart';
import 'package:etiqa_todo_list/widgets/card_todo.dart';
import 'package:flutter/material.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  // To-do-List collection of data from firestore
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('todo');

  List todoList = [];
  void getTodo() {
    // Trigger data from To-Do-List collection
    collectionReference
        // Sort "Completed" to-do-list below "inCompleted" to-do-list
        .orderBy('isCompleted', descending: false)
        .snapshots()
        .listen((snapshot) {
      setState(() {
        todoList = snapshot.docs;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.darkOrange,
        title: Text(
          'To-Do List',
          style: TextStyle(color: Colors.black),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Constants.lightOrange,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddEditScreen(
                        isEdit: false,
                      )));
        },
      ),
      // Add button
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // show "empty" text on the screen when to-do-list is empty
      body: todoList.isEmpty
          ? Container(
              child: Center(child: Text('Empty')),
            )
          // List of to-do-list
          : ListView.builder(
              itemCount: todoList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  // Display to-do-list cards
                  child: CardTodo(
                    todoList[index],
                  ),
                );
              }),
    );
  }
}
