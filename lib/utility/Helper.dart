import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<String> getDbPath() async {
  String path = join(await getDatabasesPath(), 'my_database.db');
  return path;
}
