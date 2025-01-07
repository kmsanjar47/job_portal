import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_portal/app/utils/config.dart';
import 'package:job_portal/app/views/single_job_view.dart';

import '../services/application_history_service.dart';
import '../widgets/application_history_tile.dart';

class ApplicationHistoryView extends StatelessWidget {
  const ApplicationHistoryView({super.key});

  Future getApplicationHistory() async {
    try {
      var response = ApplicationHistoryService().getApplicationHistory();
      print(response);
      return response;
    } catch (e) {
      print("Error: $e");
      return e;
    }
  }

  @override
  Widget build(BuildContext context) {
    Rx<List> applicationHistory = Rx([]);
    getApplicationHistory().then((value) {
      applicationHistory.value = value;
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Application History'),
      ),
      body: Obx(
        ()=> ListView.builder(
          itemCount: applicationHistory.value.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.to(() => SingleJobView(job: applicationHistory.value[index]['job_data']));
              },
              child: ApplicationHistoryTile(
                assetPath: '${Config.BASE_URL}/${applicationHistory.value[index]['job_data']['documents']}',
                companyName: applicationHistory.value[index]['job_data']['company_name'],
                postTitle: applicationHistory.value[index]['job_data']['title'],
                status: applicationHistory.value[index]['status'],
              ),
            );
          },
        ),
      ),
    );
  }
}
