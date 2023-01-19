import 'package:expense_tracker/custom_widgets/custom_icon.dart';
import 'package:expense_tracker/custom_widgets/custom_spacing.dart';
import 'package:expense_tracker/custom_widgets/status_views/empty_view.dart';
import 'package:expense_tracker/custom_widgets/status_views/error_view.dart';
import 'package:expense_tracker/custom_widgets/status_views/loading_view.dart';
import 'package:expense_tracker/models/income_model.dart';

import 'package:expense_tracker/service/networking_service/network_status_check.dart';
import 'package:expense_tracker/utils/transaction_helper.dart';
import 'package:expense_tracker/viewmodels/income_viewmodel.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class RevenueHistoryView extends StatelessWidget {
  final bool showAll;
  const RevenueHistoryView({super.key, required this.showAll});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<IncomeViewmodel>(builder: (ctx, incomeViewmodel, _) {
        return isApiResponseLoading(incomeViewmodel.getIncomeResponse)
            ? const LoadingStatus()
            : isApiResponseError(incomeViewmodel.getIncomeResponse)
                ? ErrorStatus(
                    onRetry: () => incomeViewmodel.getAllIncome(),
                    message: incomeViewmodel.getIncomeResponse.message)
                : (incomeViewmodel.getIncomeResponse.data ?? []).isEmpty
                    ? const EmptyListStatus(type: "income")
                    : ListView.separated(
                        itemCount: showAll
                            ? (incomeViewmodel.getIncomeResponse.data ?? [])
                                .length
                            : (incomeViewmodel.getIncomeResponse.data ?? [])
                                .take(5)
                                .length,
                        itemBuilder: (ctx, index) {
                          IncomeModel incomeModel =
                              incomeViewmodel.getIncomeResponse.data![index];
                          TransactionType transactionType =
                              TransactionType.getIncomeTransaction(
                                  type: incomeModel.nameOfRevenue ?? "");
                          return Row(
                            children: [
                              CustomColorIcon(
                                color: transactionType.transactionColor,
                                icon: transactionType.icon,
                              ),
                              const XMargin(10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    transactionType.type,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                      "N${(incomeModel.amount ?? 0).toDouble()}")
                                ],
                              )
                            ],
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const YMargin(15);
                        },
                      );
      }),
    );
  }
}
