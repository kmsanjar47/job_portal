import 'package:dio/dio.dart';
import 'package:job_portal/app/utils/config.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:job_portal/app/views/navigation_view.dart';


class ProfileService {
  Dio dio = new Dio();
  final String baseUrl = Config.BASE_URL;

  // new get box
  final box = GetStorage();

// Future getProfileInformation() async {
//   String token = box.read('token');
//   String url = '$baseUrl/users/me';
}