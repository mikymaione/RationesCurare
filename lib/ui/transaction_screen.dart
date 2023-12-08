/*
MIT License

Copyright (c) 2023 Michele Maione

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
import 'package:flutter/material.dart';
import 'package:rationes_curare/data_structure/movimenti.dart';
import 'package:rationes_curare/store/store_movimenti.dart';
import 'package:rationes_curare/ui/MoneyField.dart';
import 'package:rationes_curare/ui/base/auto_complete_edit.dart';
import 'package:rationes_curare/ui/base/generic_scrollable.dart';
import 'package:rationes_curare/ui/base/msg.dart';
import 'package:rationes_curare/ui/base/screen.dart';
import 'package:rationes_curare/utility/commons.dart';
import 'package:rationes_curare/utility/generic_controller.dart';
import 'package:sqlite3/common.dart' as sqlite;

class TransactionScreen extends StatefulWidget {
  final sqlite.CommonDatabase db;
  final Movimenti? transaction;

  const TransactionScreen({
    super.key,
    required this.db,
    required this.transaction,
  });

  @override
  State<StatefulWidget> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final formKey = GlobalKey<FormState>();

  final cNome = TextEditingController();
  final cImporto = GenericController<double>();
  final cDescrizione = TextEditingController();
  final cMacroarea = TextEditingController();

  @override
  void initState() {
    super.initState();
    Commons.printIfInDebug('initState');

    if (widget.transaction != null) {
      final t = widget.transaction!;

      cNome.text = t.nome;
      cImporto.value = t.soldi;
      cDescrizione.text = t.descrizione;
      cMacroarea.text = t.macroArea;
    }
  }

  @override
  void dispose() {
    cNome.dispose();
    cImporto.dispose();
    cDescrizione.dispose();
    cMacroarea.dispose();

    super.dispose();
  }

  void _save() {}

  void _delete() {}

  Future<List<String>> _autori() async {
    final store = StoreMovimenti(db: widget.db);

    try {
      return await store.autori();
    } catch (e) {
      if (context.mounted) {
        Msg.showErrorMsg(context, 'Error loading authors: $e');
      }

      return const [];
    }
  }

  Future<List<String>> _macroarea() async {
    final store = StoreMovimenti(db: widget.db);

    try {
      return await store.macroAree();
    } catch (e) {
      if (context.mounted) {
        Msg.showErrorMsg(context, 'Error loading macroareas: $e');
      }

      return const [];
    }
  }

  Future<List<String>> _descrizioni() async {
    final store = StoreMovimenti(db: widget.db);

    try {
      return await store.descrizioni();
    } catch (e) {
      if (context.mounted) {
        Msg.showErrorMsg(context, 'Error loading descriptions: $e');
      }

      return const [];
    }
  }

  Future<String?> _getMacroAreaByDescrizione(String descrizione) async {
    final store = StoreMovimenti(db: widget.db);

    try {
      return await store.macroAreeAndDescrizioni(descrizione: descrizione);
    } catch (e) {
      if (context.mounted) {
        Msg.showErrorMsg(context, 'Error loading macroareas by description: $e');
      }

      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Screen(
      title: 'Transaction',
      child: GenericScrollable(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Autore
                const Text(
                  'Autore',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                FutureBuilder<List<String>>(
                  initialData: const [],
                  future: _autori(),
                  builder: (context, snapshot) => AutoCompleteEdit(
                    controller: cNome,
                    items: snapshot.data,
                  ),
                ),
                const SizedBox(height: 16),

                // Importo
                const Text(
                  'Importo',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                MoneyField(
                  controller: cImporto,
                ),
                const SizedBox(height: 16),

                // Descrizione
                const Text(
                  'Descrizione',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                FutureBuilder<List<String>>(
                  initialData: const [],
                  future: _descrizioni(),
                  builder: (context, snapshot) => AutoCompleteEdit(
                    controller: cDescrizione,
                    items: snapshot.data,
                    onSelected: (description) async {
                      final maybeMacroArea = await _getMacroAreaByDescrizione(description);
                      Commons.printIfInDebug('maybeMacroArea: $maybeMacroArea');

                      setState(() {
                        cMacroarea.text = maybeMacroArea ?? '';
                      });
                    },
                  ),
                ),
                const SizedBox(height: 16),

                // Macroarea
                const Text(
                  'Macroarea',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                FutureBuilder<List<String>>(
                  initialData: const [],
                  future: _macroarea(),
                  builder: (context, snapshot) => AutoCompleteEdit(
                    controller: cMacroarea,
                    items: snapshot.data,
                  ),
                ),
                const SizedBox(height: 16),
                //
                // Buttons
                const SizedBox(height: 16),
                Row(
                  children: [
                    if (widget.transaction != null) ...[
                      ElevatedButton(
                        onPressed: () => _delete(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: themeData.colorScheme.errorContainer,
                        ),
                        child: const Text('Elimina'),
                      ),
                    ],
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () => _save(),
                      child: const Text('Salva'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
