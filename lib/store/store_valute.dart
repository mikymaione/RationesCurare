import 'package:rationes_curare/data_structure/valute.dart';
import 'package:rationes_curare/store/query_manager.dart';
import 'package:rationes_curare/store/store_base.dart';
import 'package:sqlite3/sqlite3.dart';

class StoreValute extends StoreBase<Valute> {
  const StoreValute({
    required super.db,
    super.deleteQuery,
    super.insertQuery,
    super.updateQuery,
    super.listQuery = Queries.Casse_Valute,
  });

  @override
  Valute dbToEntity(Row r) => Valute(
        valuta: r['valuta'],
        descrizione: r['descrizione'],
      );

  @override
  List<Object?> entityToDb(Valute e) => [
        e.valuta,
        e.descrizione,
      ];
}
