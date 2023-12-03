/*
MIT License

Copyright (c) 2023 Michele Maione

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
import 'package:flutter/material.dart';
import 'package:rationes_curare/data_structure/movimenti.dart';
import 'package:rationes_curare/store/store_movimenti.dart';
import 'package:rationes_curare/ui/account_content_screen.dart';
import 'package:rationes_curare/ui/base/msg.dart';
import 'package:rationes_curare/ui/base/screen.dart';
import 'package:rationes_curare/utility/commons.dart';
import 'package:rationes_curare/utility/formatters.dart';
import 'package:sqlite3/common.dart' as sqlite;

class BalanceScreen extends StatelessWidget {
  final sqlite.CommonDatabase db;

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
          tipo: 'Totale',
          tot: saldo,
        ),
      ];
    } catch (e) {
      if (context.mounted) {
        Msg.showError(context, e);
      }

      return const [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorOdd = Theme.of(context).colorScheme.primary.withOpacity(0.02);
    final colorEven = Theme.of(context).colorScheme.primary.withOpacity(0.04);
    final colorTotal = Theme.of(context).colorScheme.primary.withOpacity(0.10);

    final languageCode = Localizations.localeOf(context).languageCode;

    return Screen(
      title: 'RationesCurare',
      child: FutureBuilder<List<MovimentiSaldoPerCassa>>(
        initialData: const [],
        future: load(context),
        builder: (context, snap) {
          final rows = snap.data ?? [];

          return ListView.builder(
            itemCount: rows.length,
            itemBuilder: (context, index) => index == rows.length - 1
                ? ListTile(
                    tileColor: colorTotal,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          Formatters.doubleToMoney(languageCode, rows[index].tot),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListTile(
                    tileColor: index.isEven ? colorEven : colorOdd,
                    onTap: () => Commons.navigate(
                      context: context,
                      builder: (context) => AccountContentScreen(
                        db: db,
                        movimentiSaldoPerCassa: rows[index],
                      ),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(rows[index].tipo),
                        Text(
                          Formatters.doubleToMoney(languageCode, rows[index].tot),
                        ),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}
