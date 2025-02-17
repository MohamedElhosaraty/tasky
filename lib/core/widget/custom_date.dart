import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:tasky/core/utils/app_color.dart';

class CustomDate extends StatefulWidget {
   CustomDate({
    super.key, required this.onChangedTime,this.selectedDate="choose due date... ",
  });

  final ValueChanged<String> onChangedTime;
  String selectedDate ;

  @override
  State<CustomDate> createState() => _CustomDateState();
}

class _CustomDateState extends State<CustomDate> {

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true, // يمنع المستخدم من كتابة التاريخ يدويًا
      decoration: InputDecoration(
        hintText: widget.selectedDate,
        suffixIcon: IconButton(
          icon: const Icon(Icons.calendar_month_rounded,
              color: AppColor.primaryColor,
          size: 28,),
          onPressed: () {
            DatePicker.showDatePicker(
              context,
              showTitleActions: true,
              minTime: DateTime(2020, 1, 1),
              maxTime: DateTime(2025, 12, 31),

              onConfirm: (date) {
                setState(() {
                  widget.selectedDate =
                      "${date.day}/${date.month}/${date.year} "; // تحويل التاريخ الى صيغ
                  widget.onChangedTime(widget.selectedDate);
                });
              },
              currentTime: DateTime.now(),
              locale: LocaleType.en, // يمكنك تغييرها إلى `ar` للغة العربية
            );
          },
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: Color(0xffBABABA), width: 2),
        ),
      ),
    );
  }
}
