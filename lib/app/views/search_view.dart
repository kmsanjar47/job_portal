import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:job_portal/app/services/auth_service.dart';
import 'package:job_portal/app/services/job_service.dart';
import 'package:job_portal/app/utils/helpers.dart';
import 'package:job_portal/app/views/single_job_view.dart';
import 'package:job_portal/app/widgets/featured_job.dart';

import '../utils/config.dart';
import '../widgets/recent_job.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  Future searchJobs(String query) async {
    try {
      var response = await JobService().searchJobs(query);
      return response;
    } catch (e) {
      print("Error: $e");
      return e;
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController searchContoller = TextEditingController();
    Rx<List> jobs = Rx<List>([]);

    return Scaffold(
        appBar: AppBar(
          title: Text('Search'),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  if(value.isEmpty){
                    jobs.value = [];
                    return;
                  }
                  searchJobs(value).then((data) {
                    jobs.value = data;
                  });
                },
                controller: searchContoller,
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
            ()=> ListView.separated(
                  itemCount: jobs.value.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        Get.to(()=>SingleJobView(job: jobs.value[index],));
                      },
                      child: RecentJob(
                          assetPath: '${Config.BASE_URL}/${jobs.value[index]['documents']}',
                          postTitle: jobs.value[index]['title'],companyName: jobs.value[index]['company_name'],),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 10);
                  },
                ),
              ),
            ),
          ],
        )

    );
  }
}

