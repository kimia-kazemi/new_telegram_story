import 'package:flutter/material.dart';

class StackedWidgets extends StatelessWidget {
  final List<Widget> items;
  final double size;
  final double xShift;

  const StackedWidgets({
    super.key,
    required this.items,
    this.size = 100,
    //make each image move to right
    this.xShift = 50,
  });

  @override
  Widget build(BuildContext context) {
    final allItems = items
        .asMap()
        .map((index, item) {
          final left = xShift * index;
          final value = Container(
            width: size,
            height: size,
            margin: EdgeInsets.only(left: left),
            child: item,
          );
          return MapEntry(index, value);
        })
        .values
        .toList();

    return Stack(
      children: allItems,
    );
  }
}
