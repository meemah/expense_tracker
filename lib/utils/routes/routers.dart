import 'package:expense_tracker/utils/routes/route_names.dart';
import 'package:expense_tracker/views/authentication/signin_view.dart';
import 'package:expense_tracker/views/authentication/signup_view.dart';
import 'package:expense_tracker/views/dashboard/add_expenditure_view.dart';
import 'package:expense_tracker/views/dashboard/add_income_view.dart';
import 'package:expense_tracker/views/dashboard/all_revenue_view.dart';
import 'package:expense_tracker/views/home_view.dart';
import 'package:flutter/material.dart';

class Routers {
  static Route<dynamic> generateRoute(
      RouteSettings settings, BuildContext context) {
    Widget routeWidget;
    final args = settings.arguments;
    switch (settings.name) {
      case AppRoutes.signIn:
        routeWidget = SignInView();
        break;
      case AppRoutes.signUp:
        routeWidget = SignUpView();
        break;
      case AppRoutes.home:
        routeWidget = const HomeView();
        break;
      case AppRoutes.addExpenditure:
        routeWidget = AddExpenditureView();
        break;
      case AppRoutes.allRevenue:
        routeWidget = const AllRevenueView();
        break;
      case AppRoutes.addIncome:
        routeWidget = AddIncomeView();
        break;
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
    return _createRoute(child: routeWidget);
  }

  static Route _createRoute({child = Widget, settings}) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
