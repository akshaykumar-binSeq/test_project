import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../model/data_model.dart';

class DatabaseSql {
  late Database database;
  late int count;

  Future<void> openDatabaseSql() async {
// Get a location using getDatabasesPath
    var databasepath = await getDatabasesPath();
    String path = join(databasepath, 'user_data.db');

// Open the database
    database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE userData(id TEXT PRIMARY KEY, name TEXT, email TEXT, mobile TEXT, gender TEXT)",
        );
      },
    );
  }

  Future<bool> insertData(UserDetails userDetail) async {
    print(
        "__________________________insertData________________________________");

    await database.transaction((txn) async {
      int insertFlag = await txn.rawInsert(
          'INSERT INTO userData(id, name, email, mobile, gender) VALUES("${userDetail.id}","${userDetail.name}","${userDetail.email}","${userDetail.mobile}","${userDetail.gender}")');
      print("---------------------insertData--------------------------");
      print('inserted: $insertFlag');
    });
    return true;
  }

  Future<bool> updateData(String name, String id) async {
    count = await database
        .rawUpdate('UPDATE userData SET name = ? WHERE id = ?', [name, id]);
    print("-----------------------updateData---------------------------");
    print("id: $id");
    print("Name: $name");
    return true;
  }

  Future<bool> deleteData(String id) async {
    count = await database.rawDelete('DELETE FROM userData WHERE id = ?', [id]);
    print(id);
    return true;
  }

  ///to clear cart call this1
  Future<bool> deleteAllData() async {
    print("_______________________delAllData___________________________");
    count = await database.rawDelete('DELETE FROM userData');
    return true;
  }

  Future<List<UserDetails>> getData() async {
    List<UserDetails> userList = [];
    List<Map> list = await database.rawQuery('SELECT * FROM userData');

    /// convert to list
    for (var map in list) {
      userList.add(UserDetails.fromMap(map));
    }

    return userList;
  }
}
