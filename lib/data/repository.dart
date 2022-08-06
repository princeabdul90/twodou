/*
* Developer: Abubakar Abdullahi
* Date: 03/08/2022
*/

import 'model/category.dart';

abstract class Repository {
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



  // Initializing and closing
  Future init();

  void close();
}