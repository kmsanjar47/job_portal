import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:job_portal/app/routes/app_pages.dart';
import 'package:job_portal/app/views/auth_view.dart';
import 'package:job_portal/app/views/profile_edit_view.dart';

import '../services/profile_service.dart';
import '../utils/config.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});
  Future getProfileInformation() async {
    try {
      var response = ProfileService().getProfileInformation();
      print(response);
      return response;
    } catch (e) {
      print("Error: $e");
      return e;
    }
  }

  @override
  Widget build(BuildContext context) {
    Rx<Map> profile = Rx({});
    RxBool isProfileInfoGiven = RxBool(false);
    getProfileInformation().then((value) {
      if(value== null){
        isProfileInfoGiven.value = false;
      }
      else{
        isProfileInfoGiven.value = true;
      }
      profile.value = value;
    });
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
          //
          // {
          //   "id": "85ddc180-3623-460b-aba9-0574b741cb8f",
          //   "name": "Khan MD Saifullah Anjar",
          //   "phone_number": "01768976882",
          //   "profile_photo": "uploads/20250106215950_Screenshot 2024-11-01 182953.png",
          //   "department": "CSE",
          //   "user_id": "76fc0e04-557b-4ce3-adfb-3e71047a9192",
          //   "email": "khan.md.saifullah@g.bracu.ac.bd",
          //   "graduation_date": "2025-01-06T15:51:20.501000",
          //   "resume": "uploads/20250106215950_Khan-MD-Saifullah-Anjar-Resume-FullStack.pdf",
          //   "saved_jobs": 2
          // }

        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Obx(
                  ()=> isProfileInfoGiven.value == true?Column(
                  children: [
                    ProfilePic(image: '${Config.BASE_URL}/${profile.value['profile_photo']}'),
                    Text(
                      '${profile.value['name']}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Divider(height: 16.0 * 2),
                    Info(
                      infoKey: "Phone no",
                      info: "${profile.value['phone_number']}",
                    ),
                    Info(
                      infoKey: "Department",
                      info: "${profile.value['department']}",
                    ),
                    Info(
                      infoKey: "Email Address",
                      info: "${profile.value['email']}",
                    ),
                    Info(
                      infoKey: "Graduation Date",
                      info: profile.value['graduation_date'].toString().split('T')[0],
                    ),
                    Info(
                      infoKey: "Resume Uploaded",
                      info: profile.value['resume']==null?'No':'Yes',
                    ),
                    const SizedBox(height: 16.0),
                  ],
                ):Column(
                    children: [
                      const ProfilePic(image: "https://i.postimg.cc/cCsYDjvj/user-2.png"),
                      Text(
                        "Annette Black",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const Divider(height: 16.0 * 2),
                      const Info(
                        infoKey: "Name",
                        info: "Not Given",
                      ),
                      const Info(
                        infoKey: "Phone no",
                        info: "Not Given",
                      ),
                      const Info(
                        infoKey: "Department",
                        info: "Not Given",
                      ),
                      const Info(
                        infoKey: "Email Address",
                        info: "Not Given",
                      ),
                      const Info(
                        infoKey: "Graduation Date",
                        info: "Not Given",
                      ),
                      const Info(
                        infoKey: "Resume Uploaded",
                        info: "No",
                      ),
                      const SizedBox(height: 16.0),
                    ],
                  )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        shape: const StadiumBorder(),
                      ),
                      onPressed: () {},
                      child: const Text("Application History"),
                    ),
                  ),
                  SizedBox(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        shape: const StadiumBorder(),
                      ),
                      onPressed: () {
                        Get.to(() => ProfileEditView());
                      },
                      child: const Text("Edit profile"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      shape: const StadiumBorder(),
                    ),
                    onPressed: () {
                      GetStorage().remove('token');
                      Get.offAllNamed(Routes.AUTH);
                    },
                    child: const Text("Logout"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    super.key,
    required this.image,
    this.isShowPhotoUpload = false,
    this.imageUploadBtnPress,
  });

  final String image;
  final bool isShowPhotoUpload;
  final VoidCallback? imageUploadBtnPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color:
          Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.08),
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(image),
          ),
          InkWell(
            onTap: imageUploadBtnPress,
            child: CircleAvatar(
              radius: 13,
              backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Info extends StatelessWidget {
  const Info({
    super.key,
    required this.infoKey,
    required this.info,
  });

  final String infoKey, info;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            infoKey,
            style: TextStyle(
              color: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .color!
                  .withOpacity(0.8),
            ),
          ),
          Text(info),
        ],
      ),
    );
  }
}
