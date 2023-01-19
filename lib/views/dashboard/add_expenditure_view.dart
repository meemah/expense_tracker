// ignore_for_file: use_build_context_synchronously

import 'package:expense_tracker/custom_widgets/custom_dropfield.dart';
import 'package:expense_tracker/custom_widgets/custom_spacing.dart';
import 'package:expense_tracker/custom_widgets/custom_textfield.dart';
import 'package:expense_tracker/custom_widgets/custom_toast.dart';
import 'package:expense_tracker/service/networking_service/network_status_check.dart';
import 'package:expense_tracker/utils/form_validators.dart';

import 'package:expense_tracker/utils/transaction_helper.dart';
import 'package:expense_tracker/viewmodels/expense_viewmodel.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../custom_widgets/custom_button.dart';

class AddExpenditureView extends StatelessWidget with Validators {
  AddExpenditureView({super.key});

  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController amountController = TextEditingController();

  final TextEditingController categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Add Expense",
      )),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                      controller: nameController,
                      textfieldLabel: "Name of item",
                      validator: Validators.validateFieldEmpty),
                  CustomDropField(
                      controller: categoryController,
                      title: "Category",
                      onValidate: Validators.validateFieldEmpty,
                      selectedItem: (selectedItem) {},
                      options: TransactionType.expenditureTransactions),
                  CustomTextField(
                      controller: amountController,
                      textInputType: TextInputType.number,
                      textfieldLabel: "Estimated amount",
                      validator: Validators.validateFieldEmpty),
                  const YMargin(40),
                  Consumer<ExpenditureViewmodel>(
                      builder: ((context, expenditureViewmodel, child) {
                    return CustomButton(
                        isLoading: isApiResponseLoading(
                            expenditureViewmodel.saveExpenditureResponse),
                        title: "Save expenditure",
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            await expenditureViewmodel.saveExpenditure(
                                category: categoryController.text.trim(),
                                itemName: nameController.text.trim(),
                                amount: double.tryParse(
                                        amountController.text.trim()) ??
                                    0);
                            if (isApiResponseCompleted(
                                expenditureViewmodel.saveExpenditureResponse)) {
                              showToast(
                                expenditureViewmodel
                                    .saveExpenditureResponse.data!,
                              );
                              Navigator.pop(context);
                            } else if (isApiResponseError(
                                expenditureViewmodel.saveExpenditureResponse)) {
                              showToast(
                                  expenditureViewmodel
                                      .saveExpenditureResponse.message,
                                  isError: true);
                            }
                          }
                        });
                  }))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
