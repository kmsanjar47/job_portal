import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:job_portal/app/services/job_service.dart';
import 'package:job_portal/app/utils/config.dart';
import 'package:job_portal/app/views/chat_view.dart';
import 'package:job_portal/app/views/job_create_view.dart';
import 'package:job_portal/app/views/single_job_view.dart';
import 'package:job_portal/app/widgets/category_item.dart';
import 'package:job_portal/app/widgets/featured_job.dart';
import 'package:job_portal/app/widgets/recent_job.dart';

import '../controllers/home_controller.dart';
import 'notification_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  Future getAllJobs() async {
    try {
      var data = await JobService().getAllJobs();
      return data;
    } catch (e) {
      print(e);
      return e;
    }
  }

  @override
  Widget build(BuildContext context) {
    GetStorage box = GetStorage();
    box.writeIfNull('RecentJobs', []);
    Rx<List> recentJobs = Rx<List>([]);
    recentJobs.value = box.read('RecentJobs');
    print("Token: ${box.read('token')}");
    print("Recent Jobs: $recentJobs");
    Rx<List> jobs = Rx<List>([]);
    getAllJobs().then((data) {
      jobs.value = data;
    });
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => JobCreateView());
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('Job Portal'),
          centerTitle: false,
          actions: [
            IconButton(onPressed: (){
              Get.to(() => NotificationView());
            }, icon: Icon(Icons.notifications_none)),
            IconButton(
              onPressed: () {
                Get.to(()=>ChatView());
              },
              icon: Icon(Icons.chat_bubble_outline),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SizedBox(height: 20),
                // List view of categories horizontal
                SizedBox(
                  height: 80,
                  child: ListView.separated(
                    shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return CategoryItem(
                            icon: Icon(Icons.ice_skating),
                            category: 'Category $index');
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(width: 20);
                      },
                      itemCount: 10),
                ),
                // List View of Featured Jobs card horizontal
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Featured Jobs',
                      style: TextStyle(fontSize: 24),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      height: 220,
                      child:Obx(()=> ListView.separated(
                        shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: (){
                                Get.to(()=>SingleJobView(job: jobs.value[index]));
                              },
                              child: FeaturedJob(
                                  assetPath: '${Config.BASE_URL}/${jobs.value[index]['documents']}',
                                  jobTitle: jobs.value[index]['title'],),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(width: 20);
                          },
                          itemCount: jobs.value.length),
                    )),
                  ],
                ),
                // List View of Recent Jobs card vertical
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      'Recently Viewed',
                      style: TextStyle(fontSize: 24,),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      child: Obx(
                          ()=> ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: (){
                                  Get.to(()=>SingleJobView(job: recentJobs.value[index],));
                                },
                                child: RecentJob(
                                    assetPath: '${Config.BASE_URL}/${recentJobs.value[index]['documents']}',
                                    companyName: recentJobs.value[index]['company_name'],
                                    postTitle: recentJobs.value[index]['title'],),
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) {
                              return SizedBox(height: 20);
                            },
                            itemCount: recentJobs.value.length
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
