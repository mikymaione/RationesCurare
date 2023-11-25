import 'package:rationes_curare/data_structure/movimenti_tempo.dart';
import 'package:rationes_curare/store/store_base.dart';
import 'package:sqlite3/sqlite3.dart';

class StoreMovimentiTempo extends StoreBase<MovimentiTempo> {
  const StoreMovimentiTempo({
    required super.db,
  });

  @override
  MovimentiTempo dbToEntity(Row r) => MovimentiTempo(
        id: r['id'],
        nome: r['nome'],
        tipo: r['tipo'],
        descrizione: r['descrizione'],
        macroArea: r['macroArea'],
        soldi: r['soldi'],
        numeroGiorni: r['numeroGiorni'],
        giornoDelMese: r['giornoDelMese'],
        tipoGiorniMese: Periodicita.fromCode(r['tipoGiorniMese']),
        partendoDalGiorno: r['partendoDalGiorno'],
        scadenza: r['scadenza'],
      );

  @override
  List<Object?> entityToDb(MovimentiTempo e) => [
        e.nome,
        e.tipo,
        e.descrizione,
        e.soldi,
        e.numeroGiorni,
        e.giornoDelMese,
        e.partendoDalGiorno,
        e.scadenza,
        e.tipoGiorniMese.code,
        e.macroArea,
      ];
}
