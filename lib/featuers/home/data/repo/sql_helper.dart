import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../models/catogry_itme_model.dart';
// import '../models/task.dart';
import '../models/utils.dart';

class DBHelper {
  DBHelper._();
  static final DBHelper _db = DBHelper._();
  factory DBHelper() {
    return _db;
  }
  Database? _database;

  Future<Database> get dB async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = '${dir.path}Cat';
    final taskList = await openDatabase(path, version: 1, onCreate: _onCreate);
    return taskList;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE Cat'
        '($taskId INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$taskTitle TEXT,'
        '$taskImage TEXT,'
        '$taskCatogry TEXT)');
  }
  //CRUD create read update delete

  //insert
  insertTask(CatogryItmeModel task) async {
    Database dBB = await dB;
    dBB.insert('Cat', task.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

//delete
  deleteTask(CatogryItmeModel taskModel) async {
    Database de = await dB;
    de.delete('Cat', where: '$taskId=?', whereArgs: [taskModel.id]);
  }

//update
  updateTask(CatogryItmeModel model) async {
    Database up = await dB;
    up.update('Cat', model.toJson(),
        whereArgs: [model.id], where: '$taskId=?');
  }

  Future<List<CatogryItmeModel>> getAllTasks() async {
    Database db = await dB;
    List<Map<String, dynamic>> maps = await db.query("Cat");
    return maps.map((e) => CatogryItmeModel.fromJson(e)).toList();
  }
}
