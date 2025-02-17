import 'package:flutter/material.dart';

class CustomDropDownWidget extends StatefulWidget {
  const CustomDropDownWidget({super.key, required this.onChanged, required this.content, required this.child, required this.colorIcon});

  final ValueChanged<String> onChanged;
  final List<String> content ;
  final Widget child;
  final Color colorIcon;


  @override
  State<CustomDropDownWidget> createState() => _CustomDropDownWidgetState();
}

class _CustomDropDownWidgetState extends State<CustomDropDownWidget> {

  String? selectedExperience;// المتغير لحفظ القيمة المختارة


  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedExperience,
      isExpanded: true, // يجعل القائمة المنسدلة تأخذ العرض بالكامل
      hint: widget.child,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE6E9E9), width: 2),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE6E9E9), width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE6E9E9), width: 2),
        ),
      ),
      dropdownColor: Colors.white, // تحديد لون القائمة المنسدلة
      icon: Icon(Icons.arrow_drop_down, color: widget.colorIcon,size: 30,),
      items: widget.content.map((String level) {
        return DropdownMenuItem<String>(
          value: level,
          child: Text(
            level,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          selectedExperience = newValue;
          widget.onChanged(newValue!);
        });
      },
    );
  }
}
