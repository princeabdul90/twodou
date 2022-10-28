/*
* Developer: Abubakar Abdullahi
* Date: 17/10/2022
*/

import 'package:sqlbrite/sqlbrite.dart';

import '../../domain/task.dart';
import '../../../database/sqlite_database.dart';

class SqliteHelper {
  bool _hasCompleted = false;
  bool get hasCompleted => _hasCompleted;

  String? _successMsg;
  String? get successMsg => _successMsg;

  //**********      PARSE TASK DATA  **********
  List<Task> parseTasks(List<Map<String, dynamic>> taskList) {
    final tasks = <Task>[];

    taskList.forEach((taskMap) {
      final task = Task.fromJson(taskMap);
      tasks.add(task);
    });
    return tasks;
  }

  Stream<List<Task>> watchAllTasks() async* {
    final db = await SqliteDatabase.instance.streamDatabase;

    yield* db
        .createQuery(SqliteDatabase.taskTable)
        .mapToList((row) => Task.fromJson(row));
  }

  Stream<List<Task>> watchAllTasksByCategory(categoryId) async* {
    final db = await SqliteDatabase.instance.streamDatabase;

    yield* db.createQuery(SqliteDatabase.taskTable,
        where: 'categoryId',
        whereArgs: [categoryId]).mapToList((row) => Task.fromJson(row));
  }

  Future<List<Task>> findAllTasks() async {
    final db = await SqliteDatabase.instance.streamDatabase;
    final taskList = await db
        .query(SqliteDatabase.taskTable)
        .whenComplete(() => _hasCompleted = true);
    final tasks = parseTasks(taskList);
    return tasks;
  }

  Stream<List<Task>> findAllTasksByCategory(int categoryId) async* {
    final db = await SqliteDatabase.instance.streamDatabase;
    final taskList = await db.query(SqliteDatabase.taskTable,
        where: 'categoryId=$categoryId');
    final tasks = parseTasks(taskList);
    yield tasks;
  }

  Stream<int> findAllTaskCount() async* {
    final db = await SqliteDatabase.instance.streamDatabase;
    final taskList = await db.query(SqliteDatabase.taskTable);
    final tasks = parseTasks(taskList);
    yield tasks.length;
  }

  Stream<int> findCategoryTaskCount(int categoryId) async* {
    final db = await SqliteDatabase.instance.streamDatabase;
    final taskList = await db.query(SqliteDatabase.taskTable,
        where: 'categoryId=$categoryId');
    final tasks = parseTasks(taskList);
    yield tasks.length;
  }

  Future<Task> findTaskById(int id) async {
    final db = await SqliteDatabase.instance.streamDatabase;
    final taskList =
        await db.query(SqliteDatabase.taskTable, where: 'taskId=$id');
    final task = parseTasks(taskList);
    return task.first;
  }

  // UPDATE
  Future<int> _update(String table, object, String columnId, int id) async {
    final db = await SqliteDatabase.instance.streamDatabase;
    return db.update(table, object, where: '$columnId =?', whereArgs: [id]);
  }

  Future<int> updateTask(Task task) {
    if (task.id != null) {
      return _update(SqliteDatabase.taskTable, task.toJson(),
              SqliteDatabase.taskId, task.id!)
          .whenComplete(()  {
        _hasCompleted = true;
        _successMsg = 'Updated Successfully!';
      });
    } else {
      return Future.value(-1);
    }
  }

  // DELETE
  Future<int> _delete(String table, String columnId, int id) async {
    final db = await SqliteDatabase.instance.streamDatabase;
    return db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> deleteTask(Task task) async {
    if (task.id != null) {
      return _delete(SqliteDatabase.taskTable, SqliteDatabase.taskId, task.id!)
          .whenComplete(() {
        _hasCompleted = true;
        _successMsg = 'Deleted Successfully!';
      });
    } else {
      return Future.value(-1);
    }
  }

  // INSERT
  Future<int> insert(String table, Map<String, dynamic> row) async {
    final db = await SqliteDatabase.instance.streamDatabase;
    return db.insert(table, row).whenComplete(() {
      _hasCompleted = true;
      _successMsg = 'Successfully Added!';
    });
  }

  Future<int> insertTask(Task task) async {
    return insert(SqliteDatabase.taskTable, task.toJson());
  }

  // *********  INIT AND CLOSE *********//

  Future init() async {
    await SqliteDatabase.instance.database;
    return Future.value();
  }

  void close() {
    SqliteDatabase.instance.close();
  }
}
