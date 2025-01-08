import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:job_portal/app/utils/config.dart';
import 'package:job_portal/app/utils/helpers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../services/job_service.dart';

class JobHistorySingleView extends StatelessWidget {
  final Map jobHistory;

  const JobHistorySingleView({super.key, required this.jobHistory});

  Future changeJobApplicationStatus(
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

  Future<void> downloadPDF(String url, String fileName) async {
    try {
      // Check and request permission
      if (await Permission.storage.request().isGranted) {
        final dio = Dio();

        // Target the Downloads directory
        Directory? downloadsDirectory;
        if (Platform.isAndroid) {
          downloadsDirectory = Directory('/storage/emulated/0/Download');
        } else if (Platform.isIOS) {
          downloadsDirectory = await getApplicationDocumentsDirectory();
        }

        if (downloadsDirectory != null) {
          String savePath = "${downloadsDirectory.path}/$fileName";

          // Download the file
          Response response = await dio.download(url, savePath,
              onReceiveProgress: (received, total) {
                if (total != -1) {
                  print("Downloading: ${(received / total * 100).toStringAsFixed(0)}%");
                }
              });

          if (response.statusCode == 200) {
            print("Download complete: $savePath");
          } else {
            print("Download failed: ${response.statusCode}");
          }
        } else {
          print("Downloads directory not found.");
        }
      } else {
        print("Permission denied.");
      }
    } catch (e) {
      print("Error downloading file: $e");
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
                        onPressed: () async {
                          String resumeLink = '${Config.BASE_URL}/${jobHistory['user_info'][index]['resume']}';
                          String fileName = "resume_${jobHistory['user_info'][index]['id']}.pdf";

                          // Call the download function
                          await downloadPDF(resumeLink, fileName);

                          // Update job status
                          await changeJobApplicationStatus(
                            'Resume Downloaded',
                            jobHistory['user_info'][index]['id'],
                            jobHistory['job_data']['id'],
                          );

                          // Show a snackbar to notify the user
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Resume downloaded: $fileName")),
                          );
                        },
                      ),

                      IconButton(
                        icon: Icon(Icons.check),
                        onPressed: () {
                          // accept application
                          changeJobApplicationStatus(
                              'Accepted',
                              jobHistory['user_info'][index]['id'],
                              jobHistory['job_data']['id']);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          // reject application
                          changeJobApplicationStatus(
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
