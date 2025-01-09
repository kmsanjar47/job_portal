import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dio/dio.dart' as dio;
import 'package:job_portal/app/controllers/profile_controller.dart';

class ProfileEditView extends GetView<ProfileController> {
  const ProfileEditView({super.key});

  @override
  Widget build(BuildContext context) {
    final ImagePicker imagePicker = ImagePicker();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              // Upload profile photo
              Obx(
                () => Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final pickedFile = await imagePicker.pickImage(
                            source: ImageSource.gallery);
                        if (pickedFile != null) {
                          controller.profilePhoto.value = File(pickedFile.path);
                        }
                      },
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: controller.profilePhoto.value != null
                            ? FileImage(controller.profilePhoto.value!)
                            : null,
                        child: controller.profilePhoto.value == null
                            ? const Icon(Icons.camera_alt, size: 40)
                            : null,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(controller.profilePhoto.value != null
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
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowedExtensions: ['pdf', 'doc', 'docx'],
                        );
                        if (result != null) {
                          controller.resumeFile.value =
                              File(result.files.single.path!);
                        }
                      },
                      icon: const Icon(Icons.file_upload),
                      label: const Text('Upload Resume'),
                    ),
                    const SizedBox(height: 8),
                    Text(controller.resumeFile.value != null
                        ? "Resume selected: ${controller.resumeFile.value!.path.split('/').last}"
                        : "No resume selected"),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Form fields
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                onChanged: (value) => controller.name.value = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Phone Number'),
                onChanged: (value) => controller.phoneNumber.value = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Department'),
                onChanged: (value) => controller.department.value = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                onChanged: (value) => controller.email.value = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Graduation Date'),
                onChanged: (value) => controller.graduationDate.value = value,
              ),

              const SizedBox(height: 20),

              // Save and Cancel buttons
              Obx(
    ()=> controller.isPRofileEditing.value == false?ElevatedButton(
                  onPressed: () async {
                    await controller.validateAndCreateProfileDetails();
                  },
                  child: const Text('Save'),
                ):const CircularProgressIndicator(),
              ),
              ElevatedButton(
                onPressed: () {
                  // Cancel the changes
                  controller.profilePhoto.value = null;
                  controller.resumeFile.value = null;
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
