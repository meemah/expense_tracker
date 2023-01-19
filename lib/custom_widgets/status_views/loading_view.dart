import 'package:expense_tracker/utils/app_color.dart';
import 'package:flutter/material.dart';

import 'package:loading_indicator/loading_indicator.dart';

class LoadingStatus extends StatelessWidget {
  const LoadingStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: SizedBox(
      height: 100,
      child: LoadingIndicator(
        indicatorType: Indicator.ballClipRotate,
        colors: [AppColors.primaryColor],
        strokeWidth: 4.0,
        pathBackgroundColor: Colors.black45,
      ),
    ));
  }
}
