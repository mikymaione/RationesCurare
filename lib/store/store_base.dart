/*
MIT License

Copyright (c) 2023 Michele Maione

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
import 'package:rationes_curare/store/db_base.dart';
import 'package:rationes_curare/store/query_manager.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite;

abstract class StoreBase<Entity, idType> extends DbBase {
  final bool isAutoInc;
  final Queries? deleteQuery, insertQuery, updateQuery, getQuery, listQuery;

  const StoreBase({
    required super.db,
    required this.isAutoInc,
    required this.deleteQuery,
    required this.insertQuery,
    required this.updateQuery,
    required this.getQuery,
    required this.listQuery,
  });

  Entity dbToEntity(sqlite.Row r);

  List<Object?> entityToDb(Entity e);

  Future<void> delete(
    idType id,
  ) async =>
      db.execute(
        await QueryManager.getSql(deleteQuery),
        [id],
      );

  Future<void> set(
    Entity e,
    idType? id,
  ) async =>
      db.execute(
        await QueryManager.getSql(id == null ? insertQuery : updateQuery),
        entityToDb(e) +
            [
              if (isAutoInc && id != null) ...[
                id,
              ],
            ],
      );

  Future<Entity> get(
    idType id,
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
