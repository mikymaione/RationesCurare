class MovimentiTempo {
  final int id;
  final String nome, tipo, descrizione, macroArea;
  final double soldi;

  final int numeroGiorni;
  final String giornoDelMese, tipoGiorniMese;

  final DateTime partendoDalGiorno, scadenza;

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
