import 'package:expense_tracker/custom_widgets/custom_button.dart';
import 'package:expense_tracker/custom_widgets/custom_dropfield.dart';
import 'package:expense_tracker/custom_widgets/custom_spacing.dart';
import 'package:expense_tracker/custom_widgets/custom_textfield.dart';
import 'package:expense_tracker/custom_widgets/custom_toast.dart';
import 'package:expense_tracker/service/networking_service/network_status_check.dart';
import 'package:expense_tracker/utils/form_validators.dart';
import 'package:expense_tracker/utils/transaction_helper.dart';
import 'package:expense_tracker/viewmodels/income_viewmodel.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class AddIncomeView extends StatelessWidget with Validators {
  AddIncomeView({super.key});

  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Add Income",
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
                  CustomDropField(
                    controller: nameController,
                    title: "Name of Revenue",
                    onValidate: Validators.validateFieldEmpty,
                    selectedItem: (selectedItem) {},
                    options: TransactionType.incomeTransactions,
                  ),
                  CustomTextField(
                      controller: amountController,
                      textInputType: TextInputType.number,
                      textfieldLabel: "Amount",
                      validator: Validators.validateFieldEmpty),
                  const YMargin(40),
                  Consumer<IncomeViewmodel>(
                      builder: ((context, incomeViewmodel, child) {
                    return CustomButton(
                        isLoading: isApiResponseLoading(
                            incomeViewmodel.saveIncomeResponse),
                        title: "Save Income",
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            await incomeViewmodel.saveIncome(
                                nameOfRevenue: nameController.text.trim(),
                                amount: double.tryParse(
                                        amountController.text.trim()) ??
                                    0);

                            if (isApiResponseCompleted(
                                incomeViewmodel.saveIncomeResponse)) {
                              showToast(
                                incomeViewmodel.saveIncomeResponse.data!,
                              );
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                            } else if (isApiResponseError(
                                incomeViewmodel.saveIncomeResponse)) {
                              showToast(
                                  incomeViewmodel.saveIncomeResponse.message,
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
