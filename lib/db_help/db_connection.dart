import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBConnection {
  Future<Database> getDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'new_db_staff');
    var database = openDatabase(path, version: 1, onCreate: _createDatabase);
    return database;
  }

  Future<void> _createDatabase(Database database, int version) async {
    String sql = "CREATE TABLE Staff(staffId INTEGER PRIMARY KEY, staffName TEXT, department TEXT, position TEXT)";
    await database.execute(sql);
  }
}