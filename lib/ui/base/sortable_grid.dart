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

  RcDataCell({
    required this.value,
  });
}

class RcButtonCell extends RcCell {
  final Widget button;

  RcButtonCell({
    required this.button,
  });
}

class RcDataRow<idType> {
  final BuildContext context;

  final idType id;
  final bool? selected;
  final Void0ParamCallbackFuture? onClick;
  final ValueChanged<bool?>? onSelectChanged;
  final List<RcCell> cells;

  RcDataRow({
    required this.context,
    required this.id,
    required this.cells,
    this.onClick,
    this.selected,
    this.onSelectChanged,
  });

  late final colorOdd = Theme.of(context).colorScheme.primary.withOpacity(0.02);
  late final colorEven = Theme.of(context).colorScheme.primary.withOpacity(0.04);
  late final colorTotal = Theme.of(context).colorScheme.primary.withOpacity(0.10);

  late final colorOddM = _toMaterial(colorOdd);
  late final colorEvenM = _toMaterial(colorEven);
  late final colorTotalM = _toMaterial(colorTotal);

  MaterialStateProperty<Color?> _toMaterial(Color c) => MaterialStateProperty.resolveWith<Color?>((states) => c);

  DataRow toDataRow(int index) => DataRow(
        selected: selected ?? false,
        onSelectChanged: onSelectChanged,
        color: index.isEven ? colorEvenM : colorOddM,
        cells: [
          for (final e in cells) ...[
            if (e is RcIconCell) ...[
              DataCell(
                Icon(e.icon),
              ),
            ] else if (e is RcDataCell) ...[
              DataCell(
                Text(
                  e.value,
                ),
                onTap: onClick == null ? null : () async => await onClick!(),
              ),
            ] else if (e is RcButtonCell) ...[
              DataCell(
                e.button,
              ),
            ],
          ],
        ],
      );
}

class RcDataColumn {
  final String title;
  final bool? isNumeric;

  const RcDataColumn({
    required this.title,
    this.isNumeric,
  });
}

class AutoDataSource extends DataTableSource {
  final List<RcDataRow> rows;

  AutoDataSource(this.rows);

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => rows.length;

  @override
  int get selectedRowCount => 0;

  @override
  DataRow? getRow(int index) => rows[index].toDataRow(index);
}

class SortableGrid<X, idType> extends StatefulWidget {
  final int? initialSortColumnIndexIndicator;
  final bool? initialSortAscendingIndicator;

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
    this.onSort,
  });

  @override
  State<StatefulWidget> createState() => _SortableGridState<X, idType>();
}

class _SortableGridState<X, idType> extends State<SortableGrid<X, idType>> {
  late int? sortColumnIndex = widget.initialSortColumnIndexIndicator;
  late bool? sortAscending = widget.initialSortAscendingIndicator;

  @override
  Widget build(BuildContext context) {
    const dataRowHeight = 48.0;

    final height = MediaQuery.of(context).size.height - 180;
    final rowsPerPage = (height / dataRowHeight).floor();

    return PaginatedDataTable(
      sortColumnIndex: sortColumnIndex,
      sortAscending: sortAscending ?? true,
      source: AutoDataSource(widget.rows(widget.items)),
      dataRowMinHeight: dataRowHeight,
      dataRowMaxHeight: dataRowHeight,
      rowsPerPage: rowsPerPage,
      columnSpacing: 24,
      columns: [
        for (final c in widget.columns) ...[
          DataColumn(
            label: Text(
              c.title,
            ),
            numeric: c.isNumeric == true,
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
    );
  }
}
