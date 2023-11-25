import 'package:sqlite3/sqlite3.dart' as sqlite;

class DbBase {
  final sqlite.Database db;

  const DbBase({
    required this.db,
  });
}
