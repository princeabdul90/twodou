/*
* Developer: Abubakar Abdullahi
* Date: 17/10/2022
*/

import '../domain/category.dart';

abstract class CategoryRepository {

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