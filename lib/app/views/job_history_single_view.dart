import 'package:flutter/material.dart';
import 'package:job_portal/app/utils/config.dart';
import 'package:job_portal/app/utils/helpers.dart';

import '../services/job_service.dart';

class JobHistorySingleView extends StatelessWidget {
  final Map jobHistory;

  const JobHistorySingleView({super.key, required this.jobHistory});

  Future chaangeJobApplicationStatus(
      String status, String userId, int jobId) async {
    try {
      String token = Utils().getOpenIDToken();
      var response = await JobService()
          .changeJobApplicaitonStatus(token, jobId, status, userId);
      return response;
    } catch (e) {
      print("Error: $e");
      return e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(jobHistory['job_data']['title']),
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    '${Config.BASE_URL}/${jobHistory['job_data']['documents']}'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            title: Text(jobHistory['job_data']['title']),
            subtitle: Text(jobHistory['job_data']['company_name']),
          ),
          // Listview builder with list tile with accept or reject or download button for each tile
          Expanded(
            child: ListView.separated(
              itemCount: jobHistory['user_info'].length,
              itemBuilder: (context, index) {
                return ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  style: ListTileStyle.list,
                  leading: CircleAvatar(
                    child: Image.network(
                      '${Config.BASE_URL}/${jobHistory['user_info'][index]['profile_photo']}',
                      fit: BoxFit.fill,
                    ),
                  ),
                  tileColor: Colors.grey[200],
                  title: Text(jobHistory['user_info'][index]['name']),
                  subtitle: Text(jobHistory['user_info'][index]['email']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.download),
                        onPressed: () {
                          // download resume
                          String resume_link =
                              jobHistory['user_info'][index]['resume'];
                          // download pdf from link

                          // change job status
                          chaangeJobApplicationStatus(
                              'Resume Downloaded',
                              jobHistory['user_info'][index]['id'],
                              jobHistory['job_data']['id']);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.check),
                        onPressed: () {
                          // accept application
                          chaangeJobApplicationStatus(
                              'Accepted',
                              jobHistory['user_info'][index]['id'],
                              jobHistory['job_data']['id']);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          // reject application
                          chaangeJobApplicationStatus(
                              'Rejected',
                              jobHistory['user_info'][index]['id'],
                              jobHistory['job_data']['id']);
                        },
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
            ),
          )
        ],
      ),
    );
  }
}
