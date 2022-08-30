import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final formkey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> sendResendLink() async {
    if (formkey.currentState!.validate()) {
      EasyLoading.show(status: 'Processing..');
      await firebaseAuth
          .sendPasswordResetEmail(email: emailController.text.toString())
          .then((value) => {
                print('value '),
                emailController.text = "",
                EasyLoading.dismiss(),
                Get.back(),
                Get.snackbar(
                    'Success', 'Password reset link has sent to your email', colorText: Colors.white),
              })
          .onError((error, stackTrace) =>
              {print('onError $error'), EasyLoading.dismiss()});
    }
  }

  @override
  void onReady() {
    super.onReady();
  }
}
