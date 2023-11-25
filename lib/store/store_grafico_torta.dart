import 'package:rationes_curare/data_structure/grafico_torta.dart';
import 'package:rationes_curare/data_structure/valute.dart';
import 'package:rationes_curare/store/query_manager.dart';
import 'package:rationes_curare/store/store_base.dart';
import 'package:sqlite3/sqlite3.dart';

class StoreGraficoTorta extends StoreBase<Valute, String> {
  const StoreGraficoTorta({
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

  Future<List<GraficoTorta>> grafico({
    required int sPos,
    required DateTime dataDa,
    required DateTime dataA,
  }) async =>
      [
        for (final r in db.select(
          await QueryManager.getSql(Queries.Movimenti_GraficoTorta),
          [
            sPos,
            sPos,
            sPos,
            dataDa,
            dataA,
          ],
        )) ...[
          GraficoTorta(
            macroArea: r['MacroArea'],
            soldi: r['Soldini_TOT'],
          ),
        ],
      ];

  Future<double> saldo({
    required int sPos,
    required DateTime dataDa,
    required DateTime dataA,
  }) async =>
      db.select(
        await QueryManager.getSql(Queries.Movimenti_GraficoTortaSaldo),
        [
          sPos,
          sPos,
          sPos,
          dataDa,
          dataA,
        ],
      ).single['Soldini_TOT'];
}
