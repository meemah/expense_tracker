import 'package:expense_tracker/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String textfieldLabel;
  final String? Function(String?) validator;
  final bool obscureText;
  final Function()? onTap;
  final bool readOnly;
  final Widget? suffixIcon;
  final TextInputType? textInputType;
  const CustomTextField(
      {Key? key,
      required this.controller,
      this.onTap,
      this.readOnly = false,
      this.suffixIcon,
      required this.textfieldLabel,
      required this.validator,
      this.obscureText = false,
      this.textInputType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
          validator: validator,
          controller: controller,
          keyboardType: textInputType,
          obscureText: obscureText,
          onTap: onTap,
          readOnly: readOnly,
          decoration: InputDecoration(
              suffixIconConstraints: BoxConstraints(
                maxHeight: 25.h,
                minHeight: 25.h,
                minWidth: 25.w,
              ),
              suffixIcon: suffixIcon,
              hintText: textfieldLabel,
              isDense: true,
              border: kTextFormBorder,
              focusedBorder: kTextFormBorder,
              enabledBorder: kTextFormBorder)),
    );
  }
}

final kTextFormBorder = OutlineInputBorder(
  borderSide: const BorderSide(color: AppColors.primaryColor),
  borderRadius: BorderRadius.circular(8.0),
);
