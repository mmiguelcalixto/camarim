import 'package:flutter/material.dart';

class HorizontalList extends StatelessWidget {
  final List<Widget> children;
  final double spacing; 

  const HorizontalList({
    super.key,
    required this.children,
    this.spacing = 12,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.zero,
      child: Row(
        children: List.generate(children.length, (index) {
          return Padding(
            padding: EdgeInsets.only(
              right: index == children.length - 1 ? 0 : spacing,
            ),
            child: children[index],
          );
        }),
      ),
    );
  }
}
