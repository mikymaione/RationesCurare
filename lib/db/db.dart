/*
MIT License

Copyright (c) 2023 Michele Maione

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rationes_curare/utility/commons.dart';
import 'package:sqlite3/common.dart';
import 'package:sqlite3/sqlite3.dart';

Future<CommonDatabase> openDb(String name) async {
  final docsDir = await getDownloadsDirectory();
  final rcDir = join(docsDir!.path, 'RationesCurare');

  Commons.printIfInDebug('RationesCurare directory: $rcDir');

  final filename = join(rcDir, '$name.rqd8');

  Commons.printIfInDebug('Opening DB: $filename');

  try {
    final db = sqlite3.open(filename);
    Commons.printIfInDebug('Connection successfully to DB: $filename');

    return db;
  } catch (e) {
    Commons.printIfInDebug('Can not open DB: $e');
    rethrow;
  }
}
