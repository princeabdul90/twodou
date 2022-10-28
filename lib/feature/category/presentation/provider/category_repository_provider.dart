/*
* Developer: Abubakar Abdullahi
* Date: 17/10/2022
*/

import 'package:twodou_app/feature/category/domain/category.dart';

import '../../data/sqlite/sqlite_helper.dart';
import '../../data/category_repository.dart';

class CategoryRepositoryProvider extends CategoryRepository  {

  final dbHelper = SqliteHelper();

  @override
  Future<void> deleteCategory(Category category) {
    return dbHelper.deleteCategory(category);
  }

  @override
  Future<List<Category>> findAllCategories() {
    return dbHelper.findAllCategories();
  }

  @override
  Future<Category> findCategoryById(int id) {
    return dbHelper.findCategoryById(id);
  }

  @override
  Future<int> insertCategory(Category category) {
    return dbHelper.insertCategory(category);
  }

  @override
  Future<int> updateCategoryTaskCount(Category category) {
    return dbHelper.updateCategoryTaskCount(category);
  }

  @override
  Stream<List<Category>> watchAllCategories() {
    return dbHelper.watchAllCategories();
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