import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_portal/app/views/navigation_view.dart';

import '../widgets/custom_submit_button.dart';
import '../widgets/custom_text_field.dart';


class AuthView extends GetView {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController idTextCtl = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding:
        EdgeInsets.only(left: 30, right: 30),
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
                CustomTextField(idTextCtl, prefixText: "Enter BracU Email ID:"),
                SizedBox(
                  height: 50,
                ),
                // CustomTextField(idTextCtl, prefixText: "Password:"),
                // SizedBox(
                //   height: 20.h,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomSubmitButton(text: "Login/Register", color: Colors.blue,onTap: (){
                      Get.to(()=>const NavigationView());
                    },),
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