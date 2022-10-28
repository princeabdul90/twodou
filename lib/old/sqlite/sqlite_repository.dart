/*
* Developer: Abubakar Abdullahi
* Date: 03/08/2022
*/
import 'dart:async';

import '../repository.dart';
import 'database_helper.dart';
import '../model/model.dart';

class SqliteRepository extends Repository {
  final dbHelper = DatabaseHelper.instance;

  @override
  Future<List<Category>> findAllCategories() {
    return dbHelper.findAllCategories();
  }

  @override
  Stream<List<Category>> watchAllCategories() {
    return dbHelper.watchAllCategories();
  }

  @override
  Future<Category> findCategoryById(int id) {
    return dbHelper.findCategoryById(id);
  }

  @override
  Future<int> updateCategoryTaskCount(Category category) {
    return dbHelper.updateCategoryTaskCount(category);
  }

  @override
  Future<void> deleteCategory(Category category) {
    return dbHelper.deleteCategory(category);
  }

  @override
  Future<int> insertCategory(Category category) {
    return dbHelper.insertCategory(category);
  }

  // ********* TASK METHOD *********//
  @override
  Future<List<Task>> findAllTasks() {
    return dbHelper.findAllTasks();
  }

  @override
  Stream<List<Task>> watchAllTasks() {
    return dbHelper.watchAllTasks();
  }

  @override
  Future<Task> findTaskById(int id) {
    return dbHelper.findTaskById(id);
  }


  @override
  Future<int> updateTask(Task task) {
    return dbHelper.updateTask(task);
  }

  @override
  Future<int> insertTask(Task task){
    return dbHelper.insertTask(task);
  }

  @override
  Future<void> deleteTask(Task task) {
    return dbHelper.deleteTask(task);
  }



  // *********  INIT AND CLOSE *********//

  @override
  Future init() async {
    await dbHelper.database;
    return Future.value();
  }

  @override
  void close() {
    dbHelper.close();
  }


}
