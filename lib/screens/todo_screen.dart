import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etiqa_todo_list/screens/add_edit_todo_screen.dart';

import 'package:etiqa_todo_list/utils/constants.dart';
import 'package:etiqa_todo_list/widgets/card_todo.dart';
import 'package:flutter/material.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  // List todoList = [];
  // void getTodoList() {
  //   TodoDatabase.getTodoList().then((value) {
  //     setState(() {
  //       print(value);
  //       todoList = value;
  //     });
  //   });
  // }
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('todo');

  List todoList = [];
  void getTodo() {
    collectionReference
        .orderBy('isCompleted', descending: false)
        .snapshots()
        .listen((snapshot) {
      setState(() {
        todoList = snapshot.docs;

        print(todoList);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    // getTodoList();
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: todoList.isEmpty
          ? Container(
              child: Center(child: Text('Empty')),
            )
          : ListView.builder(
              itemCount: todoList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: CardTodo(
                    todoList[index],
                  ),
                );
              }),
    );
  }
}
