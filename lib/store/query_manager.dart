import 'package:flutter/widgets.dart';

enum Queries {
  Aggiornamenti,
  AggiornamentiDBUtente,
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
  Casse_Ricerca,
  Casse_Elimina,
  Casse_Valute,
  Casse_Lista,
  Casse_ListaEX,
  Casse_Inserisci,
  Casse_Aggiorna,
  Casse_Carica,
  Periodici_Dettaglio,
  Periodici_Ricerca,
  Periodici_RicercaAccess,
  Periodici_Scadenza,
  Periodici_Elimina,
  Periodici_Inserisci,
  Periodici_Aggiorna,
  Utenti_Lista,
  Utenti_Inserisci,
  Utenti_Aggiorna,
  Utenti_Elimina,
  Utenti_Dettaglio,
  Utenti_ByPath,
  Calendario_Ricerca,
  Calendario_Inserisci,
  Calendario_Aggiorna,
  Calendario_AggiornaSerie,
  Calendario_Elimina,
  Calendario_EliminaSerie,
  Calendario_Dettaglio,
  DBInfo_Dettaglio,
  DBInfo_Inserisci,
  DBInfo_Aggiorna,
}

class QueryManager {
  static final _queries = <Queries, String>{};

  static Future<String> getSql(BuildContext context, Queries? query) async {
    if (query == null) {
      throw UnimplementedError('Query');
    } else {
      if (!_queries.containsKey(query)) {
        final s = await DefaultAssetBundle.of(context).loadString('assets/sql/$query.sql');
        _queries[query] = s;
      }

      return _queries[query]!;
    }
  }
}
