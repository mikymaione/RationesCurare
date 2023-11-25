class Movimenti {
  final int id, idgiroconto, idmovimentitempo;
  final String nome, tipo, descrizione, macroarea;
  final DateTime data;
  final double soldi;

  const Movimenti({
    required this.id,
    required this.idgiroconto,
    required this.idmovimentitempo,
    required this.nome,
    required this.tipo,
    required this.descrizione,
    required this.macroarea,
    required this.data,
    required this.soldi,
  });
}
