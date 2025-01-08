import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_portal/app/controllers/auth_controller.dart';
import 'package:job_portal/app/models/auth_model.dart';
import 'package:job_portal/app/views/register_view.dart';
import '../widgets/custom_submit_button.dart';
import '../widgets/custom_text_field.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: EdgeInsets.only(left: 30, right: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                CustomTextField(controller.idTextCtl,false, prefixText: "Enter Username:"),
                SizedBox(
                  height: 50,
                ),
                CustomTextField(controller.passwordTextCtl,true, prefixText: "Password:"),
                SizedBox(
                  height: 20,
                ),
                Obx(
                  ()=> controller.loading.value == false? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomSubmitButton(
                        text: "Login",
                        color: Colors.blue,
                        onTap: () {
                          controller.login(LoginParamsModel(
                              username: controller.idTextCtl.text,
                              password: controller.passwordTextCtl.text
                          ));
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
                  ): Center(child: CircularProgressIndicator(),),
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
