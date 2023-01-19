// ignore_for_file: use_build_context_synchronously

import 'package:expense_tracker/custom_widgets/custom_spacing.dart';
import 'package:expense_tracker/custom_widgets/custom_textfield.dart';
import 'package:expense_tracker/custom_widgets/custom_toast.dart';
import 'package:expense_tracker/service/networking_service/network_status_check.dart';
import 'package:expense_tracker/utils/form_validators.dart';
import 'package:expense_tracker/utils/routes/route_names.dart';
import 'package:expense_tracker/viewmodels/sign_in_viewmodel.dart';
import 'package:expense_tracker/views/authentication/components/auth_rich_text.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';

import '../../custom_widgets/custom_button.dart';

class SignInView extends StatelessWidget with Validators {
  SignInView({super.key});
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Text(
                    "Sign In.",
                    style:
                        TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
                  ),
                  const YMargin(30),
                  CustomTextField(
                      controller: emailController,
                      textfieldLabel: "Email",
                      validator: Validators.isEmail),
                  CustomTextField(
                      controller: passwordController,
                      textfieldLabel: "Password",
                      obscureText: true,
                      validator: Validators.validatePassword),
                  const AuthRichText(isSignUp: false),
                  const YMargin(40),
                  Consumer<SignInViewmodel>(
                      builder: ((context, signInViewmodel, child) {
                    return CustomButton(
                        isLoading: isApiResponseLoading(
                            signInViewmodel.signInResponse),
                        title: "Sign In",
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            await signInViewmodel.signIn(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim());
                            if (isApiResponseCompleted(
                                signInViewmodel.signInResponse)) {
                              Navigator.popAndPushNamed(
                                  context, AppRoutes.home);
                            } else if (isApiResponseError(
                                signInViewmodel.signInResponse)) {
                              showToast(signInViewmodel.signInResponse.message,
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
