/*
MIT License

Copyright (c) 2023 Michele Maione

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
import 'package:flutter/material.dart';
import 'package:rationes_curare/data_structure/movimenti.dart';
import 'package:rationes_curare/store/store_movimenti.dart';
import 'package:rationes_curare/ui/base/msg.dart';
import 'package:rationes_curare/ui/base/screen.dart';
import 'package:rationes_curare/utility/formatters.dart';
import 'package:sqlite3/common.dart' as sqlite;

class AccountContent extends StatelessWidget {
  final sqlite.CommonDatabase db;
  final MovimentiSaldoPerCassa movimentiSaldoPerCassa;

  AccountContent({
    super.key,
    required this.db,
    required this.movimentiSaldoPerCassa,
  });

  Future<List<Movimenti>> load(BuildContext context) async {
    final store = StoreMovimenti(db: db);

    try {
      return await store.ricerca(
        tipo: movimentiSaldoPerCassa.tipo,
      );
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

    final languageCode = Localizations.localeOf(context).languageCode;

    return Screen(
      title: movimentiSaldoPerCassa.tipo,
      child: FutureBuilder<List<Movimenti>>(
        future: load(context),
        builder: (context, snap) {
          final rows = snap.data ?? [];

          return ListView.builder(
            itemCount: rows.length,
            itemBuilder: (context, index) => ListTile(
              tileColor: index.isEven ? colorEven : colorOdd,
              title: Text(
                rows[index].macroArea,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          rows[index].descrizione,
                          style: TextStyle(
                            fontSize: Theme.of(context).textTheme.labelLarge?.fontSize,
                          ),
                        ),
                        Text(Formatters.datetimeYMDHm(languageCode, rows[index].data)),
                      ],
                    ),
                  ),
                  Text(Formatters.doubleToMoney(languageCode, rows[index].soldi)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
