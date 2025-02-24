import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tasky/core/widget/custom_button.dart';
import 'package:tasky/core/widget/custom_date.dart';
import 'package:tasky/core/widget/custom_drop_down_widget.dart';
import 'package:tasky/core/widget/custom_text_form_field.dart';
import 'package:tasky/features/logo/domain/logo_entity/logo_entity.dart';
import 'package:tasky/features/logo/presentation/cubits/logo_cubit.dart';
import 'package:tasky/features/logo/presentation/views/widgets/custom_edite_image.dart';

import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/app_text_style.dart';
import '../../../../../generated/assets.dart';
import '../logo_view.dart';

class TaskDetailsBody extends StatefulWidget {
  const TaskDetailsBody({super.key, required this.logoEntity});

  final LogoEntity logoEntity;

  @override
  State<TaskDetailsBody> createState() => _TaskDetailsBodyState();
}

class _TaskDetailsBodyState extends State<TaskDetailsBody> {
  String? title, description, priority, dueDate, userId, status, image;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  bool editeDescription = false;
  bool editeImage = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(22.0),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          autovalidateMode: autovalidateMode,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomEditeImage(
                image: widget.logoEntity.image,
                onImageSelected: (value) {
                  image = value.toString();
                },
              ),
              16.verticalSpace,
              CustomTextFormField(
                  initialValue: widget.logoEntity.title,
                  style: TextStyles.bold24.copyWith(
                      color: AppColor.primaryColor,
                      overflow: TextOverflow.ellipsis),
                  maxLines: 1,
                  onSaved: (value) {
                    title = value;
                  },
                  hintText: '',
                  keyboardInputType: TextInputType.text),
              10.verticalSpace,
              CustomTextFormField(
                initialValue: widget.logoEntity.desc,
                  style: TextStyles.semiBold16.copyWith(
                      color: const Color(0xe5d1d3e5),
                      overflow: TextOverflow.ellipsis),
                  maxLines: 5,
                  onSaved: (value) {
                    description = value.toString();
                  },
                  hintText: '',
                  keyboardInputType: TextInputType.text),
              10.verticalSpace,
              CustomDate(
                onChangedTime: (value) {
                  dueDate = value.toString();
                },
                selectedDate: widget.logoEntity.createdAt,
              ),
              8.verticalSpace,
              CustomDropDownWidget(
                onChanged: (value) {
                  status = value.toString();
                },
                content: const ["Finished", "waiting", "Inpogress"],
                colorIcon: AppColor.primaryColor,
                child: Text(
                  widget.logoEntity.status,
                  style: TextStyles.bold16.copyWith(
                      color: AppColor.primaryColor),
                ),
              ),
              8.verticalSpace,
              CustomDropDownWidget(
                onChanged: (value) {
                  priority = value.toString();
                },
                content: const [
                  "low",
                  "medium",
                  "high",
                ],
                colorIcon: AppColor.primaryColor,
                child: Row(
                  children: [
                    Image.asset(
                      Assets.imagesFlag,
                      scale: .7,
                      color: AppColor.primaryColor,
                    ),
                    Text(
                      widget.logoEntity.priority,
                      style: TextStyles.bold16
                          .copyWith(color: AppColor.primaryColor),
                    ),
                  ],
                ),
              ),
              16.verticalSpace,
              CustomButton(
                  onPressed: () {
                    if(_formKey.currentState!.validate()){
                      _formKey.currentState!.save();
                      context.read<LogoCubit>().editeTask(
                          image: image ?? widget.logoEntity.image,
                          title: title ?? widget.logoEntity.title,
                          desc: description ?? widget.logoEntity.desc,
                          priority: priority ?? widget.logoEntity.priority,
                          userId: userId ?? widget.logoEntity.userId,
                          status: status ?? widget.logoEntity.status);

                      context.read<LogoCubit>().getLogo();
                      Navigator.pushNamed(context, LogoView.routeName);
                    }else{
                      setState(() {
                        autovalidateMode = AutovalidateMode.always;
                      });
                    }
                  },
                  text: "Save Edit"),
              16.verticalSpace,
              SizedBox(
                width: double.infinity,
                child: FittedBox(
                  child: QrImageView(
                      data: widget.logoEntity.userId,
                      version: QrVersions.auto,
                      size: 200.h),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
