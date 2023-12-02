/*
MIT License

Copyright (c) 2023 Michele Maione

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
import 'package:intl/intl.dart';

class Formatters {
  static const _sqliteDateFormat = 'yyyy-MM-dd HH:mm:ss';

  static String intToMoney(String languageCode, int i) => NumberFormat.simpleCurrency(locale: languageCode).format(i);

  static String doubleToMoney(String languageCode, double d) => NumberFormat.simpleCurrency(locale: languageCode).format(d);

  static DateTime sqliteToDateTime(String s) => DateFormat(_sqliteDateFormat).parse(s);

  static String dateTimeToSqlite(DateTime d) => DateFormat(_sqliteDateFormat).format(d);

  static String dateTimeToSqliteNow() => dateTimeToSqlite(DateTime.now());

  static String datetimeYMMMMDHm(String languageCode, DateTime d) => DateFormat.yMMMMd(languageCode).add_Hm().format(d);

  static String datetimeYMMMMDHms(String languageCode, DateTime d) => DateFormat.yMMMMd(languageCode).add_Hms().format(d);

  static String datetimeYMMMMD(String languageCode, DateTime d) => DateFormat.yMMMMd(languageCode).format(d);

  static String datetimeYMD(String languageCode, DateTime d) => DateFormat.yMd(languageCode).format(d);

  static String datetimeYMDHm(String languageCode, DateTime d) => DateFormat.yMd(languageCode).add_Hm().format(d);

  static String likeL(String s) => '%$s';

  static String likeR(String s) => '$s%';

  static String likeLR(String s) => likeL(likeR(s));
}
