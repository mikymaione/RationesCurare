/*
MIT License

Copyright (c) 2023 Michele Maione

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
import 'package:rationes_curare/data_structure/db_info.dart';
import 'package:rationes_curare/store/query_manager.dart';
import 'package:rationes_curare/store/store_base.dart';
import 'package:sqlite3/sqlite3.dart';

class StoreDbInfo extends StoreBase<DbInfo, String> {
  const StoreDbInfo({
    required super.db,
    super.isAutoInc = false,
    super.deleteQuery,
    super.insertQuery = Queries.DBInfo_Inserisci,
    super.updateQuery = Queries.DBInfo_Aggiorna,
    super.getQuery = Queries.DBInfo_Dettaglio,
    super.listQuery,
  });

  @override
  DbInfo dbToEntity(Row r) => DbInfo(
        email: r['email'],
        nome: r['nome'],
        psw: r['psw'],
        sincronizzaDB: r['sincronizzaDB'],
        valuta: r['valuta'],
        ultimaModifica: r['ultimaModifica'],
        ultimoAggiornamentoDB: r['ultimoAggiornamentoDB'],
      );

  @override
  List<Object?> entityToDb(DbInfo e) => [
        e.nome,
        e.psw,
        e.sincronizzaDB,
        e.ultimaModifica,
        e.ultimoAggiornamentoDB,
        e.valuta,
        e.email,
      ];
}
