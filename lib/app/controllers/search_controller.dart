import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../services/job_service.dart';

class SearchJobController extends GetxController{
  TextEditingController searchContoller = TextEditingController();
  Rx<List> jobs = Rx<List>([]);
  Rx<bool> isLoading = Rx<bool>(false);

  @override
  void onInit() {
    super.onInit();
    searchContoller.addListener(() {
      if(searchContoller.text.isEmpty){
        jobs.value = [];
        return;
      }
      searchJobs(searchContoller.text).then((data) {
        jobs.value = data;
      });
    });
  }
  Future searchJobs(String query) async {
    isLoading.value = true;
    try {
      var response = await JobService().searchJobs(query);
      return response;
    } catch (e) {
      print("Error: $e");
      return e;
    }finally{
      isLoading.value = false;
    }
  }
}