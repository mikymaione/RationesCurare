import 'package:flutter/widgets.dart';
import 'package:rationes_curare/store/query_manager.dart';
import 'package:rationes_curare/utility/callbacks.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite;

abstract class StoreBase<Entity> {
  static const _contextNotMounted = 'BuildContext not mounted';

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
    BuildContext context,
    Entity e,
    Generic0ParamCallback<List<Object?>> getParameters,
  ) async =>
      db.execute(
        context.mounted ? await QueryManager.getSql(context, deleteQuery) : throw Exception(_contextNotMounted),
        getParameters(),
      );

  Future<void> set(
    BuildContext context,
    int id,
    Entity e,
    Generic0ParamCallback<List<Object?>> getParameters,
  ) async =>
      db.execute(
          id > -1
              ? context.mounted
                  ? await QueryManager.getSql(context, updateQuery)
                  : throw Exception(_contextNotMounted)
              : context.mounted
                  ? await QueryManager.getSql(context, insertQuery)
                  : throw Exception(_contextNotMounted),
          getParameters());

  Future<List<Entity>> list(
    BuildContext context,
    Generic0ParamCallback<List<Object?>> getParameters,
  ) async =>
      [
        for (final r in db.select(
          context.mounted ? await QueryManager.getSql(context, listQuery) : throw Exception(_contextNotMounted),
          getParameters(),
        )) ...[
          dbToEntity(r),
        ],
      ];
}
