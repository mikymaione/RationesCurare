/*
MIT License

Copyright (c) 2023 Michele Maione

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
import 'package:flutter/material.dart';
import 'package:rationes_curare/utility/formatters.dart';
import 'package:rationes_curare/utility/generic_controller.dart';

class DateTimeField extends StatefulWidget {
  final GenericController<DateTime> controller;
  final FormFieldValidator<String>? validator;

  const DateTimeField({
    super.key,
    required this.controller,
    this.validator,
  });

  @override
  State<StatefulWidget> createState() => _DateTimeField();
}

class _DateTimeField extends State<DateTimeField> {
  final textEditingController = TextEditingController();

  late final languageCode = Localizations.localeOf(context).languageCode;

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  Future<void> showDateTimePicker() async {
    if (context.mounted) {
      final d = await showDatePicker(
        context: context,
        initialDate: widget.controller.value,
        firstDate: DateTime(1500, 1, 1),
        lastDate: DateTime.now().add(const Duration(days: 365 * 200)),
      );

      if (d != null) {
        if (context.mounted) {
          final t = await showTimePicker(
            context: context,
            initialTime: Formatters.timeOfDayFromDateTime(widget.controller.value) ?? const TimeOfDay(hour: 0, minute: 0),
          );

          if (t != null) {
            if (context.mounted) {
              final dt = d.add(Duration(hours: t.hour, minutes: t.minute));

              textEditingController.text = Formatters.datetimeYMDHHmm(languageCode, dt);
              widget.controller.value = dt;
            }
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.controller.value != null) {
      textEditingController.text = Formatters.datetimeYMDHHmm(languageCode, widget.controller.value!);
    }

    return TextFormField(
      readOnly: true,
      validator: widget.validator,
      controller: textEditingController,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: const Icon(Icons.calendar_month),
          onPressed: () => showDateTimePicker(),
        ),
      ),
    );
  }
}
