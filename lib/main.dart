import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/core/services/local_notification_service.dart';
import 'package:tasky/core/services/work_manager_service.dart';
import 'package:tasky/features/splash/splash_view.dart';

import 'core/helper_functions/on_generate_route.dart';
import 'core/services/custom_bloc_observer.dart';
import 'core/services/get_it_services.dart';
import 'core/services/shered_preferences_singleton.dart';
import 'core/utils/app_color.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Future.wait([
   LocalNotificationService.init(),
   WorkManagerService().init(),
  ]);

  Bloc.observer = CustomBlocObserver();
  await Prefs.init();
  setupGetIt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            theme: ThemeData(
              fontFamily: "Cairo",
              scaffoldBackgroundColor: Colors.white,
              colorScheme: ColorScheme.fromSeed(
                seedColor: AppColor.primaryColor,
              ),
            ),

            debugShowCheckedModeBanner: false,
            onGenerateRoute: onGenerateRoute,
            initialRoute: SplashView.routeName,
          );
        });
  }
}
