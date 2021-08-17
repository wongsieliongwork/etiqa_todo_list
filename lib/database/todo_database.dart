import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TodoDatabase {
  TodoDatabase.initial();
  static final TodoDatabase instance = TodoDatabase.initial();
  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'test1.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: createDB,
    );
  }

  static Future createDB(Database db, int version) async {
    await db.execute(
        'CREATE TABLE todo (id INTEGER PRIMARY KEY, title TEXT, startDate TEXT, endDate TEXT, isCompleted INTEGER)');
  }

  static Future getTodoList() async {
    Database db = await instance.database;
    List todoList = [];
    await db.query('todo').then((value) {
      if (value.isEmpty) {
        todoList = [];
      } else {
        todoList = value;
      }
    });
    return todoList;
  }

  static Future createTodo(final params) async {
    Database db = await instance.database;
    return await db.insert('todo', params);
  }

  static Future deleteTodo(int id) async {
    Database db = await instance.database;
    return await db.delete(
      'todo',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future editTodo(int id, final params) async {
    Database db = await instance.database;
    await db.update(
      'todo',
      params,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future tickTodo(
    int id,
  ) async {
    Database db = await instance.database;
    List result = await db.query("todo", where: "id = ?", whereArgs: [id]);
    print(result[0]['isCompleted']);
    await db.update(
      'todo',
      {'isCompleted': result[0]['isCompleted'] == 1 ? 0 : 1},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
