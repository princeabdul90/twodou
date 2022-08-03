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
  Future<Category> getCategoryTaskCount(int id);

  // Update Methods
  Future<int> updateCategoryTaskCount(Category category, int id);

  // Delete Methods
  Future<void> deleteCategory(Category category);
  Future<void> deleteAllCategories(List<Category> category);

  // Initializing and closing
  Future init();

  void close();
}