enum Periodicita {
  giornaliero(code: 'G', label: 'giornaliero'),
  mensile(code: 'M', label: 'mensile'),
  bimestrale(code: 'B', label: 'bimestrale'),
  trimestrale(code: 'T', label: 'trimestrale'),
  quadrimestrale(code: 'Q', label: 'quadrimestrale'),
  semestrale(code: 'S', label: 'semestrale'),
  annuale(code: 'A', label: 'annuale');

  final String code, label;

  const Periodicita({
    required this.code,
    required this.label,
  });
}

class MovimentiTempo {
  final int id;
  final String nome, tipo, descrizione, macroArea;
  final double soldi;

  final int numeroGiorni;
  final Periodicita tipoGiorniMese;
  final DateTime giornoDelMese, partendoDalGiorno, scadenza;

  const MovimentiTempo({
    required this.id,
    required this.nome,
    required this.tipo,
    required this.descrizione,
    required this.macroArea,
    required this.soldi,
    required this.numeroGiorni,
    required this.giornoDelMese,
    required this.tipoGiorniMese,
    required this.partendoDalGiorno,
    required this.scadenza,
  });
}
