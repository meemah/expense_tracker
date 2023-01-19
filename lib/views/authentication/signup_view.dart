// ignore_for_file: use_build_context_synchronously

import 'package:expense_tracker/custom_widgets/custom_button.dart';
import 'package:expense_tracker/custom_widgets/custom_spacing.dart';
import 'package:expense_tracker/custom_widgets/custom_textfield.dart';
import 'package:expense_tracker/custom_widgets/custom_toast.dart';
import 'package:expense_tracker/service/networking_service/network_status_check.dart';
import 'package:expense_tracker/utils/form_validators.dart';
import 'package:expense_tracker/utils/routes/route_names.dart';
import 'package:expense_tracker/viewmodels/sign_up_viewmodel.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';

import 'components/auth_rich_text.dart';

class SignUpView extends StatelessWidget with Validators {
  SignUpView({super.key});
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
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
                    "Sign Up.",
                    style:
                        TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
                  ),
                  const YMargin(30),
                  CustomTextField(
                      controller: nameController,
                      textfieldLabel: "Name",
                      validator: Validators.validateUserName),
                  CustomTextField(
                      controller: emailController,
                      textfieldLabel: "Email",
                      validator: Validators.isEmail),
                  CustomTextField(
                      controller: passwordController,
                      textfieldLabel: "Password",
                      obscureText: true,
                      validator: Validators.validatePassword),
                  CustomTextField(
                      controller: confirmPasswordController,
                      textfieldLabel: "Confirm Password",
                      obscureText: true,
                      validator: (value) {
                        if (value != passwordController.text) {
                          return "Passwords do not match";
                        }
                        return null;
                      }),
                  const AuthRichText(isSignUp: true),
                  const YMargin(40),
                  Consumer<SignUpViewmodel>(
                      builder: ((context, signUpViewmodel, child) {
                    return CustomButton(
                        isLoading: isApiResponseLoading(
                            signUpViewmodel.signUpResponse),
                        title: "Sign Up",
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            await signUpViewmodel.signUp(
                                name: nameController.text.trim(),
                                email: emailController.text.trim(),
                                password:
                                    confirmPasswordController.text.trim());
                            if (isApiResponseCompleted(
                                signUpViewmodel.signUpResponse)) {
                              Navigator.popAndPushNamed(
                                  context, AppRoutes.signIn);
                            } else if (isApiResponseError(
                                signUpViewmodel.signUpResponse)) {
                              showToast(signUpViewmodel.signUpResponse.message,
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
