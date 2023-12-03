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
import 'package:rationes_curare/utility/comparer.dart';
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

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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
        Msg.showError(context, e);
      }

      return const [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final languageCode = Localizations.localeOf(context).languageCode;

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
                const Text(
                  'Autore',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                FutureBuilder(
                  future: _autori(),
                  builder: (context, snapshot) => Autocomplete<String>(
                    optionsBuilder: (textEditingValue) => snapshot.hasData && textEditingValue.text.isNotEmpty
                        ? Comparer.whereListContainsIgnoreCase(
                            snapshot.requireData,
                            textEditingValue.text,
                          )
                        : const [],
                  ),
                ),
                const SizedBox(height: 16),

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
