import 'package:rationes_curare/data_structure/movimenti.dart';
import 'package:rationes_curare/store/query_manager.dart';
import 'package:rationes_curare/store/store_base.dart';
import 'package:sqlite3/sqlite3.dart';

class StoreMovimenti extends StoreBase<Movimenti> {
  const StoreMovimenti({
    required super.db,
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
        await QueryManager.getSql(Queries.Movimenti_Saldo),
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
