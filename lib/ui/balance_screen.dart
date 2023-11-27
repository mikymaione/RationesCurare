/*
MIT License

Copyright (c) 2023 Michele Maione

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rationes_curare/data_structure/movimenti.dart';
import 'package:rationes_curare/store/store_movimenti.dart';
import 'package:rationes_curare/ui/base/msg.dart';
import 'package:rationes_curare/ui/base/screen.dart';
import 'package:sqlite3/common.dart';

class BalanceScreen extends StatelessWidget {
  final formatCurrency = NumberFormat.simpleCurrency();
  final CommonDatabase db;

  BalanceScreen({
    super.key,
    required this.db,
  });

  Future<List<MovimentiSaldoPerCassa>> load(BuildContext context) async {
    final store = StoreMovimenti(db: db);

    try {
      return await store.movimentiSaldoPerCassa(showEmpty: false);
    } catch (e) {
      Msg.showError(context, e);
      return const [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      title: 'Worklick - Casse',
      body: FutureBuilder<List<MovimentiSaldoPerCassa>>(
        future: load(context),
        builder: (context, snapMovimentiSaldoPerCassa) => ListView(
          children: [
            if (snapMovimentiSaldoPerCassa.hasData) ...[
              for (final c in snapMovimentiSaldoPerCassa.requireData) ...[
                ListTile(
                  title: Text(c.tipo),
                  subtitle: Text(formatCurrency.format(c.tot)),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}
