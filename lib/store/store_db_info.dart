import 'package:rationes_curare/data_structure/db_info.dart';
import 'package:rationes_curare/store/query_manager.dart';
import 'package:rationes_curare/store/store_base.dart';
import 'package:sqlite3/sqlite3.dart';

class StoreDbInfo extends StoreBase<DbInfo> {
  const StoreDbInfo({
    required super.db,
    super.deleteQuery,
    super.insertQuery = Queries.DBInfo_Inserisci,
    super.updateQuery = Queries.DBInfo_Aggiorna,
    super.getQuery = Queries.DBInfo_Dettaglio,
    super.listQuery,
  });

  @override
  DbInfo dbToEntity(Row r) => DbInfo(
        email: r['email'],
        nome: r['nome'],
        psw: r['psw'],
        sincronizzaDB: r['sincronizzaDB'],
        valuta: r['valuta'],
        ultimaModifica: r['ultimaModifica'],
        ultimoAggiornamentoDB: r['ultimoAggiornamentoDB'],
      );

  @override
  List<Object?> entityToDb(DbInfo e) => [
        e.nome,
        e.psw,
        e.sincronizzaDB,
        e.ultimaModifica,
        e.ultimoAggiornamentoDB,
        e.valuta,
        e.email,
      ];
}
