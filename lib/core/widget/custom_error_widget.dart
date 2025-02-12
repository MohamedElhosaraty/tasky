import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({super.key, required this.data});
  final String data;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        data
      ),
    );
  }
}
