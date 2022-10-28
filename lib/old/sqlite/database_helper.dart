/*
* Developer: Abubakar Abdullahi
* Date: 03/08/2022
*/
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:synchronized/synchronized.dart';
import 'package:sqlbrite/sqlbrite.dart';
import '../model/model.dart';

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
      'icon': 'collection',
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
      'icon': 'book-half',
      'taskCount': 0
    });
    batch.insert(categoryTable, {
      'title': 'Home',
      'color': '0xffa81b14',
      'icon': 'home-tree',
      'taskCount': 0
    });
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
  //**********      PARSE CATEGORY DATA
  //**********--------????????????????---------******/
  List<Category> parseCategories(List<Map<String, dynamic>> categoryList) {
    final categories = <Category>[];

    categoryList.forEach((categoryMap) {
      final category = Category.fromJson(categoryMap);
      categories.add(category);
    });
    return categories;
  }

  List<Task> parseTasks(List<Map<String, dynamic>> taskList) {
    final tasks = <Task>[];

    taskList.forEach((taskMap) {
      final task = Task.fromJson(taskMap);
      tasks.add(task);
    });
    return tasks;
  }

  //**********--------????????????????---------******/
  //****** IMPLEMENTING REPOSITORY LIKE FUNCTIONS
  //**********--------????????????????---------******/

  Future<List<Category>> findAllCategories() async {
    final db = await instance.streamDatabase;
    final categoryList = await db.query(categoryTable);
    final categories = parseCategories(categoryList);
    return categories;
  }

  Future<List<Task>> findAllTasks() async {
    final db = await instance.streamDatabase;
    final taskList = await db.query(taskTable);
    final tasks = parseTasks(taskList);
    return tasks;
  }

  Stream<List<Category>> watchAllCategories() async* {
    final db = await instance.streamDatabase;
    yield* db
        .createQuery(categoryTable)
        .mapToList((row) => Category.fromJson(row));
  }

  Stream<List<Task>> watchAllTasks() async* {
    final db = await instance.streamDatabase;
    yield* db.createQuery(taskTable).mapToList((row) => Task.fromJson(row));
  }

  Future<Category> findCategoryById(int id) async {
    final db = await instance.streamDatabase;
    final categoryList = await db.query(categoryTable, where: 'id=$id');
    final category = parseCategories(categoryList);
    return category.first;
  }

  Future<Task> findTaskById(int id) async {
    final db = await instance.streamDatabase;
    final taskList = await db.query(taskTable, where: 'id=$id');
    final task = parseTasks(taskList);
    return task.first;
  }

  Future<List<Task>> findCategoryTaskCount(int categoryId) async {
    final db = await instance.streamDatabase;
    final taskList = await db.query(taskTable, where: 'catId=$categoryId');
    final tasks = parseTasks(taskList);
    return tasks;
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

  Future<int> updateTask(Task task) {
    if(task.id != null) {
      return _update(taskTable, task.toJson(), taskId, task.id!);
    }else{
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

  Future<int> deleteTask(Task task) async {
    if(task.id != null) {
      return _delete(taskTable, taskId, task.id!);
    }else {
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

  Future<int> insertTask(Task task) async {
    return insert(taskTable, task.toJson());
  }

  void close() {
    _streamDatabase.close();
  }
}
