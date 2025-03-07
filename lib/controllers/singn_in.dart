import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/models/user_model.dart';
import 'package:notes_app/screens/home_screen.dart';
import 'package:notes_app/screens/login_screen.dart';

class AuthController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  var isLoading = false.obs;

  Future<void> SingupMethod() async {
    isLoading.value = true;
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then((value) async {
        var currentUserId = FirebaseAuth.instance.currentUser!.uid;
        var createdAt = DateTime.now().toString();

        UserModel userModel = UserModel(
          name: nameController.text,
          email: emailController.text,
          password: passwordController.text,
          createdAt: createdAt,
          userId: currentUserId,
        );
        await saveUserData(userModel: userModel);
        Get.to(() => HomeScreen());
      });

      isLoading.value = false;
    } on FirebaseAuthException catch (error) {
      print("error Ocurred: ${error.message}");
      isLoading.value = false;
    }
  }

  Future<void> SingInMethod(
      {required String email, required String password}) async {
    isLoading.value = true;
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        Get.to(
          () => HomeScreen(),
        );
        isLoading.value = false;
      });
    } on FirebaseAuthException catch (error) {
      print("error Ocurred: ${error.message}");
      isLoading.value = false;
    }
  }

  Future<void> forgotPassword() async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: emailController.text)
        .then((_) {
      Get.offAll(() => LoginScreen());
    });
  }

  Future<void> saveUserData({required UserModel userModel}) async {
    await FirebaseFirestore.instance
        .collection("user")
        .doc(userModel.userId)
        .set(userModel.toMap())
        .then((_) {
      print("user data add sucessfully");
    });
  }
}
