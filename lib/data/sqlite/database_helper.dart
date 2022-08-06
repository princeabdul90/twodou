/*
* Developer: Abubakar Abdullahi
* Date: 03/08/2022
*/
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:synchronized/synchronized.dart';
import 'package:sqlbrite/sqlbrite.dart';

import '../model/category.dart';

class DatabaseHelper {
  static const _databaseName = 'TwoDou.db';
  static const _databaseVersion = 1;

  static const categoryTable = 'Category';
  static const categoryId = 'categoryId';

  static const taskTable = 'task';
  static const taskId = 'taskId';

  static late BriteDatabase _streamDatabase;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static var lock = Lock();

  static Database? _database;

  //**********--------????????????????---------******/
  //**** CREATE DATABASE CODE HERE  *******
  //**********--------????????????????---------******/

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $categoryTable (
        $categoryId INTEGER PRIMARY KEY AUTOINCREMENT,
        taskCount INTEGER,
        title TEXT,
        color TEXT,
        icon TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE $taskTable (
        $taskId INTEGER PRIMARY KEY AUTOINCREMENT,
        $categoryId INTEGER,
        content TEXT,
        date STRING,
        note TEXT,
        status INTEGER
      )
    ''');

    final batch = db.batch();
    batch.insert(categoryTable, {
      'title': 'All',
      'color': '0xed553fe0',
      'icon': 'file-text',
      'taskCount': 0
    });

    batch.insert(categoryTable, {
      'title': 'Work',
      'color': '0xffc5ab18',
      'icon': 'briefcase',
      'taskCount': 0
    });
    batch.insert(categoryTable, {
      'title': 'Music',
      'color': '0xffea6473',
      'icon': 'earbuds',
      'taskCount': 0
    });
    batch.insert(categoryTable, {
      'title': 'Travel',
      'color': '0xff158442',
      'icon': 'plane-departure',
      'taskCount': 0
    });
    batch.insert(categoryTable, {
      'title': 'Study',
      'color': '0xff8320de',
      'icon': 'wallet',
      'taskCount': 0
    });
    batch.insert(categoryTable,
        {'title': 'Home', 'color': '0xffa81b14', 'icon': 'house-fill', 'taskCount': 0});
    batch.insert(categoryTable, {
      'title': 'Paint',
      'color': '0xff763494',
      'icon': 'brush',
      'taskCount': 0
    });
    batch.insert(categoryTable, {
      'title': 'Grocery',
      'color': '0xff09ab93',
      'icon': 'cart4',
      'taskCount': 0
    });
    batch.insert(categoryTable, {
      'title': 'Gym',
      'color': '0xed553fe0',
      'icon': 'dumbbell',
      'taskCount': 0
    });
    batch.insert(categoryTable, {
      'title': 'Others',
      'color': '0x7f000000',
      'icon': 'binoculars',
      'taskCount': 0
    });

    final list = await batch.commit(
      continueOnError: true,
      noResult: false,
    );
    print('Batch result: $list');
  }

  // open the database (and create table if it doesn't exist)
  Future<Database> _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);

    //TODO: Remember to turn off debugging before deploying app to store(s)
    Sqflite.setDebugModeOn(true);

    return openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  // Getter that initializes private database
  Future<Database> get database async {
    if (_database != null) return _database!;

    await lock.synchronized(() async {
      if (_database == null) {
        _database = await _initDatabase();
        _streamDatabase = BriteDatabase(_database!);
      }
    });

    return _database!;
  }

  Future<BriteDatabase> get streamDatabase async {
    await database;
    return _streamDatabase;
  }

  //**********--------????????????????---------******/
  //********** PARSE CATEGORY DATA
  //**********--------????????????????---------******/
  List<Category> parseCategories(List<Map<String, dynamic>> categoryList) {
    final categories = <Category>[];

    categoryList.forEach((categoryMap) {
      final category = Category.fromJson(categoryMap);
      categories.add(category);
    });
    return categories;
  }

  //TODO: Add parse tasks data

  //**********--------????????????????---------******/
  //****** IMPLEMENTING REPOSITORY LIKE FUNCTIONS
  //**********--------????????????????---------******/

  Future<List<Category>> findAllCategories() async {
    final db = await instance.streamDatabase;
    final categoryList = await db.query(categoryTable);
    final categories = parseCategories(categoryList);

    return categories;
  }

  Stream<List<Category>> watchAllCategories() async* {
    final db = await instance.streamDatabase;
    yield* db
        .createQuery(categoryTable)
        .mapToList((row) => Category.fromJson(row));
  }

//TODO: Add stream watchAllTasks

  Future<Category> findCategoryById(int id) async {
    final db = await instance.streamDatabase;
    final categoryList = await db.query(categoryTable, where: 'id=$id');
    final category = parseCategories(categoryList);
    return category.first;
  }

  // UPDATE
  Future<int> _update(String table, object, String columnId, int id) async {
    final db = await instance.streamDatabase;
    return db.update(table, object, where: '$columnId =?', whereArgs: [id]);
  }

  Future<int> updateCategoryTaskCount(Category category) {
    if (category.id != null) {
      return _update(
          categoryTable, category.toJson(), categoryId, category.id!);
    } else {
      return Future.value(-1);
    }
  }

  // DELETE
  Future<int> _delete(String table, String columnId, int id) async {
    final db = await instance.streamDatabase;
    return db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> deleteCategory(Category category) async {
    if (category.id != null) {
      return _delete(categoryTable, categoryId, category.id!);
    } else {
      return Future.value(-1);
    }
  }

  // INSERT
  Future<int> insert(String table, Map<String, dynamic> row) async {
    final db = await instance.streamDatabase;
    return db.insert(table, row);
  }

  Future<int> insertCategory(Category category) async {
    return insert(categoryTable, category.toJson());
  }

  void close() {
    _streamDatabase.close();
  }

}



//
// batch.insert(categoryTable, {
// 'title': 'All',
// 'color': 'lightBlue',
// 'icon': 'assignment',
// 'taskCount': 0
// });
//
// batch.insert(categoryTable, {
// 'title': 'Work',
// 'color': 'lightBlue',
// 'icon': 'Work',
// 'taskCount': 0
// });
// batch.insert(categoryTable, {
// 'title': 'Music',
// 'color': 'orangeAccent',
// 'icon': 'radio',
// 'taskCount': 0
// });
// batch.insert(categoryTable, {
// 'title': 'Travel',
// 'color': 'greenAccent',
// 'icon': 'flight_takeoff',
// 'taskCount': 0
// });
// batch.insert(categoryTable, {
// 'title': 'Study',
// 'color': 'deepPurple',
// 'icon': 'auto_stories',
// 'taskCount': 0
// });
// batch.insert(categoryTable,
// {'title': 'Home', 'color': 'red', 'icon': 'house', 'taskCount': 0});
// batch.insert(categoryTable, {
// 'title': 'Paint',
// 'color': 'purple',
// 'icon': 'color_lens',
// 'taskCount': 0
// });
// batch.insert(categoryTable, {
// 'title': 'Grocery',
// 'color': 'teal',
// 'icon': 'local_grocery_store',
// 'taskCount': 0
// });
// batch.insert(categoryTable, {
// 'title': 'Gym',
// 'color': 'lightBlue',
// 'icon': 'assignment',
// 'taskCount': 0
// });
// batch.insert(categoryTable, {
// 'title': 'Others',
// 'color': 'lightBlue',
// 'icon': 'assignment',
// 'taskCount': 0
// });
