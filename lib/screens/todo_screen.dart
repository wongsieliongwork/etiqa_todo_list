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
  // Todo Collection from firestore
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('todo');

  List todoList = [];
  void getTodo() {
    // Get data from todo collection
    collectionReference
        // Order by "isCompleted" is set by the completed todo will move to the below of the incompleted todo
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
      // Show text empty when todo is empty
      body: todoList.isEmpty
          ? Container(
              child: Center(child: Text('Empty')),
            )
          // List of todo
          : ListView.builder(
              itemCount: todoList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  // Card of todo
                  child: CardTodo(
                    todoList[index],
                  ),
                );
              }),
    );
  }
}
