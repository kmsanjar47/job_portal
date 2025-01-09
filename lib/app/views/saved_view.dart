import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:job_portal/app/controllers/saved_jobs_controller.dart';
import '../utils/config.dart';
import '../widgets/recent_job.dart';

class SavedView extends GetView<SavedJobsController> {
  const SavedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Saved Jobs'),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Obx(
                () => controller.isSavedJobLoading.value == false
                    ? ListView.separated(
                        itemCount: controller.jobs.value.length,
                        itemBuilder: (context, index) {
                          return RecentJob(
                            assetPath:
                                '${Config.BASE_URL}/${controller.jobs.value[index]['documents']}',
                            postTitle: controller.jobs.value[index]['title'],
                            companyName: controller.jobs.value[index]
                                ['company_name'],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 10);
                        },
                      )
                    : Center(child: CircularProgressIndicator()),
              ),
            ),
          ],
        ));
  }
}
