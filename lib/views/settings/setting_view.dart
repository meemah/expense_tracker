import 'package:expense_tracker/custom_widgets/custom_spacing.dart';
import 'package:expense_tracker/utils/dark_theme/dark_theme_provider.dart';
import 'package:expense_tracker/utils/routes/route_names.dart';
import 'package:expense_tracker/utils/app_color.dart';
import 'package:expense_tracker/viewmodels/sign_in_viewmodel.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Consumer<ThemeProvider>(builder: (ctx, themeProvider, _) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Dark Theme",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 50,
                      height: 20,
                      child: Switch(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          activeTrackColor: AppColors.primaryColor,
                          value: themeProvider.darkTheme,
                          onChanged: (value) {
                            themeProvider.darkTheme = value;
                          }),
                    )
                  ],
                );
              }),
              const YMargin(20),
              Consumer<SignInViewmodel>(builder: (ctx, signInVm, _) {
                return GestureDetector(
                  onTap: () async {
                    signInVm.signOut();

                    Navigator.pushNamedAndRemoveUntil(
                        context, AppRoutes.signIn, (route) => false);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Sign Out",
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Icons.logout,
                        color: Colors.redAccent,
                      )
                    ],
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
