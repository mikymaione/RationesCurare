import 'package:rationes_curare/data_structure/grafico_spline.dart';
import 'package:rationes_curare/store/db_base.dart';
import 'package:rationes_curare/store/query_manager.dart';

class StoreGraficoSpline extends DbBase {
  const StoreGraficoSpline({
    required super.db,
  });

  Future<List<GraficoSpline>> grafico() async => [
        for (final r in db.select(
          await QueryManager.getSql(Queries.Movimenti_GraficoSplineAnnuale),
          const [],
        )) ...[
          GraficoSpline(
            periodo: r['Mese'],
            soldi: r['Soldini_TOT'],
          ),
        ],
      ];

  Future<double> saldo() async => db.select(
        await QueryManager.getSql(Queries.Movimenti_GraficoSaldoSpline),
        const [],
      ).single['Soldini_TOT'];
}
