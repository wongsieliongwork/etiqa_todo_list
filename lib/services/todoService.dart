import 'package:cloud_firestore/cloud_firestore.dart';

class TodoService {
  // Todo Collection from cloud firestore
  CollectionReference todo = FirebaseFirestore.instance.collection('todo');

// Add Todo
  Future<void> addTodo(final params) {
    return todo
        .add(params)
        .then((value) => print("Todo added"))
        .catchError((error) => print("Failed to add todo: $error"));
  }

// Update or edit Todo
  Future<void> updateTodo(String id, final params) {
    return todo
        .doc(id)
        .update(params)
        .then((value) => print("Todo Updated"))
        .catchError((error) => print("Failed to update todo: $error"));
  }

// Delete Todo
  Future<void> deleteTodo(String id) {
    return todo
        .doc(id)
        .delete()
        .then((value) => print("Todo Deleted"))
        .catchError((error) => print("Failed to delete todo: $error"));
  }

// Tick Todo for complete or not
  Future<void> tickTodo(String id, bool isTick) {
    return todo
        .doc(id)
        .update({'isCompleted': isTick ? false : true})
        .then((value) => print("Ticked"))
        .catchError((error) => print("Failed to tick: $error"));
  }
}
