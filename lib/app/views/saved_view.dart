import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:job_portal/app/utils/helpers.dart';

import '../services/job_service.dart';
import '../utils/config.dart';
import '../widgets/recent_job.dart';

class SavedView extends StatelessWidget {
  const SavedView({super.key});

  Future getSavedJobs() async {
    String token = Utils().getOpenIDToken();
    try {
      var response = await JobService().getSavedJobForUser(token);
      print(response);
      return response;
    } catch (e) {
      print("Error: $e");
      return e;
    }
  }

  @override
  Widget build(BuildContext context) {
    Rx<List> jobs = Rx<List>([]);
    Rx<List> searchJobs = Rx<List>([]);
    getSavedJobs().then((data) {
      jobs.value = data;
      searchJobs.value = data;
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Jobs'),
      ),
      body: Column(
        children: <Widget>[
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: TextField(
          //     onChanged: (value) {
          //       if(value.isEmpty){
          //         searchJobs.value = jobs.value;
          //         return;
          //       }
          //       jobs.value.forEach((element) {
          //         if(element['title'].contains(value)){
          //           searchJobs.value.add(element);
          //         }
          //       });
          //     },
          //     decoration: InputDecoration(
          //       hintText: 'Search',
          //       prefixIcon: Icon(Icons.search),
          //       border: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(10),
          //       ),
          //     ),
          //   ),
          // ),
            Expanded(
            child: Obx(
          ()=> ListView.separated(
                itemCount: searchJobs.value.length,
                itemBuilder: (context, index) {
                  return RecentJob(
                      assetPath: '${Config.BASE_URL}/${searchJobs.value[index]['documents']}',
                      postTitle: searchJobs.value[index]['title'],companyName: searchJobs.value[index]['company_name'],);
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

