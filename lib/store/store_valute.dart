/*
MIT License

Copyright (c) 2023 Michele Maione

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
import 'package:rationes_curare/data_structure/valute.dart';
import 'package:rationes_curare/store/db_base.dart';
import 'package:rationes_curare/store/db_list.dart';
import 'package:rationes_curare/store/db_select.dart';
import 'package:rationes_curare/store/db_to_entity.dart';
import 'package:rationes_curare/store/query_manager.dart';
import 'package:sqlite3/sqlite3.dart';

final class StoreValute extends DbBase with DbToEntity<Valute>, DbSelect<Valute>, DbList<Valute> {
  const StoreValute({
    required super.db,
  });

  @override
  Queries get listQuery => Queries.Casse_Valute;

  @override
  Valute dbToEntity(Row r) => Valute(
        valuta: r['valuta'],
        descrizione: r['descrizione'],
      );

  Future<List<Valute>> lista({
    required int offset,
    required int limit,
  }) async =>
      await list(offset, limit, const []);
}
