import 'package:expense_tracker/custom_widgets/custom_button.dart';

import 'package:flutter/material.dart';

class ErrorStatus extends StatelessWidget {
  final Function()? onRetry;
  final String? message;
  const ErrorStatus({Key? key, this.onRetry, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.error_outlined,
          color: Colors.red,
          size: 25,
        ),
        const Text("Ooppss!"),
        Text(
          message ?? "Error occured",
        ),
        onRetry != null
            ? CustomButton(title: "Retry", onTap: onRetry!)
            : Container()
      ],
    );
  }
}
