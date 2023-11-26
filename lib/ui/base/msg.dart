/*
MIT License

Copyright (c) 2023 Michele Maione

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
import 'package:flutter/material.dart';

enum TypeOfMsg { ok, info, error }

class Msg {
  //
  static Future<void> say({
    required BuildContext context,
    required String title,
    required String text,
  }) =>
      _dialog(
        context: context,
        title: title,
        text: text,
        showCancel: false,
      );

  static Future<bool> ask({
    required BuildContext context,
    required String title,
    required String text,
  }) =>
      _dialog(
        context: context,
        title: title,
        text: text,
        showCancel: true,
      );

  static Future<bool> _dialog({
    required BuildContext context,
    required String title,
    required String text,
    required bool showCancel,
  }) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(text),
        actions: [
          if (showCancel) ...[
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Annulla'),
            ),
          ],
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Ok'),
          ),
        ],
      ),
    );

    return true == ok;
  }

  static void showOk(BuildContext context, String text, {Duration? duration}) {
    show(context, text, TypeOfMsg.ok, duration: duration);
  }

  static void showInfo(BuildContext context, String text, {Duration? duration}) {
    show(context, text, TypeOfMsg.info, duration: duration);
  }

  static void showErrorMsg(BuildContext context, String text, {Duration? duration}) {
    show(context, text, TypeOfMsg.error, duration: duration);
  }

  static void showError(BuildContext context, Object e, {Duration? duration}) {
    showErrorMsg(context, 'Error: $e', duration: duration);
  }

  static Color _colorByTypeOfMsg(TypeOfMsg typeOfMsg) {
    switch (typeOfMsg) {
      case TypeOfMsg.ok:
        return Colors.green;
      case TypeOfMsg.info:
        return Colors.blue;
      case TypeOfMsg.error:
        return Colors.red;
    }
  }

  static void show(BuildContext context, String text, TypeOfMsg typeOfMsg, {Duration? duration}) => _show(
        context,
        text,
        typeOfMsg,
        duration: duration,
      );

  static void showFixed(BuildContext context, String text, TypeOfMsg typeOfMsg) => _show(
        context,
        text,
        typeOfMsg,
        duration: const Duration(days: 1),
        behavior: SnackBarBehavior.fixed,
      );

  static void _show(BuildContext context, String text, TypeOfMsg typeOfMsg, {Duration? duration, SnackBarBehavior behavior = SnackBarBehavior.floating}) {
    hide(context);

    final snackBar = SnackBar(
      behavior: behavior,
      duration: duration ?? const Duration(minutes: 1),
      backgroundColor: _colorByTypeOfMsg(typeOfMsg),
      content: Row(
        children: [
          if (typeOfMsg == TypeOfMsg.ok) ...[
            const Icon(Icons.done, color: Colors.black),
          ] else if (typeOfMsg == TypeOfMsg.info) ...[
            const Icon(Icons.info_outline, color: Colors.black),
          ] else if (typeOfMsg == TypeOfMsg.error) ...[
            const Icon(Icons.dangerous, color: Colors.black),
          ],
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      action: SnackBarAction(
        label: 'OK',
        textColor: Colors.black,
        onPressed: () => {},
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void hide(BuildContext context) => ScaffoldMessenger.of(context).clearSnackBars();
}
