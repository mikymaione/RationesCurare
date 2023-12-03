/*
MIT License

Copyright (c) 2023 Michele Maione

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
import 'package:rationes_curare/data_structure/movimenti.dart';
import 'package:rationes_curare/store/db_base.dart';
import 'package:rationes_curare/store/db_delete.dart';
import 'package:rationes_curare/store/db_get.dart';
import 'package:rationes_curare/store/db_list.dart';
import 'package:rationes_curare/store/db_select.dart';
import 'package:rationes_curare/store/db_set.dart';
import 'package:rationes_curare/store/db_to_entity.dart';
import 'package:rationes_curare/store/entity_to_db.dart';
import 'package:rationes_curare/store/query_manager.dart';
import 'package:rationes_curare/utility/formatters.dart';
import 'package:sqlite3/sqlite3.dart';

final class StoreMovimenti extends DbBase
    with EntityToDb<Movimenti>, DbToEntity<Movimenti>, DbSet<Movimenti, int>, DbDelete<Movimenti, int>, DbGet<Movimenti, int>, DbSelect<Movimenti>, DbList<Movimenti> {
  const StoreMovimenti({
    required super.db,
  });

  @override
  bool get isAutoInc => true;

  @override
  Queries get insertQuery => Queries.Movimenti_Inserisci;

  @override
  Queries get updateQuery => Queries.Movimenti_Aggiorna;

  @override
  Queries get deleteQuery => Queries.Movimenti_Elimina;

  @override
  Queries get getQuery => Queries.Movimenti_Dettaglio;

  @override
  Queries get listQuery => Queries.Movimenti_Ricerca;

  @override
  Movimenti dbToEntity(Row r) => Movimenti(
        id: r['ID'],
        nome: r['Nome'],
        data: Formatters.sqliteToDateTime(r['Data']),
        tipo: r['Tipo'],
        descrizione: r['Descrizione'],
        macroArea: r['MacroArea'],
        soldi: r['Soldi'],
        idGiroconto: r['IDGiroconto'],
        idMovimentoTempo: r['IDMovimentoTempo'],
      );

  @override
  List<Object?> entityToDb(Movimenti e) => [
        e.nome,
        e.tipo,
        e.descrizione,
        e.soldi,
        e.data,
        e.macroArea,
      ];

  Future<List<Movimenti>> ricerca({
    String? tipo,
    String? descrizione,
    String? macroArea,
    bool? usaSoldi,
    double? soldiDa,
    double? soldiA,
    bool? usaData,
    DateTime? dataDa,
    DateTime? dataA,
  }) async =>
      await list(
        [
          tipo ?? 'Saldo',
          tipo ?? '',
          Formatters.likeLR(descrizione ?? ''),
          Formatters.likeLR(macroArea ?? ''),
          usaSoldi ?? false,
          soldiDa ?? 0,
          soldiA ?? 0,
          usaData ?? false,
          dataDa ?? Formatters.dateTimeToSqliteNow(),
          dataA ?? Formatters.dateTimeToSqliteNow(),
        ],
      );

  Future<double> saldoAssoluto() async => db.select(
        await QueryManager.getSql(Queries.Movimenti_SaldoAssoluto),
        const [],
      ).single['Saldo'];

  Future<double> saldo({
    required String tipo,
    required String? descrizione,
    required String? macroArea,
    required bool usaSoldi,
    required double soldiDa,
    required double soldiA,
    required bool usaData,
    required DateTime dataDa,
    required DateTime dataA,
  }) async =>
      db.select(
        await QueryManager.getSql(Queries.Movimenti_Saldo),
        [
          tipo,
          tipo,
          '%$descrizione%',
          '%$macroArea%',
          usaSoldi,
          soldiDa,
          soldiA,
          usaData,
          dataDa,
          dataA,
        ],
      ).single['Saldo'];

  Future<int> numeroMovimentiPerCassa({
    required String tipo,
  }) async =>
      db.select(
        await QueryManager.getSql(Queries.Movimenti_MovimentiPerCassa),
        [tipo],
      ).single['Tot'];

  Future<List<MovimentiSaldoPerCassa>> movimentiSaldoPerCassa({required bool showEmpty}) async {
    final items = await _movimentiSaldoPerCassaAll();

    return showEmpty
        ? items
        : [
            for (final i in items) ...[
              if (i.tot.toInt() != 0) ...[
                i,
              ],
            ],
          ];
  }

  Future<List<MovimentiSaldoPerCassa>> _movimentiSaldoPerCassaAll() async => [
        for (final r in db.select(
          await QueryManager.getSql(Queries.Movimenti_SaldoPerCassa),
          const [],
        )) ...[
          MovimentiSaldoPerCassa(
            tot: r['Tot'],
            tipo: r['Tipo'],
          ),
        ],
      ];

  Future<MovimentiDate> data() async {
    final r = db.select(
      await QueryManager.getSql(Queries.Movimenti_Data),
      const [],
    ).single;

    return MovimentiDate(
      minData: r['minData'],
      maxData: r['maxData'],
    );
  }

  Future<List<MovimentiMacroAreaAndDescrizione>> macroAreeAndDescrizioni() async => [
        for (final r in db.select(
          await QueryManager.getSql(Queries.Movimenti_GetMacroAree_E_Descrizioni),
          const [],
        )) ...[
          MovimentiMacroAreaAndDescrizione(
            macroArea: r['MacroArea'],
            descrizione: r['descrizione'],
          ),
        ],
      ];

  Future<List<String>> descrizioni() async => [
        for (final r in db.select(
          await QueryManager.getSql(Queries.Movimenti_AutoCompleteSource),
          const [],
        )) ...[
          r['Descrizione'],
        ],
      ];

  Future<List<String>> autori() async => [
        for (final r in db.select(
          await QueryManager.getSql(Queries.Movimenti_AutoCompleteAutori),
          const [],
        )) ...[
          r['Nome'],
        ],
      ];

  Future<List<String>> macroAree() async => [
        for (final r in db.select(
          await QueryManager.getSql(Queries.Movimenti_AutoCompleteSourceMA),
          const [],
        )) ...[
          r['MacroArea'],
        ],
      ];
}
