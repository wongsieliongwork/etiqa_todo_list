import 'package:etiqa_todo_list/screens/add_edit_todo_screen.dart';
import 'package:etiqa_todo_list/services/todoService.dart';
import 'package:etiqa_todo_list/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class CardTodo extends StatelessWidget {
  final dynamic todoData;

  CardTodo(this.todoData);
  String getTimeString(int value) {
    final int hour = value ~/ 60;
    final int minutes = value % 60;

    return '${hour.toString().padLeft(2, "0")}:${minutes.toString().padLeft(2, "0")}';
  }

  @override
  Widget build(BuildContext context) {
    DateTime startDate = DateTime.parse(todoData['startDate']);
    DateTime endDate = DateTime.parse(todoData['endDate']);
    final difference = Jiffy(endDate).diff(startDate, Units.DAY);

    return Dismissible(
      key: UniqueKey(),
      onDismissed: (DismissDirection direction) {
        TodoService().deleteTodo(todoData.id);
      },
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddEditScreen(
                        isEdit: true,
                        data: todoData,
                      )));
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
                                todoData['title'],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                        Jiffy(startDate).format('d MMM yyyy'),
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
                                        'End Date',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        Jiffy(endDate).format('d MMM yyyy'),
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
                                        // '$difference Days',
                                        // getTimeString(difference.toInt()),
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
                                    todoData['isCompleted']
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
                                          value: todoData['isCompleted'],
                                          onChanged: (value) {
                                            TodoService().tickTodo(todoData.id,
                                                todoData['isCompleted']);
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
                            TodoService().deleteTodo(todoData.id);
                          },
                          child: Icon(Icons.cancel))),
                )
              ],
            )),
      ),
    );
  }
}
