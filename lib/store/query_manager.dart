/*
MIT License

Copyright (c) 2023 Michele Maione

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:rationes_curare/utility/commons.dart';

enum Queries {
  // Movimenti
  Movimenti_Inserisci,
  Movimenti_Aggiorna,
  Movimenti_AggiornaMacroAree,
  Movimenti_Ricerca,
  Movimenti_Saldo,
  Movimenti_SaldoAssoluto,
  Movimenti_Dettaglio,
  Movimenti_Elimina,
  Movimenti_AutoCompleteAutori,
  Movimenti_AutoCompleteSource,
  Movimenti_AutoCompleteSourceMA,
  Movimenti_MovimentiPerCassa,
  Movimenti_SaldoPerCassa,
  Movimenti_GetMacroAree_E_Descrizioni,
  Movimenti_GraficoTorta,
  Movimenti_GraficoAnnuale,
  Movimenti_GraficoMensile,
  Movimenti_GraficoSaldo,
  Movimenti_GraficoSaldoSpline,
  Movimenti_GraficoTortaSaldo,
  Movimenti_GraficoSplineAnnuale,
  Movimenti_Data,

  // Casse
  Casse_Ricerca,
  Casse_Elimina,
  Casse_Valute,
  Casse_Lista,
  Casse_Inserisci,
  Casse_Aggiorna,
  Casse_Carica,

  // Periodici
  Periodici_Dettaglio,
  Periodici_Ricerca,
  Periodici_Scadenza,
  Periodici_Elimina,
  Periodici_Inserisci,
  Periodici_Aggiorna,

  // Db Info
  DBInfo_Dettaglio,
  DBInfo_Inserisci,
  DBInfo_Aggiorna,
}

class QueryManager {
  static final _queries = <Queries, String>{};

  static Future<String> getSql(Queries? query) async {
    if (query == null) {
      throw UnimplementedError('Query not defined');
    } else {
      if (!_queries.containsKey(query)) {
        final filename = 'assets/sql/${query.name}.sql';
        Commons.printIfInDebug('Opening: $filename');

        _queries[query] = await rootBundle.loadString(filename);
      }

      final s = _queries[query]!;
      Commons.printIfInDebug('SQL: $s');

      return s;
    }
  }
}
