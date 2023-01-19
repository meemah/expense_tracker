import 'package:expense_tracker/utils/app_color.dart';
import 'package:expense_tracker/utils/routes/route_names.dart';
import 'package:expense_tracker/views/dashboard/dashboard_view.dart';
import 'package:expense_tracker/views/expenditure/expenditure_list_view.dart';
import 'package:expense_tracker/views/settings/setting_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

List<Widget> pageList = [
  const DashBoardView(),
  const ExpenditureListView(),
  const SettingView()
];

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedPage = ValueNotifier(0);
    return ValueListenableBuilder(
        valueListenable: selectedPage,
        builder: (ctx, selectedIndex, _) {
          return Scaffold(
            floatingActionButton: SpeedDial(
              activeBackgroundColor: AppColors.primaryColor,
              mini: true,
              buttonSize: Size(160.w, 70.h),
              childrenButtonSize: Size(160.w, 56.h),
              children: [
                getCustomSpeedBtn(
                  title: "New Income",
                  route: AppRoutes.addIncome,
                  context: context,
                ),
                getCustomSpeedBtn(
                  title: "New Expenditure",
                  route: AppRoutes.addExpenditure,
                  context: context,
                ),
              ],
              child: const FloatingActionButton(
                  backgroundColor: AppColors.primaryColor,
                  onPressed: null,
                  child: Icon(Icons.add)),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniEndFloat,
            bottomNavigationBar: BottomNavigationBar(
              elevation: 4.0,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              type: BottomNavigationBarType.fixed,
              currentIndex: selectedPage.value,
              onTap: (value) => selectedPage.value = value,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.home),
                  label: "Dashboard",
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.money_dollar),
                  label: "Expenditure",
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.settings),
                  label: "Settings",
                ),
              ],
            ),
            body: pageList.elementAt(selectedPage.value),
          );
        });
  }

  getCustomSpeedBtn(
      {required String title,
      required String route,
      required BuildContext context}) {
    return SpeedDialChild(
      elevation: 1,
      onTap: () => Navigator.pushNamed(context, route),
      backgroundColor: AppColors.primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      labelStyle: const TextStyle(color: Colors.white),
      label: title,
      labelBackgroundColor: AppColors.primaryColor,
    );
  }
}
