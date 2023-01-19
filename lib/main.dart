import 'package:expense_tracker/utils/dark_theme/app_theme.dart';
import 'package:expense_tracker/utils/dark_theme/dark_theme_pref.dart';
import 'package:expense_tracker/utils/dark_theme/dark_theme_provider.dart';
import 'package:expense_tracker/utils/locator.dart';
import 'package:expense_tracker/utils/routes/routers.dart';
import 'package:expense_tracker/viewmodels/expense_viewmodel.dart';
import 'package:expense_tracker/views/authentication/signin_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'viewmodels/income_viewmodel.dart';
import 'viewmodels/sign_in_viewmodel.dart';
import 'viewmodels/sign_up_viewmodel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  locatorSetUp();

  await serviceLocator<ThemePreference>().init();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(
      (MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => SignInViewmodel()),
          ChangeNotifierProvider(create: (_) => SignUpViewmodel()),
          ChangeNotifierProvider(create: (_) => ExpenditureViewmodel()),
          ChangeNotifierProvider(create: (_) => IncomeViewmodel()),
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ],
        child: const MyApp(),
      )),
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (_, __) =>
            Consumer<ThemeProvider>(builder: (ctx, themeProvider, _) {
              return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: "Expense App",
                  onGenerateRoute: (settings) =>
                      Routers.generateRoute(settings, context),
                  theme: (themeProvider.darkTheme ? darkTheme : lightTheme)
                      .copyWith(
                    appBarTheme: AppBarTheme(
                        centerTitle: true,
                        elevation: 0,
                        titleTextStyle: themeProvider.darkTheme
                            ? Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(color: Colors.white70)
                            : Theme.of(context).textTheme.headlineSmall!,
                        backgroundColor: Colors.transparent,
                        iconTheme: IconThemeData(
                            color: themeProvider.darkTheme
                                ? Colors.white70
                                : Colors.black)),
                  ),
                  locale: const Locale('en'),
                  home: SignInView());
            }));
  }
}
