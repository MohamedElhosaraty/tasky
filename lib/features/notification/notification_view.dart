//                 test local notification in flutter --------------


import 'package:flutter/material.dart';
import 'package:tasky/core/services/local_notification_service.dart';


class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  static const routeName = 'notification_view';

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // basic notification
          ListTile(
            onTap: (){
            },
          leading: Icon(Icons.notification_important),
          title: Text('basic notification'),
            trailing: IconButton(
                onPressed: (){
                  LocalNotificationService.cancelNotification(0);
                },
                icon: Icon(Icons.dangerous_outlined)),
      ),

          // repeated notification
          ListTile(
            onTap: (){
              LocalNotificationService.showRepeatedNotification();
            },
          leading: Icon(Icons.notification_important),
          title: Text('repeated notification'),
            trailing: IconButton(onPressed: () {
              LocalNotificationService.cancelNotification(1);
            },
            icon: Icon(Icons.dangerous_outlined)),
      ),

          // scheduled notification
          ListTile(
            onTap: (){
              LocalNotificationService.showScheduledNotification();
            },
          leading: Icon(Icons.notification_important),
          title: Text('scheduled notification'),
            trailing: IconButton(onPressed: () {
              LocalNotificationService.cancelNotification(2);
            },
            icon: Icon(Icons.dangerous_outlined)),
      ),

          ElevatedButton(onPressed: (){
            LocalNotificationService.flutterLocalNotificationsPlugin.cancelAll();
          },
              child: Text("cancel all notifications"))
        ],
      ),
    );
  }
}
