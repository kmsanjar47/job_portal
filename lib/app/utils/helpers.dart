import 'package:get_storage/get_storage.dart';

class Utils{
  GetStorage box = GetStorage();
  saveJobToLocal(Map job){
    // Check if any list of map named 'RecentJobs' exists in local storage
    box.writeIfNull('RecentJobs', []);
    // save job to local storage
    List jobs = box.read('RecentJobs');
    // Check if job already exits
    for (var i = 0; i < jobs.length; i++) {
      if(jobs[i]['id'] == job['id']){
        jobs.removeAt(i);
      }
    }
    jobs.add(job);
    box.write('RecentJobs', jobs);
  }

  getOpenIDToken(){
    return box.read('token');
  }


}