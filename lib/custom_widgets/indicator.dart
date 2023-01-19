import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_spacing.dart';

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
  });
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 12.w,
          height: 12.h,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: color,
          ),
        ),
        const XMargin(4),
        Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Color(0xff505050),
          ),
        )
      ],
    );
  }
}
