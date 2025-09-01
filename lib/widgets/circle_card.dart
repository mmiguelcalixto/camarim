import 'package:flutter/material.dart';

class CircleCard extends StatelessWidget {
  final String label;

  const CircleCard(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 6),
        Text(label, overflow: TextOverflow.ellipsis),
      ],
    );
  }
}
