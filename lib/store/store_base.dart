import 'package:rationes_curare/store/query_manager.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite;

abstract class StoreBase<Entity> {
  final sqlite.Database db;
  final Queries? deleteQuery, insertQuery, updateQuery, getQuery, listQuery;

  const StoreBase({
    required this.db,
    required this.deleteQuery,
    required this.insertQuery,
    required this.updateQuery,
    required this.getQuery,
    required this.listQuery,
  });

  Entity dbToEntity(sqlite.Row r);

  List<Object?> entityToDb(Entity e);

  Future<void> delete(
    int id,
  ) async =>
      db.execute(
        await QueryManager.getSql(deleteQuery),
        [id],
      );

  Future<void> set(
    Entity e,
    int? id,
  ) async =>
      db.execute(
        await QueryManager.getSql(id == null ? insertQuery : updateQuery),
        entityToDb(e) +
            [
              if (id != null) ...[
                id,
              ],
            ],
      );

  Future<Entity> get(
    int id,
  ) async =>
      dbToEntity(
        db.select(
          await QueryManager.getSql(getQuery),
          [id],
        ).single,
      );

  Future<List<Entity>> list(
    List<Object?> parameters,
  ) async =>
      await select(listQuery, parameters);

  Future<List<Entity>> select(
    Queries? query,
    List<Object?> parameters,
  ) async =>
      [
        for (final r in db.select(
          await QueryManager.getSql(query),
          parameters,
        )) ...[
          dbToEntity(r),
        ],
      ];
}
