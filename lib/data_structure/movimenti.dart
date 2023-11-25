class Movimenti {
  final int id, idGiroconto, idMovimentiTempo;
  final String nome, tipo, descrizione, macroArea;
  final DateTime data;
  final double soldi;

  const Movimenti({
    required this.id,
    required this.idGiroconto,
    required this.idMovimentiTempo,
    required this.nome,
    required this.tipo,
    required this.descrizione,
    required this.macroArea,
    required this.data,
    required this.soldi,
  });
}

class MovimentiDate {
  final DateTime minData, maxData;

  const MovimentiDate({
    required this.minData,
    required this.maxData,
  });
}

class MovimentiMacroAreaAndDescrizione {
  final String macroArea, descrizione;

  const MovimentiMacroAreaAndDescrizione({
    required this.macroArea,
    required this.descrizione,
  });
}
