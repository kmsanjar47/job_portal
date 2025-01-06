import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../services/notification_service.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  Future getNotification() async {
    try {
      var response = NotificationService().getNotifications();
      print(response);
      return response;
    } catch (e) {
      print("Error: $e");
      return e;
    }
  }

  @override
  Widget build(BuildContext context) {
    Rx<List> notifications = Rx([]);
    getNotification().then((value) {
      notifications.value = value;
    });
    return Scaffold(
        appBar: AppBar(
          title: Text('Notification'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Obx(
            () => ListView.separated(
              itemCount: notifications.value.length,
              separatorBuilder: (context, index) {
                return SizedBox(height: 10);
              },
              itemBuilder: (context, index) {
                return ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  tileColor: Colors.grey[200],
                  title: Text(notifications.value[index]['message']),
                  subtitle:
                      Text(notifications.value[index]['message']),
                );
              },
            ),
          ),
        ));
  }
}
