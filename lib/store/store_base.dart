import 'package:flutter/widgets.dart';
import 'package:rationes_curare/store/query_manager.dart';
import 'package:rationes_curare/utility/callbacks.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite;

abstract class StoreBase<Entity> {
  final sqlite.Database db;

  const StoreBase({
    required this.db,
  });

  Entity dbToEntity(sqlite.Row r);

  Entity? _maybeDbToEntity(sqlite.Row? r) => r == null ? null : dbToEntity(r);

  List<Object?> entityToDb(Entity e);

  Future<void> set(
    BuildContext context,
    Queries query,
    Entity e,
    Generic0ParamCallback<List<Object?>> getParameters,
  ) async =>
      db.execute(
        await QueryManager.getSql(context, query),
        getParameters(),
      );

  Future<Entity?> get(
    BuildContext context,
    Queries query,
    int id,
  ) async =>
      _maybeDbToEntity(
        db.select(
          await QueryManager.getSql(context, query),
          [id],
        ).firstOrNull,
      );

  Future<List<Entity>> list(
    BuildContext context,
    Queries query,
    Generic0ParamCallback<List<Object?>> getParameters,
  ) async =>
      [
        for (final r in db.select(
          await QueryManager.getSql(context, query),
          getParameters(),
        )) ...[
          dbToEntity(r),
        ],
      ];
}
