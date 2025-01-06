import 'package:dio/dio.dart';
import 'package:job_portal/app/utils/config.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:job_portal/app/views/navigation_view.dart';


class NotificationService{
  Dio dio = new Dio();
  final String baseUrl = Config.BASE_URL;
  // new get box
  final box = GetStorage();

  Future getNotifications() async {
    String token = box.read('token');
    String url = '$baseUrl/notifications/notification-by-user/$token';
    try {
      var response = await dio.get(
        url,
      );
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return response.statusCode;
      }
    } catch (e) {
      print("Error: $e");
      return e;
    }
  }
}