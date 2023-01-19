import 'package:flutter/material.dart';

class CustomColorIcon extends StatelessWidget {
  final Color color;
  final IconData icon;
  const CustomColorIcon({super.key, required this.color, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}
