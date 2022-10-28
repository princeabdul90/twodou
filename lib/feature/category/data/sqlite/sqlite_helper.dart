/*
* Developer: Abubakar Abdullahi
* Date: 17/10/2022
*/
import 'package:sqlbrite/sqlbrite.dart';

import '../../domain/category.dart';
import '../../../database/sqlite_database.dart';

class SqliteHelper {


  //**********      PARSE CATEGORY DATA -******/
  List<Category> parseCategories(List<Map<String, dynamic>> categoryList) {
    final categories = <Category>[];

    categoryList.forEach((categoryMap) {
      final category = Category.fromJson(categoryMap);
      categories.add(category);
    });
    return categories;
  }

  Stream<List<Category>> watchAllCategories() async* {
    final db = await SqliteDatabase.instance.streamDatabase;
    yield* db
        .createQuery(SqliteDatabase.categoryTable)
        .mapToList((row) => Category.fromJson(row));
  }

  Future<List<Category>> findAllCategories() async {
    final db = await SqliteDatabase.instance.streamDatabase;
    final categoryList = await db.query(SqliteDatabase.categoryTable);
    final categories = parseCategories(categoryList);
    return categories;
  }

  Future<Category> findCategoryById(int id) async {
    final db = await SqliteDatabase.instance.streamDatabase;
    final categoryList = await db.query(SqliteDatabase.categoryTable, where: 'categoryId=$id');
    final category = parseCategories(categoryList);
    return category.first;
  }

  // UPDATE
  Future<int> _update(String table, object, String columnId, int id) async {
    final db = await SqliteDatabase.instance.streamDatabase;
    return db.update(table, object, where: '$columnId =?', whereArgs: [id]);
  }

  Future<int> updateCategoryTaskCount(Category category) {
    if (category.id != null) {
      return _update(
          SqliteDatabase.categoryTable, category.toJson(), SqliteDatabase.categoryId, category.id!);
    } else {
      return Future.value(-1);
    }
  }


  // DELETE
  Future<int> _delete(String table, String columnId, int id) async {
    final db = await SqliteDatabase.instance.streamDatabase;
    return db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> deleteCategory(Category category) async {
    if (category.id != null) {
      return _delete(SqliteDatabase.categoryTable, SqliteDatabase.categoryId, category.id!);
    } else {
      return Future.value(-1);
    }
  }

  // INSERT
  Future<int> insert(String table, Map<String, dynamic> row) async {
    final db = await SqliteDatabase.instance.streamDatabase;
    return db.insert(table, row);
  }

  Future<int> insertCategory(Category category) async {
    return insert(SqliteDatabase.categoryTable, category.toJson());
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

