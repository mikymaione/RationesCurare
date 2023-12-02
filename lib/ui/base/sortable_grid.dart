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
  final double? minWidth;

  RcDataCell({
    required this.value,
    this.minWidth,
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
  final bool? selected;
  final Void0ParamCallbackFuture? onClick;
  final ValueChanged<bool?>? onSelectChanged;
  final List<RcCell> cells;

  const RcDataRow({
    required this.id,
    required this.cells,
    this.onClick,
    this.selected,
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
  final int? initialSortColumnIndexIndicator;
  final bool? initialSortAscendingIndicator, lastRowIsTotal;

  final List<RcDataColumn> columns;
  final Generic1ParamCallback<List<X>, List<RcDataRow<idType>>> rows;

  final DataColumnSortCallback<X>? onSort;
  final List<X> items;

  const SortableGrid({
    super.key,
    required this.columns,
    required this.rows,
    required this.items,
    this.initialSortColumnIndexIndicator,
    this.initialSortAscendingIndicator,
    this.lastRowIsTotal,
    this.onSort,
  });

  @override
  State<StatefulWidget> createState() => _SortableGridState<X, idType>();
}

class _SortableGridState<X, idType> extends State<SortableGrid<X, idType>> {
  late int? sortColumnIndex = widget.initialSortColumnIndexIndicator;
  late bool? sortAscending = widget.initialSortAscendingIndicator;

  MaterialStateProperty<Color?> _toMaterial(Color c) => MaterialStateProperty.resolveWith<Color?>((states) => c);

  bool isTotalRow(int index, int length) => widget.lastRowIsTotal == true && index == length - 1;

  @override
  Widget build(BuildContext context) {
    final rows = widget.rows(widget.items);

    final colorOdd = Theme.of(context).colorScheme.primary.withOpacity(0.02);
    final colorEven = Theme.of(context).colorScheme.primary.withOpacity(0.04);
    final colorTotal = Theme.of(context).colorScheme.primary.withOpacity(0.10);

    final colorOddM = _toMaterial(colorOdd);
    final colorEvenM = _toMaterial(colorEven);
    final colorTotalM = _toMaterial(colorTotal);

    return DataTable(
      sortColumnIndex: sortColumnIndex,
      sortAscending: sortAscending ?? true,
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
        for (var i = 0; i < rows.length; i++) ...[
          DataRow(
            selected: rows[i].selected ?? false,
            onSelectChanged: rows[i].onSelectChanged,
            color: isTotalRow(i, rows.length)
                ? colorTotalM
                : i.isEven
                    ? colorEvenM
                    : colorOddM,
            cells: [
              for (final e in rows[i].cells) ...[
                if (e is RcIconCell) ...[
                  DataCell(
                    Icon(e.icon),
                  ),
                ] else if (e is RcDataCell) ...[
                  DataCell(
                    Container(
                      constraints: e.minWidth == null ? null : BoxConstraints(minWidth: e.minWidth!),
                      child: Text(
                        e.value,
                        style: isTotalRow(i, rows.length)
                            ? const TextStyle(
                                fontWeight: FontWeight.bold,
                              )
                            : null,
                      ),
                    ),
                    onTap: isTotalRow(i, rows.length)
                        ? null
                        : rows[i].onClick == null
                            ? null
                            : () async => await rows[i].onClick!(),
                  ),
                ] else if (e is RcButtonCell) ...[
                  DataCell(
                    e.button,
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
