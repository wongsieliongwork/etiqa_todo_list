import 'package:cloud_firestore/cloud_firestore.dart';

class TodoService {
  // To-do-list collection from cloud firestore
  CollectionReference todo = FirebaseFirestore.instance.collection('todo');

// Add to-do-list
  Future<void> addTodo(final params) {
    return todo
        .add(params)
        .then((value) => print("Todo added"))
        .catchError((error) => print("Failed to add todo: $error"));
  }

// Update or edit to-do-list
  Future<void> updateTodo(String id, final params) {
    return todo
        .doc(id)
        .update(params)
        .then((value) => print("Todo Updated"))
        .catchError((error) => print("Failed to update todo: $error"));
  }

// Delete to-do-list
  Future<void> deleteTodo(String id) {
    return todo
        .doc(id)
        .delete()
        .then((value) => print("Todo Deleted"))
        .catchError((error) => print("Failed to delete todo: $error"));
  }

// Tick to-do-list for complete or incompleted
  Future<void> tickTodo(String id, bool isTick) {
    return todo
        .doc(id)
        .update({'isCompleted': isTick ? false : true})
        .then((value) => print("Ticked"))
        .catchError((error) => print("Failed to tick: $error"));
  }
}
