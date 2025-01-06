import 'package:dio/dio.dart';
import 'package:get/get.dart' as Get;
import 'package:get/get_core/src/get_main.dart';
import 'package:job_portal/app/utils/config.dart';
import 'package:get_storage/get_storage.dart';

class ProfileService {
  Dio dio = new Dio();
  final String baseUrl = Config.BASE_URL;

  // new get box
  final box = GetStorage();

  Future getProfileInformation() async {
    String token = box.read('token');
    String url = '$baseUrl/user-profile/user-profile/$token';

    try {
      var response = await dio.get(url);
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

  Future updateProfileInformation(FormData data) async {
    String token = box.read('token');
    String url = '$baseUrl/user-profile/user-profile/$token';

    // multipart form data

    var options = Options(
      headers: {
        'Content-Type': 'multipart/form-data',
      },
    );

    try {
      var response = await dio.patch(
        url,
        data: data,
        options: options,
      );
      if (response.statusCode == 200) {
        Get.Get.snackbar('Success', 'Profile updated successfully');
        Get.Get.back();
        return response.statusCode;
      } else {
        return response.statusCode;
      }
    } catch (e) {
      print("Error: $e");
      return e;
    }
  }
}
