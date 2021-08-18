import 'package:etiqa_todo_list/services/todoService.dart';
import 'package:etiqa_todo_list/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddEditScreen extends StatefulWidget {
  final bool isEdit;
  final dynamic data;
  AddEditScreen({required this.isEdit, this.data});
  @override
  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final titleController = TextEditingController();
  String startDate = 'Select the date';
  String endDate = 'Select the date';

  void isEdit() {
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
                    TextField(
                      controller: titleController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        // disabledBorder: OutlineInputBorder(
                        //   borderSide: BorderSide(color: Colors.grey, width: 2.0),
                        // ),
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
                        if (widget.isEdit) {
                          date = DateTime.parse(startDate);
                        } else {
                          date = DateTime.now();
                        }
                        FocusScope.of(context).unfocus();

                        DatePicker.showDatePicker(context,
                            showTitleActions: true,
                            minTime: DateTime.now(),
                            maxTime: DateTime(2100, 12, 31), onChanged: (date) {
                          print('change $date');
                        }, onConfirm: (date) {
                          setState(() {
                            startDate =
                                "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
                          });
                        },
                            currentTime: DateTime(
                              date.year,
                              date.month,
                              date.day,
                            ),
                            locale: LocaleType.en);
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
                        if (widget.isEdit) {
                          date = DateTime.parse(endDate);
                        } else {
                          date = DateTime.now();
                        }
                        FocusScope.of(context).unfocus();
                        DatePicker.showDatePicker(context,
                            showTitleActions: true,
                            minTime: DateTime.now(),
                            maxTime: DateTime(2100, 12, 31), onChanged: (date) {
                          print('change $date');
                        }, onConfirm: (date) {
                          print('confirm $date');

                          setState(() {
                            endDate =
                                "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
                          });
                        },
                            currentTime: DateTime(
                              date.year,
                              date.month,
                              date.day,
                            ),
                            locale: LocaleType.en);
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
                  } else {
                    final data = {
                      'title': titleController.text,
                      'startDate': startDate,
                      'endDate': endDate,
                      'isCompleted': false,
                    };
                    if (widget.isEdit) {
                      TodoService().updateTodo(widget.data.id, data);
                    } else {
                      TodoService().addTodo(data);
                    }

                    Navigator.pop(context, true);
                  }
                },
                child: SizedBox(
                  width: double.infinity,
                  child: Container(
                    color: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                    child: Text(
                      widget.isEdit ? 'Edit' : 'Create Now',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          ),
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
