/*
MIT License

Copyright (c) 2023 Michele Maione

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
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

  factory Periodicita.fromCode(String code) => Periodicita.values
      .where(
        (e) => e.code == code,
      )
      .single;
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
