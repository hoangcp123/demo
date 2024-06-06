import 'package:sqflite/sqflite.dart';
import 'package:demo/db_help/db_connection.dart';
import 'package:demo/models/staff.dart';

class StaffRepository {
  late DBConnection _dbConnection;

  StaffRepository() {
    _dbConnection = DBConnection();
  }

  Future<Database> get database async {
    return await _dbConnection.getDatabase();
  }

  insertStaff(String table, Map<String, dynamic> data) async {
    var db = await database;
    return await db.insert(table, data);
  }

  updateStaff(String table, Map<String, dynamic> data) async {
    var db = await database;
    return await db.update(table, data, where: 'staffId = ?', whereArgs: [data['staffId']]);
  }

  getStaffs(String table) async {
    var db = await database;
    return await db.query(table);
  }

  getStaffById(String table, int staffId) async {
    var db = await database;
    return await db.query(table, where: 'staffId = ?', whereArgs: [staffId]);
  }

  deleteStaff(String table, int staffId) async {
    var db = await database;
    return await db.delete(table, where: 'staffId = ?', whereArgs: [staffId]);
  }
}