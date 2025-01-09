import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_portal/app/controllers/auth_controller.dart';
import 'package:job_portal/app/views/single_job_view.dart';
import '../controllers/search_controller.dart';
import '../utils/config.dart';
import '../widgets/recent_job.dart';

class SearchView extends GetView<SearchJobController> {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Search'),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                // onChanged: (value) {
                //   if(value.isEmpty){
                //     controller.jobs.value = [];
                //     return;
                //   }
                //   searchJobs(value).then((data) {
                //     jobs.value = data;
                //   });
                // },
                controller: controller.searchContoller,
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Obx(
            ()=> controller.isLoading.value == false?ListView.separated(
                  itemCount: controller.jobs.value.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        Get.to(()=>SingleJobView(job: controller.jobs.value[index],));
                      },
                      child: RecentJob(
                          assetPath: '${Config.BASE_URL}/${controller.jobs.value[index]['documents']}',
                          postTitle: controller.jobs.value[index]['title'],companyName: controller.jobs.value[index]['company_name'],),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 10);
                  },
                ):Center(child: CircularProgressIndicator(),),
              ),
            ),
          ],
        )

    );
  }
}

