/*
MIT License

Copyright (c) 2023 Michele Maione

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
import 'package:rationes_curare/data_structure/movimenti.dart';
import 'package:rationes_curare/store/query_manager.dart';
import 'package:rationes_curare/store/store_base.dart';
import 'package:sqlite3/sqlite3.dart';

class StoreMovimenti extends StoreBase<Movimenti, int> {
  const StoreMovimenti({
    required super.db,
    super.isAutoInc = true,
    super.deleteQuery = Queries.Movimenti_Elimina,
    super.insertQuery = Queries.Movimenti_Inserisci,
    super.updateQuery = Queries.Movimenti_Aggiorna,
    super.getQuery = Queries.Movimenti_Dettaglio,
    super.listQuery = Queries.Movimenti_Ricerca,
  });

  @override
  Movimenti dbToEntity(Row r) => Movimenti(
        id: r['id'],
        idGiroconto: r['idGiroconto'],
        idMovimentiTempo: r['idMovimentiTempo'],
        nome: r['nome'],
        tipo: r['tipo'],
        descrizione: r['descrizione'],
        macroArea: r['macroArea'],
        data: r['data'],
        soldi: r['soldi'],
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

  Future<void> ricerca({
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
      await list(
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
      );

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

  Future<void> movimentiPerCassa({
    required String tipo,
  }) async =>
      db.select(
        await QueryManager.getSql(Queries.Movimenti_MovimentiPerCassa),
        [tipo],
      ).single['Tot'];

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
          r['descrizione'],
        ],
      ];

  Future<List<String>> macroAree({
    required bool useMacroArea,
  }) async =>
      [
        for (final r in db.select(
          await QueryManager.getSql(Queries.Movimenti_AutoCompleteSourceMA),
          const [],
        )) ...[
          r['MacroArea'],
        ],
      ];
}
