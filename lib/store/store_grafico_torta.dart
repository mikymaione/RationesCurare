/*
MIT License

Copyright (c) 2023 Michele Maione

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
import 'package:rationes_curare/data_structure/grafico_torta.dart';
import 'package:rationes_curare/store/db_base.dart';
import 'package:rationes_curare/store/query_manager.dart';

final class StoreGraficoTorta extends DbBase {
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
