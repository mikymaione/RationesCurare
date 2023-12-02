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
import 'package:rationes_curare/utility/commons.dart';
import 'package:rationes_curare/utility/comparer.dart';
import 'package:rationes_curare/utility/formatters.dart';
import 'package:sqlite3/common.dart';

class AccountContent extends StatelessWidget {
  final CommonDatabase db;
  final MovimentiSaldoPerCassa movimentiSaldoPerCassa;

  const AccountContent({
    super.key,
    required this.db,
    required this.movimentiSaldoPerCassa,
  });

  Future<List<Movimenti>> load(BuildContext context) async {
    final store = StoreMovimenti(db: db);

    try {
      final movimenti = await store.ricerca(
        tipo: movimentiSaldoPerCassa.tipo,
      );

      return movimenti;
    } catch (e) {
      if (context.mounted) {
        Msg.showError(context, e);
      }

      return const [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final languageCode = Localizations.localeOf(context).languageCode;

    return Screen(
      title: 'RationesCurare - ${movimentiSaldoPerCassa.tipo}',
      child: GenericScrollable(
        scrollDirection: Axis.vertical,
        child: FutureBuilder<List<Movimenti>>(
          future: load(context),
          builder: (context, snap) => SortableGrid<Movimenti, String>(
            lastRowIsTotal: false,
            items: snap.data ?? [],
            initialSortAscendingIndicator: false,
            initialSortColumnIndexIndicator: 3,
            onSort: (columnIndex, d, items) {
              final total = items.removeLast();

              items.sort((a, b) {
                // match with columns
                switch (columnIndex) {
                  case 1:
                    return Comparer.compare<String>(a.tipo, b.tipo, (j, o) => j.compareTo(o)) * d;
                  case 2:
                    return Comparer.compare<double>(a.soldi, b.soldi, (j, o) => j.compareTo(o)) * d;
                  case 3:
                    return Comparer.compare<DateTime>(a.data, b.data, (j, o) => j.compareTo(o)) * d;
                  case 4:
                    return Comparer.compare<String>(a.macroArea, b.macroArea, (j, o) => j.compareTo(o)) * d;
                  case 5:
                    return Comparer.compare<String>(a.descrizione, b.descrizione, (j, o) => j.compareTo(o)) * d;
                  default: // also 0
                    return Comparer.compare<int>(a.id, b.id, (j, o) => j.compareTo(o)) * d;
                }
              });

              items.add(total);
            },
            columns: const [
              RcDataColumn(
                title: ('ID'),
              ),
              RcDataColumn(
                title: ('Cassa'),
              ),
              RcDataColumn(
                title: ('Importo'),
                isNumeric: true,
              ),
              RcDataColumn(
                title: ('Data'),
              ),
              RcDataColumn(
                title: ('Macro-area'),
              ),
              RcDataColumn(
                title: ('Descrizione'),
              ),
            ],
            rows: (rows) => [
              for (final c in rows) ...[
                RcDataRow<String>(
                  id: c.tipo,
                  cells: [
                    RcDataCell(
                      value: '${c.id}',
                      onUrlClick: () => Commons.navigate(
                        context: context,
                        builder: (context) => AccountContent(
                          db: db,
                          movimentiSaldoPerCassa: movimentiSaldoPerCassa,
                        ),
                      ),
                    ),
                    RcDataCell(
                      value: c.tipo,
                    ),
                    RcDataCell(
                      value: Formatters.doubleToMoney(languageCode, c.soldi),
                    ),
                    RcDataCell(
                      value: Formatters.datetimeYMDHm(languageCode, c.data),
                    ),
                    RcDataCell(
                      value: c.macroArea,
                    ),
                    RcDataCell(
                      value: c.descrizione,
                    ),
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
