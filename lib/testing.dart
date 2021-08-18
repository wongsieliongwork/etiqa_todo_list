import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Testing extends StatefulWidget {
  const Testing({Key? key}) : super(key: key);

  @override
  _TestingState createState() => _TestingState();
}

class _TestingState extends State<Testing> {
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
    // TODO: implement initState
    super.initState();
    getTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (context, index) {
            return Container(
              child: Text('A'),
            );
          }),
    );
  }
}
