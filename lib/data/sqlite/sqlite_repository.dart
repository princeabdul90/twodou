/*
* Developer: Abubakar Abdullahi
* Date: 03/08/2022
*/
import 'dart:async';
import 'package:flutter/material.dart';

import '../repository.dart';
import 'database_helper.dart';
import '../model/category.dart';

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
