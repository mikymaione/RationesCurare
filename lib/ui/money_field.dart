/*
MIT License

Copyright (c) 2023 Michele Maione

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_calculator/flutter_simple_calculator.dart';
import 'package:rationes_curare/utility/generic_controller.dart';
import 'package:intl/intl.dart';

class MoneyField extends StatefulWidget {
  final GenericController<double> controller;
  final FormFieldValidator<String>? validator;

  const MoneyField({
    super.key,
    required this.controller,
    this.validator,
  });

  @override
  State<StatefulWidget> createState() => _MoneyFieldState();
}

class _MoneyFieldState extends State<MoneyField> {
  final textEditingController = TextEditingController();

  late final languageCode = Localizations.localeOf(context).languageCode;

  late final numberFormat = NumberFormat.simpleCurrency(locale: languageCode);

  late final formatter = CurrencyTextInputFormatter(
    locale: languageCode,
    symbol: numberFormat.currencySymbol,
    enableNegative: true,
    turnOffGrouping: false,
  );

  void setValue() {
    if (widget.controller.value != null) {
      textEditingController.text = formatter.format(widget.controller.value!.toStringAsFixed(2));
    }
  }

  Future<void> showCalc() async {
    final c = CalcController();

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.75,
        child: SimpleCalculator(
          autofocus: true,
          value: widget.controller.value ?? 0,
          controller: c,
          numberFormat: numberFormat,
        ),
      ),
    );

    final d = c.value;
    c.dispose();

    if (d != null) {
      widget.controller.value = d;
      setValue();
    }
  }

  @override
  Widget build(BuildContext context) {
    setValue();

    return TextFormField(
      validator: widget.validator,
      controller: textEditingController,
      onChanged: (s) => widget.controller.value = formatter.getUnformattedValue().toDouble(),
      keyboardType: TextInputType.number,
      inputFormatters: [
        formatter,
      ],
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: const Icon(Icons.calculate),
          onPressed: () => showCalc(),
        ),
      ),
    );
  }
}
