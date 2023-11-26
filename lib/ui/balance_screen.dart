/*
MIT License

Copyright (c) 2023 Michele Maione

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
import 'package:flutter/material.dart';
import 'package:rationes_curare/data_structure/casse.dart';
import 'package:rationes_curare/db/db.dart';
import 'package:rationes_curare/store/store_casse.dart';
import 'package:rationes_curare/ui/base/msg.dart';
import 'package:rationes_curare/ui/base/screen.dart';

class BalanceScreen extends StatefulWidget {
  const BalanceScreen({super.key});

  @override
  State<StatefulWidget> createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  Future<List<Casse>> loadDb() async {
    final db = await openDb('c:/db', 'db');
    final store = StoreCasse(db: db);

    try {
      return await store.ricerca(mostraTutte: false);
    } catch (e) {
      Msg.showError(context, e);
      return const [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      title: 'Worklick - Casse',
      body: FutureBuilder<List<Casse>>(
        future: loadDb(),
        builder: (context, snapshot) => ListView(
          children: [
            if (snapshot.hasData) ...[
              for (final c in snapshot.requireData) ...[
                ListTile(
                  title: Text(c.nome),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}
