class DbInfo {
  final String email, nome, psw, sincronizzaDB, valuta;
  final DateTime ultimaModifica, ultimoAggiornamentoDB;

  const DbInfo({
    required this.email,
    required this.nome,
    required this.psw,
    required this.sincronizzaDB,
    required this.valuta,
    required this.ultimaModifica,
    required this.ultimoAggiornamentoDB,
  });
}
