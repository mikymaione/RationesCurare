/*
MIT License

Copyright (c) 2023 Michele Maione

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
import 'package:flutter/material.dart';
import 'package:rationes_curare/utility/callbacks.dart';

typedef DataColumnSortCallback<Z> = void Function(int columnIndex, int direction, List<Z> items);

abstract class RcCell {}

class RcIconCell extends RcCell {
  final IconData icon;

  RcIconCell({
    required this.icon,
  });
}

class RcDataCell extends RcCell {
  final String value;
  final WidgetSpan? leading;
  final Void0ParamCallbackFuture? onUrlClick;
  final double? width;
  final EdgeInsetsGeometry? padding;

  RcDataCell({
    required this.value,
    this.width,
    this.padding,
    this.leading,
    this.onUrlClick,
  });
}

class RcButtonCell extends RcCell {
  final Widget button;

  RcButtonCell({
    required this.button,
  });
}

class RcDataRow<idType> {
  final idType id;
  final bool selected;
  final Color? color;
  final ValueChanged<bool?>? onSelectChanged;
  final List<RcCell> cells;

  const RcDataRow({
    required this.id,
    required this.cells,
    required this.selected,
    this.color,
    this.onSelectChanged,
  });
}

class RcDataColumn {
  final String title;
  final bool? isNumeric;

  const RcDataColumn({
    required this.title,
    this.isNumeric,
  });
}

class SortableGrid<X, idType> extends StatefulWidget {
  final int initialSortColumnIndexIndicator;
  final bool initialSortAscendingIndicator;
  final List<RcDataColumn> columns;
  final Generic1ParamCallback<List<X>, List<RcDataRow<idType>>> rows;
  final DataColumnSortCallback<X>? onSort;
  final List<X> items;

  const SortableGrid({
    super.key,
    required this.initialSortColumnIndexIndicator,
    required this.initialSortAscendingIndicator,
    required this.columns,
    required this.rows,
    required this.items,
    this.onSort,
  });

  @override
  State<StatefulWidget> createState() => _SortableGridState<X, idType>();
}

class _SortableGridState<X, idType> extends State<SortableGrid<X, idType>> {
  late int sortColumnIndex = widget.initialSortColumnIndexIndicator;
  late bool sortAscending = widget.initialSortAscendingIndicator;

  static const gridCellStyle = TextStyle();

  static const gridCellLinkStyle = TextStyle(
    decoration: TextDecoration.underline,
  );

  @override
  Widget build(BuildContext context) {
    return DataTable(
      sortColumnIndex: sortColumnIndex,
      sortAscending: sortAscending,
      columns: [
        for (final c in widget.columns) ...[
          DataColumn(
            label: Text(
              c.title,
            ),
            numeric: true == c.isNumeric,
            onSort: widget.onSort == null
                ? null
                : (columnIndex, ascending) => setState(() {
                      sortColumnIndex = columnIndex;
                      sortAscending = ascending;
                      widget.onSort!(columnIndex, ascending ? 1 : -1, widget.items);
                    }),
          ),
        ],
      ],
      rows: [
        for (final r in widget.rows(widget.items)) ...[
          DataRow(
            selected: r.selected,
            onSelectChanged: r.onSelectChanged,
            color: MaterialStateProperty.resolveWith<Color?>((states) => r.color),
            cells: [
              for (final e in r.cells) ...[
                if (e is RcIconCell) ...[
                  DataCell(
                    Icon(e.icon),
                  ),
                ] else if (e is RcDataCell) ...[
                  DataCell(
                    Container(
                      margin: e.padding,
                      width: e.width,
                      child: Text.rich(
                        TextSpan(
                          children: [
                            if (e.leading != null) ...[
                              e.leading!,
                            ],
                            TextSpan(
                              text: e.value,
                            ),
                          ],
                        ),
                        textAlign: TextAlign.left,
                        style: e.onUrlClick == null ? gridCellStyle : gridCellLinkStyle,
                      ),
                    ),
                    onTap: e.onUrlClick == null ? null : () async => await e.onUrlClick!(),
                  ),
                ] else if (e is RcButtonCell) ...[
                  DataCell(
                    // TODO - MM: is container necessary?
                    Container(
                      child: e.button,
                    ),
                  ),
                ],
              ],
            ],
          ),
        ],
      ],
    );
  }
}
