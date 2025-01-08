import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:job_portal/app/utils/helpers.dart';
import '../services/job_service.dart';

class JobCreateView extends StatelessWidget {
  const JobCreateView({super.key});

  Future createJob(dio.FormData data) async {
    print("Data: $data");
    // Call API to create job
    try {
      var response = await JobService().createJob(data);
      return response;
    } catch (e) {
      print("Error: $e");
      return e;
    }
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    // Variables to hold form field values
    RxString title = ''.obs;
    RxString description = ''.obs;
    RxString companyName = ''.obs;
    RxString location = ''.obs;
    RxInt category = 1.obs;
    RxString status = ''.obs;
    Rx<File?> documents = Rx<File?>(null);
    final ImagePicker imagePicker = ImagePicker();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Job'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              // Title
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter title';
                  }
                  return null;
                },
                onSaved: (value) {
                  title.value = value!;
                },
              ),
              // Description
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter description';
                  }
                  return null;
                },
                onSaved: (value) {
                  description.value = value!;
                },
              ),
              // Company Name
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Company Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter company name';
                  }
                  return null;
                },
                onSaved: (value) {
                  companyName.value = value!;
                },
              ),
              // Location
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Location',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter location';
                  }
                  return null;
                },
                onSaved: (value) {
                  location.value = value!;
                },
              ),
              // Category
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Category',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter category';
                  }
                  return null;
                },
                onSaved: (value) {
                  if(value == 'IT'){
                    category.value = 1;
                  }else if(value == 'Engineering'){
                    category.value = 2;
                    }else if(value == 'Medical'){
                      category.value = 3;
                    }else if(value == 'Management'){
                      category.value = 4;
                  }
    },
              ),
              // Status
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Status',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter status';
                  }
                  return null;
                },
                onSaved: (value) {
                  status.value = value!;
                },
              ),
              // pic uplooad in the document field
              const SizedBox(height: 20),
              Obx(
                () => Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final pickedFile = await imagePicker.pickImage(
                            source: ImageSource.gallery);
                        if (pickedFile != null) {
                          documents.value = File(pickedFile.path);
                        }
                      },
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: documents.value != null
                            ? FileImage(documents.value!)
                            : null,
                        child: documents.value == null
                            ? const Icon(Icons.contact_page, size: 40)
                            : null,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(documents.value != null
                        ? "Uploaded image document"
                        : "Upload image documents"),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    var token = Utils().getOpenIDToken();
                    final dio.FormData formData = dio.FormData.fromMap({
                      'token': token,
                      'title': title.value,
                      'description': description.value,
                      'company_name': companyName.value,
                      'location': location.value,
                      'category': category.value,
                      'status': status.value,
                      'documents': documents.value != null
                    ? await dio.MultipartFile.fromFile(documents.value!.path, filename: 'profile_photo.jpg')
                        : null,
                    });
                    createJob(formData);
                  }
                },
                child: const Text('Create Job'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
