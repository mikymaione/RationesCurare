/*
MIT License

Copyright (c) 2023 Michele Maione

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
import 'package:flutter/material.dart';
import 'package:rationes_curare/ui/transaction_screen.dart';
import 'package:rationes_curare/utility/callbacks.dart';
import 'package:rationes_curare/utility/commons.dart';
import 'package:sqlite3/common.dart' as sqlite;

class NewTransactionButton extends StatelessWidget {
  final sqlite.CommonDatabase db;
  final Void0ParamCallback onSave;
  final String? account;

  const NewTransactionButton({
    super.key,
    required this.db,
    required this.onSave,
    this.account,
  });

  Future<void> _newTransaction(BuildContext context) async {
    final saved = await Commons.navigate<bool>(
      context: context,
      builder: (context) => TransactionScreen(
        db: db,
        account: account,
      ),
    );

    if (true == saved) {
      onSave();
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'New Transaction',
      icon: const Icon(Icons.add),
      onPressed: () => _newTransaction(context),
    );
  }
}
