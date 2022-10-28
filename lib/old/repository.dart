/*
* Developer: Abubakar Abdullahi
* Date: 03/08/2022
*/

import 'model/model.dart';

abstract class Repository {

  //*** CATEGORY METHODS  *****
  // Find Methods
  Future<List<Category>> findAllCategories();
  Stream<List<Category>> watchAllCategories();
  Future<Category> findCategoryById(int id);

  // Update Methods
  Future<int> updateCategoryTaskCount(Category category);
  // Delete Methods
  Future<void> deleteCategory(Category category);
  // Insert Method
  Future<int> insertCategory(Category category);

  //*** TASK METHODS  *****
  // Find Methods
  Future<List<Task>> findAllTasks();
  Stream<List<Task>> watchAllTasks();
  Future<Task> findTaskById(int id);

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