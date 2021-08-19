import 'package:etiqa_todo_list/services/todoService.dart';
import 'package:etiqa_todo_list/utils/constants.dart';
import 'package:flutter/material.dart';

class AddEditScreen extends StatefulWidget {
  // IsEdit for edit screen
  final bool isEdit;
  // Collect date from todo
  final dynamic data;
  AddEditScreen({required this.isEdit, this.data});
  @override
  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  // title controller
  final titleController = TextEditingController();

  // show this text if not select yet
  String startDate = 'Select the date';
  String endDate = 'Select the date';

  void isEdit() {
    // If navigator to edit screen, data will be show
    if (widget.isEdit) {
      titleController.text = widget.data['title'];
      startDate = widget.data['startDate'];
      endDate = widget.data['endDate'];
    }
  }

  @override
  void initState() {
    super.initState();
    isEdit();
  }

  @override
  Widget build(BuildContext context) {
    // Show done button when keyboard is showing
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.darkOrange,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.keyboard_arrow_left,
            size: 40,
            color: Colors.black,
          ),
        ),
        // App bar text will be different for edit screen and add screen
        title: Text(
          '${widget.isEdit ? "Edit" : "Add New"} To-Do List',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      'To-Do Title',
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // TextField for title
                    TextField(
                      controller: titleController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        hintText: 'Please key in your To-Do title here',
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    // Choose Start Date
                    Text(
                      'Start Date ',
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        DateTime date;
                        // Edit Screen Or Create Screen
                        if (widget.isEdit) {
                          // date from todo
                          date = DateTime.parse(startDate);
                        } else {
                          // set date from now
                          date = DateTime.now();
                        }
                        // Keyboard will close when choose date
                        FocusScope.of(context).unfocus();
                        // show calendar to pick
                        showDatePicker(
                          context: context,
                          initialDate: DateTime(
                              date.year, date.month, date.day), // Refer step 1
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100, 12, 31),
                        ).then((date) {
                          // after choose date, the text will be show on screen
                          if (date != null) {
                            setState(() {
                              startDate =
                                  "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
                            });
                          }
                        });
                      },
                      child: SizedBox(
                          width: double.infinity,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '$startDate',
                                ),
                                Icon(Icons.keyboard_arrow_down),
                              ],
                            ),
                            height: 60,
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // Choose Estimate End Date
                    Text(
                      'Estimate End Date ',
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        DateTime date;

                        // Edit Screen
                        if (widget.isEdit) {
                          // date from todo
                          date = DateTime.parse(endDate);
                          //Create New Screen
                        } else {
                          // set date from now
                          date = DateTime.now();
                        }
                        // Keyboard will close when choose date
                        FocusScope.of(context).unfocus();
                        // show calendar to pick
                        showDatePicker(
                          context: context,
                          initialDate: DateTime(
                              date.year, date.month, date.day), // Refer step 1
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100, 12, 31),
                        ).then((date) {
                          // after choose date, the text will be show on screen
                          if (date != null) {
                            setState(() {
                              endDate =
                                  "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
                            });
                          }
                        });
                      },
                      child: SizedBox(
                          width: double.infinity,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('$endDate'),
                                Icon(Icons.keyboard_arrow_down),
                              ],
                            ),
                            height: 60,
                          )),
                    ),
                  ],
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  // Show dialog message when title is empty , the date is not select and start date cannot more than end date
                  if (titleController.text == "") {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('To-do title is empty.'),
                            actions: [
                              TextButton(
                                child: Text("CANCEL"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        });
                    // Show dialog message when the start date is not select
                  } else if (startDate == 'Select the date') {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Please select start date.'),
                            actions: [
                              TextButton(
                                child: Text("CANCEL"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        });
                    // Show dialog message when the end date is not select
                  } else if (endDate == 'Select the date') {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Please select estimate end date.'),
                            actions: [
                              TextButton(
                                child: Text("CANCEL"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        });
                    // Show dialog message when start date cannot more than end date
                  } else if (DateTime.parse(endDate)
                      .isBefore(DateTime.parse(startDate))) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Invalid start date and end date.'),
                            actions: [
                              TextButton(
                                child: Text("CANCEL"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        });
                  } else {
                    final data = {
                      'title': titleController.text,
                      'startDate': startDate,
                      'endDate': endDate,
                      'isCompleted': false,
                    };
                    // Edit Screen
                    if (widget.isEdit) {
                      // Update the todo
                      TodoService().updateTodo(widget.data.id, data);

                      // Create New Screen
                    } else {
                      // Create new todo
                      TodoService().addTodo(data);
                    }
                    // After edit or add, it will go back the home screen
                    Navigator.pop(context, true);
                  }
                },
                child: SizedBox(
                  width: double.infinity,
                  child: Container(
                    color: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                    child: Text(
                      widget.isEdit ? 'Save' : 'Create Now',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Show done button when keyboard is showing
          !isKeyboard
              ? Container()
              : Container(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: double.infinity,
                      child: Container(
                        alignment: Alignment.centerRight,
                        color: Colors.black,
                        height: 30,
                        child: GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                          },
                          child: Text(
                            'Done',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
