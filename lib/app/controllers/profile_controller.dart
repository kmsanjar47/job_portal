import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/profile_service.dart';
import 'package:dio/dio.dart' as dio;

class ProfileController extends GetxController {
  Rx<Map> profile = Rx({});
  RxBool isProfileInfoGiven = RxBool(false);
  RxBool isPRofileEditing = RxBool(false);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  // Variables to hold selected files and form field values
  Rx<File?> profilePhoto = Rx<File?>(null);
  Rx<File?> resumeFile = Rx<File?>(null);
  RxString name = ''.obs;
  RxString phoneNumber = ''.obs;
  RxString department = ''.obs;
  RxString email = ''.obs;
  RxString graduationDate = ''.obs;

  @override
  onInit() {
    super.onInit();
    getProfileInformation().then((value) {
      if(value== null){
        isProfileInfoGiven.value = false;
      }
      else{
        isProfileInfoGiven.value = true;
      }
      profile.value = value;
    });
  }
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


  Future updateProfileInformation(dio.FormData data) async {
    try {
      var response = await ProfileService().updateProfileInformation(data);
      print(response);
      return response.statusCode;
    } catch (e) {
      print("Error: $e");
      return e;
    }
  }

  validateAndCreateProfileDetails()async{
    if (formKey.currentState!.validate()) {
      isPRofileEditing.value = true;
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
      else{
        Get.snackbar('Error', 'Failed to update profile');
      }
    }
    isPRofileEditing.value = false;
  }


}