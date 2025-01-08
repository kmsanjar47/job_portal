import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:job_portal/app/widgets/job_history_tile.dart';

import '../services/job_service.dart';
import '../utils/config.dart';
import '../utils/helpers.dart';
import 'job_history_single_view.dart';

class JobHistory extends StatelessWidget {
  const JobHistory({super.key});

  Future getAllCreatedJobHistory() async {
    String token = Utils().getOpenIDToken();

    try {
      var response = await JobService().getAllCreatedJobStatus(token);
      return response;
    }catch(e){
      print("Error: $e");
      return e;
    }
  }

  @override
  Widget build(BuildContext context) {
    RxList jobHistory = RxList();
    getAllCreatedJobHistory().then((value) => jobHistory.addAll(value));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job History'),
      ),
      body: Obx(
        ()=> ListView.separated(
          itemCount: jobHistory.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: (){
                Get.to(
                  () => JobHistorySingleView(jobHistory: jobHistory[index]),
                );
              },
              child: JobHistoryTile(
                  assetPath: '${Config.BASE_URL}/${jobHistory[index]['job_data']['documents']}',
                  companyName: jobHistory[index]['job_data']['company_name'],
                  postTitle: jobHistory[index]['job_data']['title'],
                  totalApplications: jobHistory[index]['user_info'].length,
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
        ),
      ),

    );
  }
}
