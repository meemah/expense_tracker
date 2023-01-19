import 'package:expense_tracker/utils/app_color.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../utils/routes/route_names.dart';

class AuthRichText extends StatelessWidget {
  final bool isSignUp;

  const AuthRichText({super.key, required this.isSignUp});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: RichText(
          textAlign: TextAlign.right,
          text: TextSpan(
              style: Theme.of(context).textTheme.bodyText1,
              text: isSignUp
                  ? 'You already have an account?'
                  : 'Don\'t have an account?',
              children: <TextSpan>[
                TextSpan(
                    text: isSignUp ? ' Log In' : ' Sign up',
                    style: const TextStyle(
                      color: AppColors.primaryColor,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.popAndPushNamed(context,
                            isSignUp ? AppRoutes.signIn : AppRoutes.signUp);
                      })
              ])),
    );
  }
}
