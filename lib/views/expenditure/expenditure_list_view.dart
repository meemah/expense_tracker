import 'dart:math';

import 'package:expense_tracker/custom_widgets/custom_spacing.dart';
import 'package:expense_tracker/custom_widgets/status_views/empty_view.dart';
import 'package:expense_tracker/custom_widgets/status_views/error_view.dart';
import 'package:expense_tracker/custom_widgets/status_views/loading_view.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/service/networking_service/network_status_check.dart';
import 'package:expense_tracker/utils/transaction_helper.dart';
import 'package:expense_tracker/viewmodels/expense_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:grouped_list/grouped_list.dart';
import 'package:provider/provider.dart';

import '../../custom_widgets/custom_icon.dart';

class ExpenditureListView extends StatelessWidget {
  const ExpenditureListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Consumer<ExpenditureViewmodel>(
              builder: (ctx, expenditureViewmodel, _) {
            return isApiResponseLoading(
                    expenditureViewmodel.allExpenditureResponse)
                ? const LoadingStatus()
                : isApiResponseError(
                        expenditureViewmodel.allExpenditureResponse)
                    ? ErrorStatus(
                        onRetry: () => expenditureViewmodel.getAllExpenses(),
                        message:
                            expenditureViewmodel.allExpenditureResponse.message)
                    : (expenditureViewmodel.allExpenditureResponse.data ?? [])
                            .isEmpty
                        ? const EmptyListStatus(type: "expenditure")
                        : Column(
                            children: [
                              const Text(
                                "Expenditure List sorted by category",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                child:
                                    GroupedListView<ExpenditureModel, String>(
                                  elements: expenditureViewmodel
                                          .allExpenditureResponse.data ??
                                      [],
                                  groupBy: (element) => element.category ?? "",
                                  groupSeparatorBuilder: (String groupByValue) {
                                    TransactionType transactionType =
                                        TransactionType
                                            .getExpenditureTransaction(
                                                type: groupByValue);
                                    return Column(
                                      children: [
                                        const YMargin(18),
                                        const Divider(),
                                        Row(
                                          children: [
                                            CustomColorIcon(
                                              color: transactionType
                                                  .transactionColor,
                                              icon: transactionType.icon,
                                            ),
                                            const XMargin(8),
                                            Text(
                                              groupByValue,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                        const Divider(),
                                      ],
                                    );
                                  },
                                  itemBuilder:
                                      (context, ExpenditureModel expenditure) {
                                    TransactionType transactionType =
                                        TransactionType
                                            .getExpenditureTransaction(
                                                type: expenditure.nameOfItem ??
                                                    "");
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 30.0, top: 10),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 15.h,
                                            width: 15.w,
                                            color: transactionType
                                                .transactionColor
                                                .withOpacity(
                                                    Random().nextDouble() *
                                                        1.0),
                                          ),
                                          const XMargin(5),
                                          Text(expenditure.nameOfItem ?? "-"),
                                          const Spacer(),
                                          Text(
                                              "N${expenditure.estimatedAmount ?? 0}")
                                        ],
                                      ),
                                    );
                                  },
                                  itemComparator: (item1, item2) =>
                                      (item1.category ?? "")
                                          .compareTo((item2.category ?? "")),
                                  order: GroupedListOrder.ASC,
                                ),
                              ),
                            ],
                          );
          }),
        ),
      ),
    );
  }
}
