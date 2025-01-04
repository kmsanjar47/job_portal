import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:job_portal/app/services/auth_service.dart';
import 'package:job_portal/app/views/navigation_view.dart';
import 'package:job_portal/app/views/register_view.dart';

import '../widgets/custom_submit_button.dart';
import '../widgets/custom_text_field.dart';

class AuthView extends GetView {
  const AuthView({super.key});

  initServices() async {
    await Get.putAsync(() => GetStorage.init());
    GetStorage box = GetStorage();
    if (box.read('token') != null) {
      Get.offAll(() => NavigationView());
    }
  }

  Future login(String username, String password) async {
    try {
      var responseCode = await AuthService().login(username, password);
    } catch (e) {
      print(e);
      return e;
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController idTextCtl = TextEditingController();
    TextEditingController passwordTextCtl = TextEditingController();


    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: EdgeInsets.only(left: 30, right: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const Icon(
            //   Icons.gif_box_sharp,
            //   color: Colors.green,
            //   size: 70,
            // ),
            Text(
              "BracU Job Portal",
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Login/Register",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                Text(
                  "Job portal for BracU Students",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),

            Column(
              children: [
                CustomTextField(idTextCtl, prefixText: "Enter Username:"),
                SizedBox(
                  height: 50,
                ),
                CustomTextField(passwordTextCtl, prefixText: "Password:"),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomSubmitButton(
                      text: "Login",
                      color: Colors.blue,
                      onTap: () {
                        login(idTextCtl.text, passwordTextCtl.text);
                      },
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    CustomSubmitButton(
                      text: "Register",
                      color: Colors.blue,
                      onTap: () {
                        Get.to(() => RegisterView());
                      },
                    ),
                  ],
                ),
              ],
            ),

            Center(
              child: Text(
                "Terms and Conditions",
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 13),
              ),
            )
          ],
        ),
      ),
    );
  }
}
