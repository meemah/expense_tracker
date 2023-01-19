import 'package:expense_tracker/custom_widgets/custom_textfield.dart';
import 'package:expense_tracker/custom_widgets/custom_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDropField extends StatelessWidget {
  final List options;
  final String? Function(String?)? onValidate;
  final Function(dynamic selectedItem) selectedItem;
  final TextEditingController controller;

  final Function? onTapFunction;
  final String title;

  const CustomDropField(
      {Key? key,
      required this.controller,
      required this.options,
      required this.title,
      required this.selectedItem,
      this.onTapFunction,
      this.onValidate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      readOnly: true,
      suffixIcon: const Icon(
        CupertinoIcons.right_chevron,
        size: 16,
      ),
      controller: controller,
      onTap: () {
        if (options.isNotEmpty) {
          showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15)),
              ),
              context: context,
              builder: (ctx) {
                return Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: ListView.builder(
                      itemCount: options.length,
                      itemBuilder: (ctx, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                              onTap: () {
                                (selectedItem(options[index]));
                                controller.value = TextEditingValue(
                                    text: options[index] == null
                                        ? options[index].toString()
                                        : options[index].toString());
                                Navigator.pop(context);
                              },
                              child: Text(options[index].toString())),
                        );
                      }),
                );
              });
        } else {
          showToast(
              "You have no items for this field, You have to add a ${title.toLowerCase()}.",
              isError: true);
        }
      },
      textfieldLabel: title,
      validator: onValidate!,
    );
  }
}
