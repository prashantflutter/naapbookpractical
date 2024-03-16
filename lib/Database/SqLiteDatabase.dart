import 'dart:developer';

import 'package:sqflite/sqflite.dart' as sql;

import 'UserModel.dart';


class SQLiteDatabase {

  //// CREATED TABLE ////

  static Future<void>createTable(sql.Database database)async{
    await database.execute(
        """CREATE TABLE naapBookData(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    fName TEXT,
    lName TEXT,
    email TEXT,
    mobile TEXT,
    password TEXT,
    designation TEXT,
    createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP 
    )""");
  }


  static Future<void>addContactTable(sql.Database database)async{
    await database.execute(
        """CREATE TABLE addContactData(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    name TEXT,
    mobile TEXT,
    createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP 
    )""");
  }

  ////// Created Database ////////
  static Future<sql.Database>db()async{
    return sql.openDatabase('naapbookDataBase.db',version: 1,onCreate: (sql.Database database,int version)async{
      await createTable(database);
    });
  }

  static Future<sql.Database>addDb()async{
    return sql.openDatabase('contactDatabase.db',version: 1,onCreate: (sql.Database database,int version)async{
      await addContactTable(database);
    });
  }


  // Create Method for store data in database
  static Future<int> createData({
    required String fName,
    required String lName,
    required String email,
    required String mobile,
    required String password,
    required String designation,
  })async{

    // SQLiteDatabase class Name where created and all data pass in created object
    final db = await SQLiteDatabase.db();
    final data = {
      'fName':fName,
      'lName':lName,
      'email':email,
      'mobile':mobile,
      'password':password,
      'designation':designation,
    };
    final id = await db.insert('naapBookData', data,conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;

  }

  static Future<int>addContacts({required String name,required String mobile})async{
    final db = await SQLiteDatabase.addDb();
    final data = {
      'name':name,
      'mobile':mobile,
    };
    final id = await db.insert('addContactData', data,conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }


  // Get All Data from Database Method Created
  static Future<List<Map<String,dynamic>>>getAllData()async{
    final db = await SQLiteDatabase.db();
    return db.query('naapBookData',orderBy: 'id');
  }

  static Future<List<Map<String,dynamic>>>getAllContactData()async{
    final db = await SQLiteDatabase.addDb();
    return db.query('addContactData',orderBy: 'id');
  }


  // Get Single Data from Database Method
  static  Future<List<Map<String,dynamic>>>getSingleData(int id)async{
    final db = await SQLiteDatabase.db();
    return db.query('naapBookData',where: 'id = ?',whereArgs: [id],limit: 1);
  }


  // Update Data in Database using this Method
  static Future<int>updateData(
      { required int id,
        required String fName,
        required String lName,
        required String email,
        required String mobile,
        required String password,
        required String designation,
      }
      )async{
    final db =  await SQLiteDatabase.db();
    final data = {
      'fName':fName,
      'lName':lName,
      'email':email,
      'mobile':mobile,
      'password':password,
      'designation':designation,
      'createdAt':DateTime.now().toString()
    };
    final result = await db.update('naapBookData', data,where: 'id = ?',whereArgs: [id]);
    return result;
  }

  // Delete Data from Database Created Method
  static Future<void>deleteData(int id)async{
    final db = await SQLiteDatabase.db();
    try{
      await db.delete('naapBookData',where: 'id = ?',whereArgs: [id]);
    }catch(e){
      print('error $e');
    }
  }

  static Future<List<Map<String, dynamic>>> searchDataByTitle(String title) async {
    final db = await SQLiteDatabase.db();
    return await db.query('naapBookData', where: 'title LIKE ?', whereArgs: ['%$title%']);
  }


 static Future<User?> getLogin(String email, String password) async {
    final db = await SQLiteDatabase.db();
    var res = await db.rawQuery("SELECT * FROM user WHERE email = '$email' and password = '$password'");

      log('Email Data :${email}');
      log('Password Data:${password}');
    if (res.length > 0) {
      return new User.fromMap(res.first);
    }
    return null;
  }

}
