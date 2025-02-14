import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:tasky/features/auth/presentation/cubits/signin_cubit/signin_cubit.dart';
import 'package:tasky/features/auth/presentation/views/signup_view.dart';
import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/app_text_style.dart';
import '../../../../../core/widget/custom_button.dart';
import '../../../../../core/widget/custom_text_form_field.dart';
import '../../../../../generated/assets.dart';

class SigninViewBody extends StatefulWidget {
  const SigninViewBody({super.key});

  @override
  State<SigninViewBody> createState() => _SigninViewBodyState();
}

class _SigninViewBodyState extends State<SigninViewBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late String phone, password;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            Assets.imagesPrimaryImage,
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height * 0.68,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              autovalidateMode: autovalidateMode,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Login",
                    style: TextStyles.bold24,
                  ),
                  24.verticalSpace,
                  IntlPhoneField(
                    onSaved: (value) {
                      phone = value!.number.toString();
                    },
                    decoration: InputDecoration(
                      labelText: '123 456-7890',
                      labelStyle: TextStyles.regular14,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide:
                            BorderSide(width: 1, color: Color(0xFFE6E9E9)),
                      ),
                    ),
                    initialCountryCode: 'EG',
                    disableLengthCheck: true,
                    dropdownIconPosition: IconPosition.trailing,
                  ),
                  20.verticalSpace,
                  CustomTextFormField(
                    onSaved: (value) {
                      password = value.toString();
                    },
                    hintText: "Password",
                    keyboardInputType: TextInputType.visiblePassword,
                  ),
                  24.verticalSpace,
                  CustomButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        context
                            .read<SigninCubit>()
                            .signIn(phone: phone, password: password);
                        log("$phone $password");
                      } else {
                        setState(() {
                          autovalidateMode = AutovalidateMode.always;
                        });
                      }
                    },
                    text: "Sign In",
                  ),
                  24.verticalSpace,
                  Center(
                    child: Text.rich(
                      TextSpan(
                        text: 'Don\'t have an account? ',
                        style: TextStyles.regular14,
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()..onTap = () {
                              Navigator.pushNamed(context, SignupView.routeName);
                            },
                            text: 'Sign Up',
                            style: TextStyles.regular14
                                .copyWith(color: AppColor.primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                  24.verticalSpace,
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
