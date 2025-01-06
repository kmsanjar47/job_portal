import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dio/dio.dart' as dio;
import '../services/profile_service.dart';

class ProfileEditView extends GetView {
  const ProfileEditView({super.key});

  Future updateProfileInformation(dio.FormData data) async {
    try {
      var response = await ProfileService().updateProfileInformation(data);
      print(response);
      return response;
    } catch (e) {
      print("Error: $e");
      return e;
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    // Variables to hold selected files and form field values
    Rx<File?> profilePhoto = Rx<File?>(null);
    Rx<File?> resumeFile = Rx<File?>(null);
    RxString name = ''.obs;
    RxString phoneNumber = ''.obs;
    RxString department = ''.obs;
    RxString email = ''.obs;
    RxString graduationDate = ''.obs;

    final ImagePicker imagePicker = ImagePicker();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              // Upload profile photo
              Obx(
                    () => Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final pickedFile =
                        await imagePicker.pickImage(source: ImageSource.gallery);
                        if (pickedFile != null) {
                          profilePhoto.value = File(pickedFile.path);
                        }
                      },
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: profilePhoto.value != null
                            ? FileImage(profilePhoto.value!)
                            : null,
                        child: profilePhoto.value == null
                            ? const Icon(Icons.camera_alt, size: 40)
                            : null,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(profilePhoto.value != null
                        ? "Profile photo selected"
                        : "Upload profile photo"),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Upload resume
              Obx(
                    () => Column(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () async {
                        FilePickerResult? result = await FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowedExtensions: ['pdf', 'doc', 'docx'],
                        );
                        if (result != null) {
                          resumeFile.value = File(result.files.single.path!);
                        }
                      },
                      icon: const Icon(Icons.file_upload),
                      label: const Text('Upload Resume'),
                    ),
                    const SizedBox(height: 8),
                    Text(resumeFile.value != null
                        ? "Resume selected: ${resumeFile.value!.path.split('/').last}"
                        : "No resume selected"),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Form fields
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                onChanged: (value) => name.value = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Phone Number'),
                onChanged: (value) => phoneNumber.value = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Department'),
                onChanged: (value) => department.value = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                onChanged: (value) => email.value = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Graduation Date'),
                onChanged: (value) => graduationDate.value = value,
              ),

              const SizedBox(height: 20),

              // Save and Cancel buttons
              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    // Prepare data for the API
                    final dio.FormData formData = dio.FormData.fromMap({
                      'name': name.value,
                      'phone_number': phoneNumber.value,
                      'department': department.value,
                      'email': email.value,
                      'graduation_date': graduationDate.value,
                      'profile_photo': profilePhoto.value != null
                          ? await dio.MultipartFile.fromFile(profilePhoto.value!.path, filename: 'profile_photo.jpg')
                          : null,
                      'resume': resumeFile.value != null
                          ? await dio.MultipartFile.fromFile(resumeFile.value!.path, filename: 'resume.pdf')
                          : null,
                    });

                    // Call the API
                    var response = await updateProfileInformation(formData);
                    if(response == 200){
                      Get.snackbar('Success', 'Profile updated successfully');
                      Get.back();
                    }
                  }
                },
                child: const Text('Save'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Cancel the changes
                  profilePhoto.value = null;
                  resumeFile.value = null;
                },
                child: const Text('Cancel'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
