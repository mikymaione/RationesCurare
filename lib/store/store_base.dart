import 'package:rationes_curare/store/query_manager.dart';
import 'package:rationes_curare/utility/callbacks.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite;

abstract class StoreBase<Entity> {
  final sqlite.Database db;
  final Queries? deleteQuery, insertQuery, updateQuery, listQuery;

  const StoreBase({
    required this.db,
    required this.deleteQuery,
    required this.insertQuery,
    required this.updateQuery,
    required this.listQuery,
  });

  Entity dbToEntity(sqlite.Row r);

  List<Object?> entityToDb(Entity e);

  Future<void> delete(
    Entity e,
    Generic0ParamCallback<List<Object?>> getParameters,
  ) async =>
      db.execute(
        await QueryManager.getSql(deleteQuery),
        getParameters(),
      );

  Future<void> set(
    int id,
    Entity e,
    Generic0ParamCallback<List<Object?>> getParameters,
  ) async =>
      db.execute(
        id > -1 ? await QueryManager.getSql(updateQuery) : await QueryManager.getSql(insertQuery),
        getParameters(),
      );

  Future<List<Entity>> list(
    Generic0ParamCallback<List<Object?>> getParameters,
  ) async =>
      [
        for (final r in db.select(
          await QueryManager.getSql(listQuery),
          getParameters(),
        )) ...[
          dbToEntity(r),
        ],
      ];
}
