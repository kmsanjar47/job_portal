import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/routes/app_pages.dart';
import 'app/views/navigation_view.dart';

initServices() async {
  await Get.putAsync(() => GetStorage.init());
  GetStorage box = GetStorage();
  if (box.read('token') != null) {
    Get.offAll(() => NavigationView());
  }
}

void main() {

  runApp(
    GetMaterialApp(theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
