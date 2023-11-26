/*
MIT License

Copyright (c) 2023 Michele Maione

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
import 'package:rationes_curare/data_structure/movimenti_tempo.dart';
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

final class StoreMovimentiTempo extends DbBase with EntityToDb<MovimentiTempo>, DbToEntity<MovimentiTempo>, DbSet<MovimentiTempo, int>, DbDelete<MovimentiTempo, int>, DbGet<MovimentiTempo, int>, DbSelect<MovimentiTempo>, DbList<MovimentiTempo> {
  const StoreMovimentiTempo({
    required super.db,
  });

  @override
  bool get isAutoInc => true;

  @override
  Queries get insertQuery => Queries.Periodici_Inserisci;

  @override
  Queries get updateQuery => Queries.Periodici_Aggiorna;

  @override
  Queries get deleteQuery => Queries.Periodici_Elimina;

  @override
  Queries get getQuery => Queries.Periodici_Dettaglio;

  @override
  Queries get listQuery => Queries.Periodici_Ricerca;

  @override
  MovimentiTempo dbToEntity(Row r) => MovimentiTempo(
        id: r['id'],
        nome: r['nome'],
        tipo: r['tipo'],
        descrizione: r['descrizione'],
        macroArea: r['macroArea'],
        soldi: r['soldi'],
        numeroGiorni: r['numeroGiorni'],
        giornoDelMese: r['giornoDelMese'],
        tipoGiorniMese: Periodicita.fromCode(r['tipoGiorniMese']),
        partendoDalGiorno: r['partendoDalGiorno'],
        scadenza: r['scadenza'],
      );

  @override
  List<Object?> entityToDb(MovimentiTempo e) => [
        e.nome,
        e.tipo,
        e.descrizione,
        e.soldi,
        e.numeroGiorni,
        e.giornoDelMese,
        e.partendoDalGiorno,
        e.scadenza,
        e.tipoGiorniMese.code,
        e.macroArea,
      ];

  Future<List<MovimentiTempo>> ricerca() async => await list(const []);

  Future<List<MovimentiTempo>> scadenza({
    required DateTime dataDa,
    required DateTime dataA,
  }) async =>
      await list(
        [
          dataDa,
          dataA,
          dataDa,
          dataA,
        ],
      );
}
