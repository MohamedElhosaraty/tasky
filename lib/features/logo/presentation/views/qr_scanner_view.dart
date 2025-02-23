import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/features/logo/presentation/views/widgets/qr_scanner_view_body.dart';
import '../../../../core/services/get_it_services.dart';
import '../../domain/repos/logo_repo.dart';
import '../cubits/logo_cubit.dart';

class QRScannerView extends StatelessWidget {
  const QRScannerView({super.key});

  static const routeName = "qr_scanner_view";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LogoCubit(getIt<LogoRepo>()),
      child: const Scaffold(
        body: QrScannerViewBody(),
      ),
    );
  }
}
