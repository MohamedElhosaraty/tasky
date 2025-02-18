import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:tasky/core/widget/custom_drop_down_widget.dart';

import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/app_text_style.dart';
import '../../../../../core/widget/custom_button.dart';
import '../../../../../core/widget/custom_text_form_field.dart';
import '../../../../../generated/assets.dart';
import '../../cubits/signup_cubit/signup_cubit.dart';
import '../signin_view.dart';

class SignupViewBody extends StatefulWidget {
  const SignupViewBody({super.key});

  @override
  State<SignupViewBody> createState() => _SignupViewBodyState();
}

class _SignupViewBodyState extends State<SignupViewBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late String phone, password, displayName, address, level;
  late int experienceYears;

  final List<String> experienceLevels = [
    "fresh",
    "junior",
    "midLevel",
    "senior",
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              Assets.imagesPrimaryImage,
              fit: BoxFit.fill,
              height: MediaQuery.of(context).size.height * 0.3,
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
                    CustomTextFormField(
                      onSaved: (value) {
                        displayName = value.toString();
                      },
                      hintText: "Name",
                      keyboardInputType: TextInputType.text,
                    ),
                    15.verticalSpace,
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
                    15.verticalSpace,
                    CustomTextFormField(
                      onSaved: (value) {
                        experienceYears = int.parse(value.toString());
                      },
                      hintText: "Years of experience...",
                      keyboardInputType: TextInputType.number,
                    ),
                    15.verticalSpace,
                    CustomDropDownWidget(
                      onChanged: (value) {
                        level = value;
                      },
                      content: experienceLevels,
                      colorIcon: const Color(0xff7F7F7F),
                      child: Text(
                        "Choose experience Level",
                        style: TextStyle(fontSize: 14.sp, color: const Color(0xff2F2F2F)),
                      ),
                    ),
                    15.verticalSpace,
                    CustomTextFormField(
                      onSaved: (value) {
                        address = value.toString();
                      },
                      hintText: "Address",
                      keyboardInputType: TextInputType.text,
                    ),
                    15.verticalSpace,
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
                          context.read<SignupCubit>().signUp(
                              phone: phone,
                              password: password,
                              displayName: displayName,
                              experienceYears: experienceYears,
                              address: address,
                              level: level);

                          log("name = $displayName, phone = $phone, password = $password, experienceYears = $experienceYears, address = $address, level = $level");
                        } else {
                          setState(() {
                            autovalidateMode = AutovalidateMode.always;
                          });
                        }
                      },
                      text: "Sign Up",
                    ),
                    24.verticalSpace,
                    Center(
                      child: Text.rich(
                        TextSpan(
                          text: 'Already have an account? ',
                          style: TextStyles.regular14,
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(
                                      context, SigninView.routeName);
                                },
                              text: 'Sign In',
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
      ),
    );
  }
}
