import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../services/job_service.dart';
import '../utils/helpers.dart';

class HomeController extends GetxController {
  GetStorage box = GetStorage();
  Rx<List> recentJobs = Rx<List>([]);
  Rx<List> jobs = Rx<List>([]);
  Rx<bool> isFeaturedJobLoading = false.obs;


  @override
  onInit() async{
    super.onInit();
    await getAllJobs();
   box.writeIfNull('RecentJobs', []);
   recentJobs.value = box.read('RecentJobs');
  }

  updateRecentJobs(){
    recentJobs.value = box.read('RecentJobs');
  }

  Future getAllJobs() async {
    isFeaturedJobLoading.value = true;
    try {
      var data = await JobService().getAllJobs();
      jobs.value = data;
    } catch (e) {
      print(e);
      return e;
    }finally {
      isFeaturedJobLoading.value = false;
    }
  }



  Future applyToJob(job) async {
    String token = Utils().getOpenIDToken();
    try {
      var response = JobService().applyToJob(token, job['id']);
      print(response);
      return response;
    } catch (e) {
      print("Error: $e");
      return e;
    }
  }

  Future addToSavedJob(job) async {
    String token = Utils().getOpenIDToken();
    try {
      var response = await JobService().addToSavedJob(token, job['id']);
      print(response);
      return response;
    } catch (e) {
      print("Error: $e");
      return e;
    }
  }
}

