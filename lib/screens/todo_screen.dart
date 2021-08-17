import 'package:etiqa_todo_list/database/todo_database.dart';
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
  List todoList = [];
  void getTodoList() {
    TodoDatabase.getTodoList().then((value) {
      setState(() {
        print(value);
        todoList = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getTodoList();
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
        onPressed: () async {
          bool value = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddEditScreen(
                        isEdit: false,
                      )));
          if (value == true) {
            setState(() {
              getTodoList();
            });
          }
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
                return CardTodo(todoList[index], () {
                  setState(() {
                    getTodoList();
                  });
                });
              }),
    );
  }
}
