import 'package:rationes_curare/data_structure/grafico_torta.dart';
import 'package:rationes_curare/store/db_base.dart';
import 'package:rationes_curare/store/query_manager.dart';

class StoreGraficoTorta extends DbBase {
  const StoreGraficoTorta({
    required super.db,
  });

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
