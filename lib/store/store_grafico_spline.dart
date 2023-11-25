import 'package:rationes_curare/data_structure/grafico_spline.dart';
import 'package:rationes_curare/data_structure/valute.dart';
import 'package:rationes_curare/store/query_manager.dart';
import 'package:rationes_curare/store/store_base.dart';
import 'package:sqlite3/sqlite3.dart';

class StoreGraficoSpline extends StoreBase<Valute, String> {
  const StoreGraficoSpline({
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
