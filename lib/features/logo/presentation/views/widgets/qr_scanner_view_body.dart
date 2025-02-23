import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../../core/helper_functions/build_error_bar.dart';
import '../../../../../core/utils/app_color.dart';
import '../../cubits/logo_cubit.dart';
import '../task_details.dart';

class QrScannerViewBody extends StatefulWidget {
  const QrScannerViewBody({super.key});

  @override
  State<QrScannerViewBody> createState() => _QrScannerViewBodyState();
}

class _QrScannerViewBodyState extends State<QrScannerViewBody> {


  final MobileScannerController _controller = MobileScannerController();
  Completer<void>? _scanCompleter;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _processBarcode(String? taskId) async {
    if (taskId == null || _scanCompleter != null) return;

    _scanCompleter = Completer<void>(); // بدء عملية جديدة
    try {
      final logoCubit = context.read<LogoCubit>(); // حفظ المرجع قبل بدء العملية

      await logoCubit.getOneTask(userId: taskId); // تنفيذ الطلب


      await Future.delayed(
          const Duration(seconds: 2)); // تأخير لمنع المسح المتكرر
    } finally {
      if (mounted) {
        setState(() => _scanCompleter = null);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LogoCubit, LogoState>(
      listener: (context, state) {
        if (state is GetOneTaskSuccess) {
          Navigator.pushReplacementNamed(
              context, TaskDetails.routeName, arguments: state.logoEntity);
        }
        if (state is GetOneTaskFailure) {
          buildErrorBar(context, state.errorMessage);
        }
      },
      child: Stack(
        children: [
          MobileScanner(
            controller: _controller,
            onDetect: (capture) {
              final String? taskId = capture.barcodes.firstOrNull?.rawValue;
              _processBarcode(taskId);},
          ),
          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.primaryColor, width: 3),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
