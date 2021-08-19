import 'package:etiqa_todo_list/screens/add_edit_todo_screen.dart';
import 'package:etiqa_todo_list/services/todoService.dart';
import 'package:etiqa_todo_list/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class CardTodo extends StatelessWidget {
  final dynamic todoData;
  CardTodo(this.todoData);

  @override
  Widget build(BuildContext context) {
    // Convert string to DateTime format
    DateTime startDate = DateTime.parse(todoData['startDate']);
    DateTime endDate = DateTime.parse(todoData['endDate']);

    // Calculate time left between today date and end date
    final difference = Jiffy(endDate).diff(DateTime.now(), Units.DAY);

    // Dismissible can scroll left or right to remove to-do-list card
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (DismissDirection direction) {
        //Delete to-do-list function
        TodoService().deleteTodo(todoData.id);
      },
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () async {
          // navigate to edit screen to show detail of to-do-list information
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
                              // Title
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
                                  // Start Date
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
                                  // End Date
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
                                  // Time Left
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
                            // Display status either completed or incompleted
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
                              // Ticking UI function
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
