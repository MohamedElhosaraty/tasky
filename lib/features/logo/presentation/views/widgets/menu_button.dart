import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/utils/app_text_style.dart';
import 'package:tasky/features/logo/presentation/cubits/logo_cubit.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      color: Colors.white,
      onSelected: (value) {
        if (value == 'edit') {
          // تنفيذ أمر التعديل
        } else if (value == 'delete') {
          // تنفيذ أمر الحذف
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
         PopupMenuItem<String>(
          value: 'edit',
          child: Text('Edit',
            style: TextStyles.bold19),
        ),
         PopupMenuItem<String>(
           onTap: (){
             context.read<LogoCubit>().deleteTask(userId: userId);
               context.read<LogoCubit>().getLogo();
           },
          value: 'delete',
          child: Text(
            'Delete',
            style: TextStyles.bold19.copyWith(color: const Color(0xffFF7D53)),
          ),
        ),
      ],
      child: const Icon(Icons.more_vert,size: 30,color: Colors.black,), // أيقونة النقاط الثلاث
    );
  }
}
