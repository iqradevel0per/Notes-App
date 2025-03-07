// ignore_for_file: must_be_immutable

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/controllers/singn_in.dart';
import 'package:notes_app/custom/custom_textfield.dart';
import 'package:notes_app/screens/forgot_password.dart';
import 'package:notes_app/screens/home_screen.dart';

import 'package:notes_app/screens/singn_up.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var isObsecure = true.obs;
  var controller = Get.put(
    AuthController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 80),
                child: Text(
                  "Login",
                  style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "Email Address",
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
                  hintText: "atiqabdullad@foodit.com",
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
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "Password",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Obx(
                  () => CustomTextfield(
                    controller: controller.passwordController,
                    isObscure: isObsecure.value,
                    validator: (newValue) {
                      if (newValue == null || newValue.isEmpty) {
                        return "Please enter your password";
                      } else if (newValue.length < 6) {
                        return "Password must be atleast 6 alphabets";
                      } else {
                        return "null";
                      }
                    },
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 17, horizontal: 10),
                    hintText: "...........",
                    hintStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: Colors.grey.shade700),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        isObsecure.value = !isObsecure.value;
                      },
                      child: Icon(
                        isObsecure.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.black,
                      ),
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
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 260, right: 20),
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => ForgotPassword());
                  },
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 50),
              Center(
                child: ElevatedButton(
                    onPressed: () async {
                      await controller.SingInMethod(
                          email: controller.emailController.text,
                          password: controller.passwordController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 255, 72, 0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 140, vertical: 15),
                      child: Obx(
                        () => controller.isLoading.value
                            ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                "Log In",
                                style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white),
                              ),
                      ),
                    )),
              ),
              SizedBox(height: 30),
              Center(
                child: RichText(
                  text: TextSpan(
                      text: "Don’t have an account?",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                            text: " Sign Up",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 255, 72, 0),
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.to(() => SingUp());
                              }),
                      ],),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
