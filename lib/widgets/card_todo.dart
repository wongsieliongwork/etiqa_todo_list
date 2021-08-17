import 'package:etiqa_todo_list/database/todo_database.dart';
import 'package:etiqa_todo_list/screens/add_edit_todo_screen.dart';
import 'package:etiqa_todo_list/utils/constants.dart';
import 'package:flutter/material.dart';

class CardTodo extends StatefulWidget {
  final dynamic todoData;
  final Function onChanged;
  CardTodo(this.todoData, this.onChanged);

  @override
  _CardTodoState createState() => _CardTodoState();
}

class _CardTodoState extends State<CardTodo> {
  bool isCheck = false;

  void getCheck() {
    isCheck = widget.todoData['isCompleted'] == 1 ? true : false;
  }

  @override
  void initState() {
    super.initState();
    getCheck();
  }

  @override
  Widget build(BuildContext context) {
    DateTime startDate = DateTime.parse(widget.todoData['startDate']);
    DateTime endDate = DateTime.parse(widget.todoData['endDate']);
    final difference = endDate.difference(startDate).inDays;
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (DismissDirection direction) {
        TodoDatabase.deleteTodo(widget.todoData['id']);
      },
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () async {
          bool value = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddEditScreen(
                        isEdit: true,
                        data: widget.todoData,
                      )));
          setState(() {
            widget.onChanged();
          });
        },
        child: Container(
            margin: EdgeInsets.all(15),
            child: Stack(
              children: [
                PhysicalModel(
                  shadowColor: Colors.black,
                  elevation: 5,
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.todoData['title'],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Start Date',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        widget.todoData['startDate'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'End Date',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        widget.todoData['endDate'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Time left',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '$difference Days',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                              color: Constants.lightGrey,
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                              )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Status',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    widget.todoData['isCompleted'] == 1
                                        ? 'Completed'
                                        : 'Incomplete',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('Tick if completed'),
                                  Container(
                                      height: 30,
                                      width: 30,
                                      child: Checkbox(
                                          value:
                                              widget.todoData['isCompleted'] ==
                                                      1
                                                  ? true
                                                  : false,
                                          onChanged: (value) {
                                            setState(() {
                                              TodoDatabase.tickTodo(
                                                      widget.todoData['id'])
                                                  .then((value) {
                                                widget.onChanged();
                                              });
                                            });
                                          }))
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                      padding: EdgeInsets.all(15),
                      child: GestureDetector(
                          onTap: () {
                            TodoDatabase.deleteTodo(widget.todoData['id']);
                            widget.onChanged();
                          },
                          child: Icon(Icons.cancel))),
                )
              ],
            )),
      ),
    );
  }
}
