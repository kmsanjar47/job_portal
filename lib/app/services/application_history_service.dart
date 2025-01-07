import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

import 'package:job_portal/app/utils/config.dart';

class ApplicationHistoryService {
  Dio dio = new Dio();
  final String baseUrl = Config.BASE_URL;
  GetStorage box = GetStorage();
  String token = '';

  ApplicationHistoryService() {
    token = box.read('token');
  }

  Future getApplicationHistory() async {
    String url = '$baseUrl/application-history/get-application-history-by-user/$token';
    try {
      var response = await dio.get(url);
      print(response.data);
      return response.data;
    } catch (e) {
      print("Error: $e");
      return e;
    }
  }
}