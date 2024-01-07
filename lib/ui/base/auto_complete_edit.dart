/*
MIT License

Copyright (c) 2023 Michele Maione

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
import 'package:dart_casing/dart_casing.dart';
import 'package:flutter/material.dart';
import 'package:rationes_curare/utility/callbacks.dart';
import 'package:rationes_curare/utility/comparer.dart';

class AutoCompleteEdit extends StatelessWidget {
  final TextEditingController controller;
  final Iterable<String>? items;
  final Void1ParamCallback<String>? onSelected;
  final FormFieldValidator<String>? validator;
  final bool autofocus, titleCase;

  const AutoCompleteEdit({
    super.key,
    required this.controller,
    required this.items,
    required this.titleCase,
    this.onSelected,
    this.validator,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      onSelected: (v) {
        controller.text = titleCase ? Casing.titleCase(v) : v;
        onSelected?.call(v);
      },
      optionsBuilder: (textEditingValue) => Comparer.whereListContainsIgnoreCase(
        items,
        textEditingValue.text,
      ),
      fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
        textEditingController.text = controller.text;

        return TextFormField(
          autofocus: autofocus,
          validator: validator,
          controller: textEditingController,
          focusNode: focusNode,
          onFieldSubmitted: (v) => onFieldSubmitted(),
          onChanged: (v) => controller.text = titleCase ? Casing.titleCase(v) : v,
        );
      },
    );
  }
}
