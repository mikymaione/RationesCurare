import 'package:rationes_curare/data_structure/movimenti.dart';
import 'package:rationes_curare/store/store_base.dart';
import 'package:sqlite3/sqlite3.dart';

class StoreMovimenti extends StoreBase<Movimenti> {
  const StoreMovimenti({
    required super.db,
  });

  @override
  Movimenti dbToEntity(Row r) => Movimenti(
        id: r['id'],
        idGiroconto: r['idGiroconto'],
        idMovimentiTempo: r['idMovimentiTempo'],
        nome: r['nome'],
        tipo: r['tipo'],
        descrizione: r['descrizione'],
        macroArea: r['macroArea'],
        data: r['data'],
        soldi: r['soldi'],
      );

  @override
  List<Object?> entityToDb(Movimenti e) => [
        e.nome,
        e.tipo,
        e.descrizione,
        e.soldi,
        e.data,
        e.macroArea,
      ];
}
