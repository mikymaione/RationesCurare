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

  Future<double> saldo({
    required String tipo,
    required String? descrizione,
    required String? macroArea,
    required bool usaSoldi,
    required double soldiDa,
    required double soldiA,
    required bool usaData,
    required double dataDa,
    required double dataA,
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
}
