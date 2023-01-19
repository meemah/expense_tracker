import 'package:expense_tracker/custom_widgets/custom_spacing.dart';
import 'package:expense_tracker/custom_widgets/indicator.dart';
import 'package:expense_tracker/service/networking_service/network_status_check.dart';
import 'package:expense_tracker/utils/app_color.dart';
import 'package:expense_tracker/utils/routes/route_names.dart';
import 'package:expense_tracker/viewmodels/expense_viewmodel.dart';
import 'package:expense_tracker/viewmodels/income_viewmodel.dart';

import 'package:expense_tracker/views/dashboard/revenue_history_view.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class DashBoardView extends StatefulWidget {
  const DashBoardView({super.key});

  @override
  State<DashBoardView> createState() => _DashBoardViewState();
}

class _DashBoardViewState extends State<DashBoardView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<IncomeViewmodel>(context, listen: false).getAllIncome();
      Provider.of<ExpenditureViewmodel>(context, listen: false)
          .getAllExpenses();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child: Consumer2<IncomeViewmodel, ExpenditureViewmodel>(
          builder: (ctx, incomeVM, expenditureVM, _) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Welcome,",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const YMargin(10),
              Card(
                elevation: 4,
                child: Container(
                  margin: const EdgeInsets.all(18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: 130.h,
                        width: 100.w,
                        child: PieChart(
                          PieChartData(
                            startDegreeOffset: 180,
                            sectionsSpace: 1,
                            centerSpaceRadius: 20,
                            sections: [
                              PieChartSectionData(
                                value: isApiResponseCompleted(
                                        incomeVM.getIncomeResponse)
                                    ? incomeVM.totalIncome.toDouble()
                                    : 1.0,
                                title: '',
                                radius: 50,
                                color: AppColors.primaryColor,
                                titlePositionPercentageOffset: 0.55,
                              ),
                              PieChartSectionData(
                                value: isApiResponseCompleted(
                                        expenditureVM.allExpenditureResponse)
                                    ? expenditureVM.totalExpenditure.toDouble()
                                    : 1.0,
                                title: '',
                                radius: 50,
                                color: AppColors.secondaryColor,
                                titlePositionPercentageOffset: 0.55,
                              )
                            ],
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Indicator(
                            color: AppColors.primaryColor,
                            text: 'Income: N${incomeVM.totalIncome}',
                          ),
                          Indicator(
                            color: AppColors.secondaryColor,
                            text:
                                'Expenditure: N${expenditureVM.totalExpenditure}',
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const YMargin(15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Revenue History",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.allRevenue);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text("See All"),
                          Icon(
                            Icons.chevron_right,
                            color: AppColors.primaryColor,
                          ),
                        ],
                      ))
                ],
              ),
              const YMargin(5),
              const Expanded(child: RevenueHistoryView(showAll: false))
            ],
          ),
        );
      }),
    ));
  }
}
