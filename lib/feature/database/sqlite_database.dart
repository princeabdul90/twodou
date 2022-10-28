/*
* Developer: Abubakar Abdullahi
* Date: 17/10/2022
*/

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:synchronized/synchronized.dart';
import 'package:sqlbrite/sqlbrite.dart';


class SqliteDatabase {
  static const _databaseName = 'TwoDou.db';
  static const _databaseVersion = 1;

  static const categoryTable = 'Category';
  static const categoryId = 'categoryId';

  static const taskTable = 'task';
  static const taskId = 'taskId';

  static late BriteDatabase _streamDatabase;

  SqliteDatabase._privateConstructor();
  static final SqliteDatabase instance = SqliteDatabase._privateConstructor();

  static var lock = Lock();

  static Database? _database;

  //**********--------????????????????---------******/
  //**** CREATE DATABASE  *******
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
        datetime STRING,
        note TEXT,
        status INTEGER DEFAULT 0
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

  void close() {
    _streamDatabase.close();
  }

}