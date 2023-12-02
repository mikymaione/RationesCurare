/*
MIT License

Copyright (c) 2023 Michele Maione

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
class Movimenti {
  final int id;
  final int? idGiroconto, idMovimentoTempo;
  final String nome, tipo, descrizione, macroArea;
  final DateTime data;
  final double soldi;

  const Movimenti({
    required this.id,
    required this.idGiroconto,
    required this.idMovimentoTempo,
    required this.nome,
    required this.tipo,
    required this.descrizione,
    required this.macroArea,
    required this.data,
    required this.soldi,
  });
}

class MovimentiSaldoPerCassa {
  final double tot;
  final String tipo;

  const MovimentiSaldoPerCassa({
    required this.tot,
    required this.tipo,
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
