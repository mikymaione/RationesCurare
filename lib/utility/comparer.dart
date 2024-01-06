/*
MIT License

Copyright (c) 2023 Michele Maione

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
import 'package:collection/collection.dart';
import 'package:rationes_curare/utility/callbacks.dart';

class Comparer {
  //
  static bool listAreUnorderedEquals<X>(List<X> a, List<X> b) => const DeepCollectionEquality.unordered().equals(a, b);

  static int boolCompare(bool? a, bool? b) => compare<bool>(
        a,
        b,
        (j, o) => switch ((j, o)) {
          (true, false) => -1,
          (false, true) => 1,
          _ => 0,
        },
      );

  static int compare<X>(X? a, X? b, Generic2ParamCallback<X, X, int> compareCallback) => switch ((a, b)) {
        (null, null) => 0,
        (null, _) => 1,
        (_, null) => -1,
        _ => compareCallback(a as X, b as X),
      };

  static Iterable<String> whereListContainsIgnoreCase(Iterable<String>? list, String string) => list == null || string.isEmpty
      ? const []
      : list.where(
          (a) => a.isNotEmpty && a.toLowerCase().contains(string.toLowerCase()),
        );
}
