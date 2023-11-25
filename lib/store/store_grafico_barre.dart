import 'package:rationes_curare/data_structure/grafico_barre.dart';
import 'package:rationes_curare/data_structure/valute.dart';
import 'package:rationes_curare/store/query_manager.dart';
import 'package:rationes_curare/store/store_base.dart';
import 'package:sqlite3/sqlite3.dart';

class StoreGraficoBarre extends StoreBase<Valute, String> {
  const StoreGraficoBarre({
    required super.db,
    super.deleteQuery,
    super.insertQuery,
    super.updateQuery,
    super.getQuery,
    super.listQuery,
  });

  @override
  Valute dbToEntity(Row r) => throw UnimplementedError();

  @override
  List<Object?> entityToDb(Valute e) => throw UnimplementedError();

  Future<List<GraficoBarre>> graficoAnnuale({
    required String? descrizione,
    required String? macroArea,
    required DateTime dataDa,
    required DateTime dataA,
  }) async =>
      await _grafico(
        query: Queries.Movimenti_GraficoAnnuale,
        descrizione: descrizione,
        macroArea: macroArea,
        dataDa: dataDa,
        dataA: dataA,
      );

  Future<List<GraficoBarre>> graficoMensile({
    required String? descrizione,
    required String? macroArea,
    required DateTime dataDa,
    required DateTime dataA,
  }) async =>
      await _grafico(
        query: Queries.Movimenti_GraficoMensile,
        descrizione: descrizione,
        macroArea: macroArea,
        dataDa: dataDa,
        dataA: dataA,
      );

  Future<List<GraficoBarre>> _grafico({
    required Queries query,
    required String? descrizione,
    required String? macroArea,
    required DateTime dataDa,
    required DateTime dataA,
  }) async =>
      [
        for (final r in db.select(
          await QueryManager.getSql(query),
          [
            descrizione,
            macroArea,
            dataDa,
            dataA,
          ],
        )) ...[
          GraficoBarre(
            periodo: r['Mese'],
            soldi: r['Soldini_TOT'],
          ),
        ],
      ];

  Future<double> saldo({
    required String? descrizione,
    required String? macroArea,
    required DateTime dataDa,
    required DateTime dataA,
  }) async =>
      db.select(
        await QueryManager.getSql(Queries.Movimenti_GraficoTortaSaldo),
        [
          descrizione,
          macroArea,
          dataDa,
          dataA,
        ],
      ).single['Soldini_TOT'];
}
