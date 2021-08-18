import 'package:cloud_firestore/cloud_firestore.dart';

class TodoService {
  CollectionReference todo = FirebaseFirestore.instance.collection('todo');

  Future<void> addTodo(final params) {
    // Call the user's CollectionReference to add todo
    return todo
        .add(
          params,
        )
        .then(
          (value) => print("Todo added"),
        )
        .catchError((error) => print("Failed to add todo: $error"));
  }

  Future<void> updateTodo(String id, final params) {
    return todo
        .doc(id)
        .update(
          params,
        )
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> deleteTodo(String id) {
    return todo
        .doc(id)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  Future<void> tickTodo(String id, bool isTick) {
    return todo
        .doc(id)
        .update(
          {'isCompleted': isTick ? false : true},
        )
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }
}
