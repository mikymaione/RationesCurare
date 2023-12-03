/*
MIT License

Copyright (c) 2023 Michele Maione

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rationes_curare/db/db.dart';
import 'package:rationes_curare/ui/balance_screen.dart';
import 'package:rationes_curare/ui/base/msg.dart';
import 'package:sqlite3/common.dart' show CommonDatabase;

class RationesCurare extends StatelessWidget {
  const RationesCurare({super.key});

  Future<CommonDatabase?> loadDb(BuildContext context) async {
    try {
      return await openDb('db');
    } catch (e) {
      Msg.showError(context, e);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rationes Curare',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('it'),
      ],
      themeMode: ThemeMode.system,
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: FutureBuilder<CommonDatabase?>(
        initialData: null,
        future: loadDb(context),
        builder: (context, snapCommonDatabase) => snapCommonDatabase.data == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : BalanceScreen(
                db: snapCommonDatabase.data!,
              ),
      ),
    );
  }
}
