import 'package:flutter/services.dart' show rootBundle;

enum Queries {
  // Movimenti
  Movimenti_Inserisci,
  Movimenti_Aggiorna,
  Movimenti_AggiornaMacroAree,
  Movimenti_Ricerca,
  Movimenti_Saldo,
  Movimenti_Dettaglio,
  Movimenti_Elimina,
  Movimenti_AutoCompleteSource,
  Movimenti_AutoCompleteSourceMA,
  Movimenti_MovimentiPerCassa,
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
        final s = await rootBundle.loadString('assets/sql/$query.sql');
        _queries[query] = s;
      }

      return _queries[query]!;
    }
  }
}
