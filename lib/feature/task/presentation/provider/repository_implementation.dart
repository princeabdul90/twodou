/*
* Developer: Abubakar Abdullahi
* Date: 17/10/2022
*/

import 'package:flutter/material.dart';
import 'package:twodou_app/feature/task/data/task_repository.dart';
import 'package:twodou_app/feature/task/domain/task.dart';

import '../../../task/data/sqlite/sqlite_helper.dart';



class TaskRepositoryProvider extends TaskRepository  {

  final dbHelper = SqliteHelper();


  bool get hasCompleted => dbHelper.hasCompleted;
  String? get successMsg => dbHelper.successMsg;



  // ********* TASK METHOD *********//
  @override
  Stream<List<Task>> watchAllTasks() {
    return dbHelper.watchAllTasks();
  }

  @override
  Stream<List<Task>> findAllTasksByCategory(int categoryId) {
    return  dbHelper.findAllTasksByCategory(categoryId);
  }

  @override
  Stream<List<Task>> watchAllTasksByCategory(int categoryId) {
    return dbHelper.watchAllTasksByCategory(categoryId);
  }

  @override
  Stream<int> findAllTasksCount() {
    return dbHelper.findAllTaskCount();
  }

  @override
  Stream<int> findTasksCountByCategory(int catId)  {
    return  dbHelper.findCategoryTaskCount(catId);
  }

  @override
  Future<List<Task>> findAllTasks() async {
    return  await dbHelper.findAllTasks();
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

  @override
  Future init() {
    return dbHelper.init();
  }

  @override
  void close() {
    return dbHelper.close();
  }




}