import 'package:awesome_notifications/awesome_notifications.dart';

Future<void> createQueueReadyNotifications() async{
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id : 1,
      channelKey: 'basic_channel',
      title: 'Smart Queue Notification',
      body: 'Your queue number is ready',
      notificationLayout: NotificationLayout.Default
    )
  );
}



int createUniqueId(){
  int uniqueId = DateTime.now().millisecondsSinceEpoch.remainder(10000);
  return uniqueId;
}