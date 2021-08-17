import 'package:etiqa_todo_list/database/todo_database.dart';
import 'package:etiqa_todo_list/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.isEdit ? "Edit" : "Add New"} To-Do List'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
              decoration: InputDecoration(
                // disabledBorder: OutlineInputBorder(
                //   borderSide: BorderSide(color: Colors.grey, width: 2.0),
                // ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
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
                FocusScope.of(context).unfocus();
                DatePicker.showDatePicker(context,
                    showTitleActions: true,
                    minTime: DateTime(2021, 3, 5),
                    maxTime: DateTime(2100, 6, 7), onChanged: (date) {
                  print('change $date');
                }, onConfirm: (date) {
                  setState(() {
                    startDate =
                        "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
                  });
                }, currentTime: DateTime.now(), locale: LocaleType.en);
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
              'End Date ',
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
                FocusScope.of(context).unfocus();
                DatePicker.showDatePicker(context,
                    showTitleActions: true,
                    minTime: DateTime(2021, 3, 5),
                    maxTime: DateTime(2100, 6, 7), onChanged: (date) {
                  print('change $date');
                }, onConfirm: (date) {
                  print('confirm $date');

                  setState(() {
                    endDate =
                        "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
                  });
                }, currentTime: DateTime.now(), locale: LocaleType.en);
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
            Spacer(),
            Center(
              child: InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  final data = {
                    'title': titleController.text,
                    'startDate': startDate,
                    'endDate': endDate,
                    'isCompleted': 0,
                  };
                  if (widget.isEdit) {
                    TodoDatabase.editTodo(widget.data['id'], data);
                  } else {
                    TodoDatabase.createTodo(data);
                  }

                  Navigator.pop(context, true);
                },
                child: PhysicalModel(
                  color: Constants.darkOrange,
                  borderRadius: BorderRadius.circular(20),
                  elevation: 5,
                  shadowColor: Colors.grey,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                    child: Text(
                      'Confirm',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
