import 'package:rationes_curare/data_structure/Casse.dart';
import 'package:rationes_curare/store/query_manager.dart';
import 'package:rationes_curare/store/store_base.dart';
import 'package:sqlite3/sqlite3.dart';

class StoreCasse extends StoreBase<Casse> {
  const StoreCasse({
    required super.db,
    super.deleteQuery = Queries.Casse_Elimina,
    super.insertQuery = Queries.Casse_Inserisci,
    super.updateQuery = Queries.Casse_Aggiorna,
    super.getQuery = Queries.Casse_Carica,
    super.listQuery = Queries.Casse_Ricerca,
  });

  @override
  Casse dbToEntity(Row r) => Casse(
        nome: r['nome'],
        imgName: r['imgName'],
        valuta: r['valuta'],
        nascondi: r['nascondi'],
      );

  @override
  List<Object?> entityToDb(Casse e) => [
        e.nome,
        e.imgName,
        e.valuta,
        e.nascondi,
      ];

  Future<List<Casse>> ricerca({
    required bool mostraTutte,
  }) async =>
      await list([mostraTutte]);

  Future<List<Casse>> lista() async => await select(
        Queries.Casse_Lista,
        const [],
      );
}
