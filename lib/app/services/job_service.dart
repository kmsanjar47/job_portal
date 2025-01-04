import 'package:dio/dio.dart';

import '../utils/config.dart';

class JobService {
  Dio dio = new Dio();
  final String baseUrl = Config.BASE_URL;

  Future getAllJobs() async {
    String url = '$baseUrl/jobs/jobs';
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
