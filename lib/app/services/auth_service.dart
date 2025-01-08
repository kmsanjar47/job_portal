import 'package:dio/dio.dart';
import 'package:job_portal/app/utils/config.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:job_portal/app/views/navigation_view.dart';
import 'package:job_portal/app/views/navigation_view_publisher.dart';

class AuthService {
  Dio dio = new Dio();
  final String baseUrl = Config.BASE_URL;

  // new get box
  final box = GetStorage();

  Future login(String username, String password) async {
    String url = '${Config.BASE_URL}/login'; // Replace with actual backend URL
    try {
      // Set headers for form data
      var options = Options(
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );

      // Format the data as form data
      var formData = {
        'username': username,
        'password': password,
      };

      var response = await dio.post(
        url,
        data: formData,
        options: options,
      );

      if (response.statusCode == 200) {
        Get.snackbar("Login Successful", "You have successfully logged in");
        box.write('token', response.data['access_token']);
        box.write('is_general_user', response.data['is_general_user']);
        box.write('username', response.data['username']);
        box.write('email', response.data['email']);
        response.data['is_general_user'] == true
            ? Get.offAll(() => NavigationView())
            : Get.offAll(() => NavigationViewPublisher());
        return response.statusCode;
      } else {
        Get.snackbar("Login Failed", "Invalid credentials");
        return response.statusCode;
      }
    } catch (e) {
      print("Error: $e");
      Get.snackbar("Login Failed", "An error occurred while logging in");
      return e;
    }
  }

  Future register(String email, String username, String password) async {
    String url =
        '${Config.BASE_URL}/register'; // Replace with actual backend URL
    try {
      // Set headers for form data
      var options = Options(
        headers: {
          'Content-Type': 'application/json',
        },
      );

      // Format the data as form data

      var response = await dio.post(
        url,
        data: {
          'username': username,
          'email': email,
          'password': password,
          'is_general_user': true,
        },
        options: options,
      );

      if (response.statusCode == 200) {
        Get.snackbar(
            "Registration Successful", "You have successfully registered");
        Get.back();
        return response.statusCode;
      } else {
        Get.snackbar("Registration Failed", response.data['message']);
        return response.statusCode;
      }
    } catch (e) {
      print("Error: $e");
      Get.snackbar(
          "Registration Failed", "An error occurred while registering");
      return e;
    }
  }
}
