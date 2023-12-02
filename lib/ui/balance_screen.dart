/*
MIT License

Copyright (c) 2023 Michele Maione

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
import 'package:flutter/material.dart';
import 'package:rationes_curare/data_structure/movimenti.dart';
import 'package:rationes_curare/store/store_movimenti.dart';
import 'package:rationes_curare/ui/base/generic_scrollable.dart';
import 'package:rationes_curare/ui/base/msg.dart';
import 'package:rationes_curare/ui/base/screen.dart';
import 'package:rationes_curare/ui/base/sortable_grid.dart';
import 'package:rationes_curare/utility/comparer.dart';
import 'package:rationes_curare/utility/formatters.dart';
import 'package:sqlite3/common.dart';

class BalanceScreen extends StatelessWidget {
  final CommonDatabase db;

  const BalanceScreen({
    super.key,
    required this.db,
  });

  Future<List<MovimentiSaldoPerCassa>> load(BuildContext context) async {
    final store = StoreMovimenti(db: db);

    try {
      final movimenti = await store.movimentiSaldoPerCassa(showEmpty: false);
      final saldo = await store.saldoAssoluto();

      return [
        ...movimenti,
        MovimentiSaldoPerCassa(
          tot: saldo,
          tipo: '',
        ),
      ];
    } catch (e) {
      Msg.showError(context, e);
      return const [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      title: 'RationesCurare - Casse',
      child: GenericScrollable(
        scrollDirection: Axis.vertical,
        child: FutureBuilder<List<MovimentiSaldoPerCassa>>(
          future: load(context),
          builder: (context, snapMovimentiSaldoPerCassa) => SortableGrid<MovimentiSaldoPerCassa, String>(
            lastRowIsTotal: true,
            initialSortColumnIndexIndicator: 0,
            initialSortAscendingIndicator: true,
            items: snapMovimentiSaldoPerCassa.data ?? [],
            onSort: (columnIndex, d, items) {
              items.sort((a, b) {
                // match with columns
                switch (columnIndex) {
                  case 1:
                    return Comparer.compare<double>(a.tot, b.tot, (j, o) => j.compareTo(o)) * d;

                  default: // also 0
                    return Comparer.compare<String>(a.tipo, b.tipo, (j, o) => j.compareTo(o)) * d;
                }
              });
            },
            columns: const [
              RcDataColumn(
                title: ('Cassa'),
              ),
              RcDataColumn(
                title: ('Saldo'),
                isNumeric: true,
              ),
            ],
            rows: (rows) => [
              for (final c in rows) ...[
                RcDataRow<String>(
                  id: c.tipo,
                  selected: false,
                  cells: [
                    RcDataCell(value: (c.tipo)),
                    RcDataCell(value: (Formatters.doubleToMoney(c.tot))),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
