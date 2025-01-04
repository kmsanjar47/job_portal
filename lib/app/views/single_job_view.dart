import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/config.dart';

class SingleJobView extends GetView {
  final Map job;
  const SingleJobView({super.key,required this.job});

  init() {

  }

  @override
  Widget build(BuildContext context) {
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
                  onPressed: () {},
                  child: const Text('Apply Now'),
                ),
                IconButton(onPressed: (){}, icon: const Icon(Icons.favorite_border)),
              ],
            ),
          ],
        ),
      ),

    );
  }
}