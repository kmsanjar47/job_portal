import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../services/job_service.dart';
import '../utils/helpers.dart';

class SavedJobsController extends GetxController {
  Rx<List> jobs = Rx<List>([]);
  Rx<bool> isSavedJobLoading = false.obs;

  @override
  onInit() async{
    await getSavedJobs();
    super.onInit();
  }

  Future getSavedJobs() async {
    String token = Utils().getOpenIDToken();
    isSavedJobLoading.value = true;
    try {
      var response = await JobService().getSavedJobForUser(token);
      jobs.value = response;
      print(response);
      return response;
    } catch (e) {
      print("Error: $e");
      return e;
    }finally {
      isSavedJobLoading.value = false;
    }
  }
}