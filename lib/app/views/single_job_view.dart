import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_portal/app/controllers/home_controller.dart';
import 'package:job_portal/app/utils/helpers.dart';

import '../services/job_service.dart';
import '../utils/config.dart';

class SingleJobView extends GetView<HomeController> {
  final Map job;
  const SingleJobView({super.key,required this.job});

  @override
  Widget build(BuildContext context) {
    Utils().saveJobToLocal(job);
    controller.updateRecentJobs();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network('${Config.BASE_URL}/${job['documents']}',fit: BoxFit.cover,),
            const SizedBox(height: 16.0),
            Text(
              job['title'],
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              "Company Name: ${job['company_name']}",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              "Job Description: ${job['description']}",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 16.0),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    if(job['applied'] == false){
                      await controller.applyToJob(job);
                    }
                    else{
                    }
                  },
                  child: job['applied'] == false?Text('Apply Now'):Text('Applied'),
                ),
                IconButton(onPressed: ()async{
                  await controller.addToSavedJob(job);
                }, icon: job['saved'] == false?Icon(Icons.favorite_border):Icon(Icons.favorite,color: Colors.red,)),
              ],
            ),
          ],
        ),
      ),

    );
  }
}