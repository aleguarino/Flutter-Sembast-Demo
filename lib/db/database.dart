import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class DB {
  static final DB _db = DB._internal();
  factory DB() => _db;
  DB._internal();

  Database _database;
  Database get database => _database;

  Future<void> init() async {
    final String dbName = 'sembast.db';
    final String dir = (await getApplicationDocumentsDirectory()).path;
    final String dbPath = path.join(dir, dbName);

    // open or create a database
    this._database = await databaseFactoryIo.openDatabase(dbPath);
  }

  Future<void> close() async {
    await this._database.close();
  }
}
