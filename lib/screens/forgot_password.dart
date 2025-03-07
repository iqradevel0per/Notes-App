// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/controllers/singn_in.dart';
import 'package:notes_app/custom/custom_textfield.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});

  var controller = Get.put(
    AuthController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.arrow_back)),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Forgot Password",
                style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Forgot Password",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomTextfield(
                controller: controller.emailController,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 17, horizontal: 10),
                hintText: "Enter your new password",
                hintStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade700),
                suffixIcon: Icon(
                  Icons.add_alert_outlined,
                  color: const Color.fromARGB(255, 255, 89, 0),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                      width: .5,
                    )),
                cursorColor: Colors.grey.shade700,
              ),
            ),
            SizedBox(height: 100),
            Center(
              child: ElevatedButton(
                  onPressed: () async {
                    await controller.forgotPassword();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 255, 72, 0),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 70, vertical: 13),
                    child: Obx(
                      () => controller.isLoading.value
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              "Send Email",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white),
                            ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
