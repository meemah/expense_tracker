import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class XMargin extends StatelessWidget {
  final double x;

  const XMargin(this.x, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: x.w);
  }
}

class YMargin extends StatelessWidget {
  final double y;

  const YMargin(this.y, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: y.h);
  }
}
