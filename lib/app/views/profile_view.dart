import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:job_portal/app/routes/app_pages.dart';
import 'package:job_portal/app/views/auth_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,

        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const ProfilePic(image: "https://i.postimg.cc/cCsYDjvj/user-2.png"),
              Text(
                "Annette Black",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Divider(height: 16.0 * 2),
              const Info(
                infoKey: "User ID",
                info: "@annette.me",
              ),
              const Info(
                infoKey: "Location",
                info: "New York, NYC",
              ),
              const Info(
                infoKey: "Phone",
                info: "(239) 555-0108",
              ),
              const Info(
                infoKey: "Email Address",
                info: "demo@mail.com",
              ),
              const Info(
                infoKey: "Resume Uploaded",
                info: "Yes",
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 48),
                        shape: const StadiumBorder(),
                      ),
                      onPressed: () {},
                      child: const Text("Application History"),
                    ),
                  ),
                  SizedBox(
                    width: 160,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 48),
                        shape: const StadiumBorder(),
                      ),
                      onPressed: () {},
                      child: const Text("Edit profile"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 160,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 48),
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
