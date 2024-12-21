import 'package:flutter/material.dart';

import '../widgets/recent_job.dart';

class SavedView extends StatelessWidget {
  const SavedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Jobs'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
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
            child: ListView.separated(
              itemCount: 10,
              itemBuilder: (context, index) {
                return RecentJob(
                    assetPath: 'assets/images/group-young-business-people-working-office.jpg',
                    postTitle: 'Software Engineer',companyName: 'Company 1',);
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 10);
              },
            ),
          ),
        ],
      )
    );
  }
}

