/*
 *  Copyright (C), 2015-2021
 *  FileName: table_row_margin
 *  Author: Tonight丶相拥
 *  Date: 2021/7/15
 *  Description: 
 **/

part of appcommon;

class TableRowMargin extends TableRow {
  TableRowMargin(this.crossCount, this.rowMargin);
  final int crossCount;
  final double rowMargin;

  @override
  // TODO: implement children
  List<Widget>? get children => [SizedBox(height: this.rowMargin)]
      + List.generate(crossCount - 1, (index) => SizedBox());
}

class TableHeightRow extends TableRow {
  TableHeightRow({
    LocalKey? key,
    List<Widget> children: const [],
    Decoration? decoration,
    this.rowHeight: 50,
    this.alignment
  }): super(key: key, children: children, decoration: decoration);
  /// 行高
  final double rowHeight;
  /// 对齐方式
  final AlignmentGeometry? alignment;
  // final double height;
  @override
  // TODO: implement children
  List<Widget>? get children => (super.children ?? [])
    .map((e) => e.container(
    height: rowHeight,
    alignment: alignment
  )).toList();
}