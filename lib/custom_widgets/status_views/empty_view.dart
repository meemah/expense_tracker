import 'package:expense_tracker/custom_widgets/custom_spacing.dart';
import 'package:expense_tracker/utils/app_color.dart';
import 'package:flutter/material.dart';

class EmptyListStatus extends StatelessWidget {
  final String type;
  const EmptyListStatus({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.list,
            size: 25,
            color: AppColors.primaryColor,
          ),
          Text(
            "No $type record yet",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const YMargin(8),
        ],
      ),
    );
  }
}
