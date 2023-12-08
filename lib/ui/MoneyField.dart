/*
MIT License

Copyright (c) 2023 Michele Maione

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:rationes_curare/utility/generic_controller.dart';
import 'package:intl/intl.dart';

class MoneyField extends StatefulWidget {
  final GenericController<double> controller;

  const MoneyField({
    super.key,
    required this.controller,
  });

  @override
  State<StatefulWidget> createState() => _MoneyFieldState();
}

class _MoneyFieldState extends State<MoneyField> {
  late final languageCode = Localizations.localeOf(context).languageCode;

  late final numberFormat = NumberFormat.simpleCurrency(locale: languageCode);

  late final formatter = CurrencyTextInputFormatter(
    locale: languageCode,
    symbol: numberFormat.currencySymbol,
    enableNegative: true,
    turnOffGrouping: false,
  );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.controller.value == null ? null : formatter.format(widget.controller.value!.toStringAsFixed(2)),
      onChanged: (s) => widget.controller.value = formatter.getUnformattedValue().toDouble(),
      keyboardType: TextInputType.number,
      inputFormatters: [
        formatter,
      ],
    );
  }
}
