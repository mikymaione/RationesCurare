/*
MIT License

Copyright (c) 2023 Michele Maione

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
import 'package:dart_casing/dart_casing.dart';
import 'package:rationes_curare/data_structure/casse.dart';
import 'package:rationes_curare/store/db_base.dart';
import 'package:rationes_curare/store/db_delete.dart';
import 'package:rationes_curare/store/db_get.dart';
import 'package:rationes_curare/store/db_list.dart';
import 'package:rationes_curare/store/db_select.dart';
import 'package:rationes_curare/store/db_set.dart';
import 'package:rationes_curare/store/db_to_entity.dart';
import 'package:rationes_curare/store/entity_to_db.dart';
import 'package:rationes_curare/store/query_manager.dart';
import 'package:sqlite3/sqlite3.dart';

final class StoreCasse extends DbBase with EntityToDb<Casse>, DbToEntity<Casse>, DbSet<Casse, String>, DbDelete<Casse, String>, DbGet<Casse, String>, DbSelect<Casse>, DbList<Casse> {
  const StoreCasse({
    required super.db,
  });

  @override
  bool get isAutoInc => false;

  @override
  Queries get insertQuery => Queries.Casse_Inserisci;

  @override
  Queries get updateQuery => Queries.Casse_Aggiorna;

  @override
  Queries get deleteQuery => Queries.Casse_Elimina;

  @override
  Queries get getQuery => Queries.Casse_Carica;

  @override
  Queries get listQuery => Queries.Casse_Ricerca;

  @override
  Casse dbToEntity(Row r) => Casse(
        nome: r['Nome'],
        imgName: r['ImgName'],
        valuta: r['Valuta'],
        nascondi: r['Nascondi'],
      );

  @override
  List<Object?> entityToDb(Casse e) => [
        e.imgName,
        e.valuta,
        e.nascondi,
        e.nome,
      ];

  Future<List<Casse>> ricerca({
    required bool mostraTutte,
  }) async =>
      await list([mostraTutte]);

  Future<List<String>> lista() async => [
        for (final r in db.select(
          await QueryManager.getSql(Queries.Casse_Lista),
        )) ...[
          Casing.titleCase(r['Nome']),
        ],
      ];
}
