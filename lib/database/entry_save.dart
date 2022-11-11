import 'dart:io';
import 'package:expense_tracker/model/expense_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class DatabaseHelper{

  static const _dbName="myDatabase.db";
  static  const  _dbVersion=1;
  static const _tableName="myTable";
  static const  columnId="_id";

  DatabaseHelper._privateConstructor();

  static DatabaseHelper instance=DatabaseHelper._privateConstructor();

  Database? _database;

  Future<Database?>get database async{
    if(_database!=null)return _database;

    _database=await _initiateDatabase();
    return _database;

  }

  Future<Database>_initiateDatabase()async{

    Directory directory=await getApplicationDocumentsDirectory();
    String path=join(directory.path,_dbName);
    return await openDatabase(path,version: 1,onCreate: onCreated);


  }

  Future<void> onCreated(Database db,int version)async{

    await db.execute("CREATE TABLE $_tableName($columnId INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,description TEXT,date TEXT,time TEXT,expenseField TEXT,amount TEXT)");


  }


  Future<int>insert(ExpenseModel expenseModel)async{
    Database? db=await instance.database;
     return await db!.insert(_tableName, expenseModel.toMap());


  }

  Future<List<Map<String,dynamic>>>queryAll()async{
    Database? db=await instance.database;
    return await db!.query(_tableName);

  }

}



