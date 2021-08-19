import 'package:etiqa_todo_list/services/todoService.dart';
import 'package:etiqa_todo_list/utils/constants.dart';
import 'package:flutter/material.dart';

class AddEditScreen extends StatefulWidget {
  // IsEdit is set to True, then go to edit screen,
  // likewise for False go to create new screen
  final bool isEdit;
  // Trigger date from to-do-list card
  final dynamic data;
  AddEditScreen({required this.isEdit, this.data});
  @override
  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  // title controller
  final titleController = TextEditingController();

  // Set guiding text in the select field
  String startDate = 'Select the date';
  String endDate = 'Select the date';

  void isEdit() {
    //When existing to-do-list card is clicked, trigger data into edit screen.
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
    // Show Done button when keyboard is tapped
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
        // Two different AppBar title for Edit screen and Add screen
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
                          // date from to-do-list
                          date = DateTime.parse(startDate);
                        } else {
                          // set date from now
                          date = DateTime.now();
                        }
                        // Keyboard will close when date is choose
                        FocusScope.of(context).unfocus();
                        // Display calendar for selection
                        showDatePicker(
                          context: context,
                          initialDate:
                              DateTime(date.year, date.month, date.day),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100, 12, 31),
                        ).then((date) {
                          // After date is choose, the date will be displayed on screen
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

                        // Edit Screen Or Create Screen
                        if (widget.isEdit) {
                          // date from to-do-list
                          date = DateTime.parse(endDate);
                          //Create New Screen
                        } else {
                          // set date from now
                          date = DateTime.now();
                        }
                        // Keyboard will close when date is choose
                        FocusScope.of(context).unfocus();
                        // Display calendar for selection
                        showDatePicker(
                          context: context,
                          initialDate: DateTime(
                              date.year, date.month, date.day), // Refer step 1
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100, 12, 31),
                        ).then((date) {
                          // After date is choose, the date will be displayed on screen
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
                  // Show dialog message when title is empty
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
                    // Show dialog message when the start date is not selected
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
                    // Show dialog message when the end date is not selected
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
                    // Show dialog message when start date cannot be more than end date
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
                      // Update the to-do-list
                      TodoService().updateTodo(widget.data.id, data);

                      // Create New Screen
                    } else {
                      // Create new to-do-list
                      TodoService().addTodo(data);
                    }
                    // After edit or add button is clicked, it will go back to home screen
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
          // Show Done button when keyboard is tapped
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
