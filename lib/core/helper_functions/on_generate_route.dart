import 'package:flutter/material.dart';
import 'package:tasky/features/add_task/presentation/views/add_task_view.dart';
import 'package:tasky/features/auth/presentation/views/signin_view.dart';
import 'package:tasky/features/auth/presentation/views/signup_view.dart';
import 'package:tasky/features/logo/domain/logo_entity/logo_entity.dart';
import 'package:tasky/features/logo/presentation/views/logo_view.dart';
import 'package:tasky/features/logo/presentation/views/qr_scanner_view.dart';
import 'package:tasky/features/logo/presentation/views/task_details.dart';
import 'package:tasky/features/on_boarding/on_boarding_view.dart';
import 'package:tasky/features/profile/presentation/views/profile_view.dart';
import '../../features/splash/splash_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashView.routeName:
      return MaterialPageRoute(builder: (_) => const SplashView());

    case OnBoardingView.routeName:
      return MaterialPageRoute(builder: (_) => const OnBoardingView());

    case SigninView.routeName:
      return MaterialPageRoute(builder: (_) => const SigninView());

    case SignupView.routeName:
      return MaterialPageRoute(builder: (_) => const SignupView());

    case LogoView.routeName:
      return MaterialPageRoute(builder: (_) => const LogoView());

    case AddTaskView.routeName:
      return MaterialPageRoute(builder: (_) => const AddTaskView());

    case ProfileView.routeName:
      return MaterialPageRoute(builder: (_) => const ProfileView());
    case QRScannerView.routeName:
      return MaterialPageRoute(builder: (_) => const QRScannerView());

    case TaskDetails.routeName:
      return MaterialPageRoute(
          builder: (_) => TaskDetails(
                logoEntity: settings.arguments as LogoEntity,
              ));

    default:
      return MaterialPageRoute(builder: (_) => const Scaffold());
  }
}
