import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:job_portal/app/controllers/profile_controller.dart';
import 'package:job_portal/app/controllers/saved_jobs_controller.dart';
import 'package:job_portal/app/controllers/search_controller.dart';
import '../controllers/auth_controller.dart';
import '../controllers/home_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<SavedJobsController>(() => SavedJobsController());
    Get.lazyPut<SearchJobController>(() => SearchJobController());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}