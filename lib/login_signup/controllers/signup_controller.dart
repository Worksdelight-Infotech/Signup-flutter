import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:get/get.dart';
import 'package:stasht/login_signup/domain/user_model.dart';
import 'package:stasht/utils/constants.dart';

class SignupController extends GetxController {
  // var facebookLogin = FacebookLogin();
  final RxBool isObscure = true.obs;
  final RxBool isObscureCP = true.obs;

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  GlobalKey<FormState> formkeySignin = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  Rx<TextEditingController> emailController = TextEditingController().obs;
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  TextEditingController email1Controller = TextEditingController();
  TextEditingController password1Controller = TextEditingController();

  FacebookAccessToken? _token;
  FacebookUserProfile? _profile;
  String? _email;
  String? _imageUrl;
  final plugin = FacebookLogin(debug: true);
  bool? _isLogged;
  bool _fetching = false;

  bool get fetching => _fetching;
  bool? get isLogged => _isLogged;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Map<String, dynamic>? _userData;
  Map<String, dynamic>? get userData => _userData;

  final usersRef = FirebaseFirestore.instance
      .collection(userCollection)
      .withConverter<UserModel>(
        fromFirestore: (snapshots, _) => UserModel.fromJson(snapshots.data()!),
        toFirestore: (movie, _) => movie.toJson(),
      );
  @override
  void onInit() {
    super.onInit();
    _init();
  }

  void checkEmailExists() {
    print('checkEmailExists');
    usersRef
        .where("email", isEqualTo: emailController.value.text.toString().trim())
        .get()
        .then((value) => {
              value.docs.length,
              if (value.docs.isEmpty)
                {signupUser()}
              else
                {
                  Get.snackbar("Email Exists", "This email id is already registered with us, please sign-in!",
                      colorText: Colors.white)
                }
            });
  }

// Signup user to app and save session
  Future<void> signupUser() async {
    if (formkey.currentState!.validate()) {
      try {
        EasyLoading.show(status: 'Processing..');
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: emailController.value.text.toString().trim(),
          password: passwordController.text,
        )
            .then((value) {
          print("FirebaseAuthExceptionValue $value");
          saveUserToDB(value.user, userNameController.text.toString().trim());
        }).onError((error, stackTrace) {
          if (error.toString().contains("email-already-in-use")) {
            Get.snackbar("Email exits", "The email address is already in use by another account.", snackPosition: SnackPosition.BOTTOM, colorText: Colors.white
            );
          }
          EasyLoading.dismiss();
          print("FirebaseAuthExceptionError ${error.toString()}");
          Get.snackbar("Email exits","Enter a valid email",snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
        });
      } on FirebaseAuthException catch (e) {
        EasyLoading.dismiss();
        print("FirebaseAuthException $e");
        return;
      }
    }
  }

// Signin user to app and save session
  Future<void> signIn() async {
    if (formkeySignin.currentState!.validate()) {
      try {
        EasyLoading.show(status: 'Processing..');
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: email1Controller.text.toString().trim(),
                password: password1Controller.text)
            .then((value1) {
          usersRef.where("email", isEqualTo: value1.user!.email).get().then((value) => {
                    EasyLoading.dismiss(),
                    if (value.docs.isNotEmpty)
                      {
                        Get.snackbar('Success', "User SignIn Successfully",
                            snackPosition: SnackPosition.BOTTOM, colorText: Colors.white),
                      }
                    else
                      {
                        Get.snackbar("Error", "Email not exists!",
                            colorText: Colors.white)
                      }
                  });
        });
      } on FirebaseAuthException catch (e) {
        EasyLoading.dismiss();
        if (e.code == 'user-not-found') {
          print("User not found");
          Get.back(result: {"email": email1Controller.text.toString()});
          Get.snackbar("Error", "User not found, Please signup new user",
              snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
          return Future.error(
              "User Not Found", StackTrace.fromString("User Not Found"));
        } else if (e.code == 'wrong-password') {
          print("Incorrect password");
          Get.snackbar("Error", "Password is incorrect",
              snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
          return Future.error("Incorrect password",
              StackTrace.fromString("Incorrect password"));
        } else {
          print("Login Failed ${e.message}");

          Get.snackbar("Error", "Login Failed! Please try again in some time",
              snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
          return Future.error(
              "Login Failed", StackTrace.fromString("Unknown error"));
        }
      }
    }
  }

//Save user to Firebase

  void saveUserToDB(User? user, String username) {
    UserModel userModel = UserModel(
        userName: username,
        createdAt: Timestamp.now(),
        updatedAt: Timestamp.now(),
        deviceToken: globalNotificationToken,
        deviceType: Platform.isAndroid ? "Android" : "IOS",
        displayName: username,
        email: user!.email,
        notificationCount: 0,
        profileImage: "",
        status: true);

    usersRef.add(userModel).then((value) => {
          EasyLoading.dismiss(),
          saveSession(value.id, username, user.email!, "", 0),
          clearTexts(),
          Get.snackbar('Success', "User registered",
              snackPosition: SnackPosition.BOTTOM, colorText: Colors.white),
        });
  }

// Initialize Facebook
  void _init() async {
    _isLogged = plugin.accessToken != null;
  }

  void saveSession(String _userId, String _userName, String _userEmail,
      String _userImage, int _notificationCount) {
    userId = _userId;
    userEmail = _userEmail;
    userName = _userName;
    userImage.value = _userImage;
    notificationCount.value = _notificationCount;
    clearTexts();
  }

// Clear
  void clearTexts() {
    userNameController.text = "";
    emailController.value.text = "";
    passwordController.text = "";
    email1Controller.text = "";
    password1Controller.text = "";
    confirmPasswordController.text="";
  }

  @override
  void onClose() {
    super.onClose();
    clearTexts();
  }

  @override
  void onReady() {
    super.onReady();
  }
}
