/*
* Developer: Abubakar Abdullahi
* Date: 17/10/2022
*/

import '../domain/task.dart';

abstract class TaskRepository {

  // Find Methods
  Future<List<Task>> findAllTasks();
  Stream<List<Task>> watchAllTasks();
  Stream<List<Task>> watchAllTasksByCategory(int categoryId);
  Future<Task> findTaskById(int id);
  Stream<int> findAllTasksCount();
  Stream<int> findTasksCountByCategory(int catId);
  Stream<List<Task>> findAllTasksByCategory(int categoryId);

  // update
  Future<int> updateTask(Task task);
  // insert
  Future<int> insertTask(Task task);
  // delete
  Future<void> deleteTask(Task task);

  // Initializing and closing
  Future init();
  void close();

}