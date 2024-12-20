import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:job_portal/app/widgets/category_item.dart';
import 'package:job_portal/app/widgets/featured_job.dart';
import 'package:job_portal/app/widgets/recent_job.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('Job Portal'),
          centerTitle: false,
          actions: [
            IconButton(
              onPressed: () {},
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
                      child: ListView.separated(
                        shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return FeaturedJob(
                                assetPath: 'assets/images/group-young-business-people-working-office.jpg',
                                jobTitle: 'Software Engineer');
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(width: 20);
                          },
                          itemCount: 10),
                    ),
                  ],
                ),
                // List View of Recent Jobs card vertical
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      'Recent Jobs',
                      style: TextStyle(fontSize: 24,),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return RecentJob(
                                assetPath: 'assets/images/group-young-business-people-working-office.jpg',
                                companyName: 'Company $index',
                                postTitle: 'Software Engineer');
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(height: 20);
                          },
                          itemCount: 10
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
