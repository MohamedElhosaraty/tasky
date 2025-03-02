import 'package:workmanager/workmanager.dart';


// to run background task
class WorkManagerService{

  // تسجيل التاسك
  void registerMyTask() async {
    await Workmanager().registerPeriodicTask(
        "1",
        "simpleTask",
      // بعد الوقت المحدد يتنفذ التاسك فى ال background  وتكون اقل حاجه ربع ساعه
      frequency: Duration(hours: 12),
    );
  }

// init WorkManager service
  Future<void> init() async{
    Workmanager().initialize(
        callbackDispatcher,
        isInDebugMode: true,
    );
    registerMyTask();
  }

  void cancelTask(String uniqueName) {
    Workmanager().cancelByUniqueName(uniqueName);
  }
}

// الحاجه الى هتتنفذ فى ال background
@pragma('vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  // ده التاسك الى هيتنفذ
  Workmanager().executeTask((task, inputData) {
    // LocalNotificationService.showDailyScheduledNotification();
    // log("Native called background task: $task"); //simpleTask will be emitted here.
    return Future.value(true);
  });
}