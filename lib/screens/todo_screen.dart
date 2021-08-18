import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etiqa_todo_list/database/todo_database.dart';
import 'package:etiqa_todo_list/screens/add_edit_todo_screen.dart';
import 'package:etiqa_todo_list/services/todoService.dart';
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

  List todoList = [];
  void getTodo() {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('todo');
    collectionReference.snapshots().listen((snapshot) {
      setState(() {
        todoList = snapshot.docs;
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
        title: Text('To-Do List'),
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
