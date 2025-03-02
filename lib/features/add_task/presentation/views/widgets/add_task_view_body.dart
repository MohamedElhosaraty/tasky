import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/core/services/local_notification_service.dart';
import 'package:tasky/core/utils/app_color.dart';
import 'package:tasky/core/widget/custom_button.dart';
import 'package:tasky/core/widget/custom_date.dart';
import 'package:tasky/core/widget/custom_drop_down_widget.dart';
import 'package:tasky/core/widget/custom_text_form_field.dart';
import 'package:tasky/features/add_task/presentation/cubits/create_task/create_task_cubit.dart';
import 'package:tasky/features/logo/presentation/views/logo_view.dart';
import 'package:tasky/generated/assets.dart';

import '../../../../../core/utils/app_text_style.dart';
import 'custom_button_add_image.dart';

class AddTaskViewBody extends StatefulWidget {
  const AddTaskViewBody({super.key});

  @override
  State<AddTaskViewBody> createState() => _AddTaskViewBodyState();
}

class _AddTaskViewBodyState extends State<AddTaskViewBody> {

  void listenNotification() {
    LocalNotificationService.streamController.stream.listen((notificationResponse) {

      // كده عند الضغط على الاشعار يتم الانتقال لصفحة السكنر
      Navigator.pushNamed(context, LogoView.routeName);
    });
  }

  @override
  void initState() {
    super.initState();
    listenNotification();
  }
  final List<String> experienceLevels = [
    "low",
    "medium",
    "high",
  ];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  late String image, title, desc, priority, dueDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          autovalidateMode: autovalidateMode,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.verticalSpace,
              CustomButtonAddImage(
                onImageSelected: (value) {
                  image = value!;
                },
              ),
              16.verticalSpace,
              Text(
                "Task Title",
                style:
                    TextStyles.bold13.copyWith(color: const Color(0xff6E6A7C)),
              ),
              8.verticalSpace,
              CustomTextFormField(
                  hintText: "Enter title here...",
                  onSaved: (value) {
                    title = value.toString();
                  },
                  keyboardInputType: TextInputType.text),
              16.verticalSpace,
              Text(
                "Task Description",
                style:
                    TextStyles.bold13.copyWith(color: const Color(0xff6E6A7C)),
              ),
              8.verticalSpace,
              CustomTextFormField(
                  onSaved: (value) {
                    desc = value.toString();
                  },
                  hintText: "Enter description here...",
                  maxLines: 5,
                  keyboardInputType: TextInputType.text),
              16.verticalSpace,
              Text(
                "Priority",
                style:
                    TextStyles.bold13.copyWith(color: const Color(0xff6E6A7C)),
              ),
              8.verticalSpace,
              CustomDropDownWidget(
                onChanged: (value) {
                  priority = value.toString();
                },
                content: experienceLevels,
                colorIcon: AppColor.primaryColor,
                child: Row(
                  children: [
                    Image.asset(
                      Assets.imagesFlag,
                      scale: .7,
                      color: AppColor.primaryColor,
                    ),
                    Text(
                      "  Medium Priority",
                      style: TextStyles.bold16
                          .copyWith(color: AppColor.primaryColor),
                    ),
                  ],
                ),
              ),
              16.verticalSpace,
              Text(
                "Due Date",
                style:
                    TextStyles.bold13.copyWith(color: const Color(0xff6E6A7C)),
              ),
              8.verticalSpace,
              CustomDate(
                onChangedTime: (value) {
                  dueDate = value.toString();
                },
              ),
              28.verticalSpace,
              CustomButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      context.read<CreateTaskCubit>().createTask(
                          image: image,
                          title: title,
                          desc: desc,
                          priority: priority,
                          dueDate: dueDate);

                      LocalNotificationService.showBasicNotification(
                          title: title,
                          body: desc,
                          payload: "Create A New Task");
                    }else{
                      setState(() {
                        autovalidateMode = AutovalidateMode.always;
                      });
                    }
                  },
                  text: "Add Task"),
              30.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
