import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';

import '../utils/config.dart';

class JobService {
  Dio dio = new Dio();
  final String baseUrl = Config.BASE_URL;
  GetStorage box = GetStorage();

  Future getAllJobs() async {
    String token = box.read('token');
    String url = '$baseUrl/jobs/jobs/$token';
    try {
      var response = await dio.get(url);
      print(response.data);
      return response.data;
    } catch (e) {
      print("Error: $e");
      return e;
    }
  }

  Future searchJobs(String query) async {
    String url = '$baseUrl/jobs/jobs/search/$query';
    try {
      var response = await dio.get(url);
      print(response.data);
      return response.data;
    } catch (e) {
      print("Error: $e");
      return e;
    }
  }

  ///jobs/saved-by-user/{token}

  Future getSavedJobForUser(String token) async {
    String url = '$baseUrl/jobs/jobs/saved-by-user/$token';
    try {
      var response = await dio.get(url);
      print(response.data);
      return response.data;
    } catch (e) {
      print("Error: $e");
      return e;
    }
  }
  // /jobs/saved-by-user/{job_id}

  Future addToSavedJob(String token, int jobId) async {
    String url = '$baseUrl/jobs/jobs/saved-by-user/$jobId';
    try {
      var options = Options(
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );
      var response = await dio.post(url, data: {'auth_token': token}, options: options);
      if(response.statusCode == 200){
        Get.snackbar("Success", "Job saved successfully");
        return response.data;
      }else{
        Get.snackbar("Error", "An error occurred while saving job");
        return response.data;
      }
    } catch (e) {
      print("Error: $e");
      return e;
    }
  }

  Future applyToJob(String token, int jobId) async {
    String url = '$baseUrl/jobs/jobs/apply/$token/$jobId';
    try {
      // var options = Options(
      //   headers: {
      //     'Content-Type': 'application/x-www-form-urlencoded',
      //   },
      // );
      var response = await dio.post(url);
      if(response.statusCode == 200){
        Get.snackbar("Success", "Job applied successfully");
        return response.data;
      }else{
        Get.snackbar("Error", "An error occurred while applying job");
        return response.data;
      }
    } catch (e) {
      print("Error: $e");
      return e;
    }
  }
}
