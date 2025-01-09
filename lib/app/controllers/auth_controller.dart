import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:job_portal/app/models/auth_model.dart';
import 'package:job_portal/app/views/navigation_view_publisher.dart';
import '../services/auth_service.dart';
import '../views/navigation_view.dart';

class AuthController extends GetxController {
  TextEditingController idTextCtl = TextEditingController();
  TextEditingController passwordTextCtl = TextEditingController();
  RxBool loading = false.obs;

  @override
  Future<void> onInit() async {
    await Get.putAsync(() => GetStorage.init());
    GetStorage box = GetStorage();
    if (box.read('token') != null) {
      if(box.read('is_general_user') == true){
        Get.offAll(() => NavigationView());
      }
      Get.offAll(() => NavigationViewPublisher());
    }
    super.onInit();
  }

  Future login(LoginParamsModel data) async {
    loading.value = true;
    try {
      var responseCode = await AuthService().login(data);
    } catch (e) {
      print(e);
      return e;
    }finally{
      loading.value = false;
    }
  }
}
