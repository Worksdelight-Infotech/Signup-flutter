import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:stasht/login_signup/controllers/signup_controller.dart';
import 'package:stasht/routes/app_routes.dart';
import 'package:stasht/utils/app_colors.dart';
import 'package:stasht/utils/assets_images.dart';
import 'package:stasht/utils/constants.dart';

class Signup extends GetView<SignupController> {
  int val = -1;
  bool isEmail = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    // controller.emailController.text =
    //     Get.arguments != null ? Get.arguments["email"] : "";
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.primaryColor,
            AppColors.primaryDarkColor,
          ],
        )),
        child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25,top: 25),
            child: Form(
                key: controller.formkey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child:
                            // Container(),
                        Center(
                          child: Image.asset(
                            publishIcon,
                            color: Colors.white,
                          ),
                        ),
                        flex: 1,
                      ),

                      Expanded(
                        flex: 3,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const Center(
                                child: Text(
                                  "Sign-up",
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                    fontFamily: gibsonSemiBold,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 15),
                              MaterialButton(
                                onPressed: () {
                                  // controller.facebookSignin();
                                  // controller.facebookLogin();
                                },
                                height: 43,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      "assets/images/fb.svg",
                                      height: 16,
                                      width: 8,
                                      color: AppColors.colorBlue,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                      height: 2,
                                    ),
                                    const Text(
                                      'Sign-in with Facebook',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: robotoMedium,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.colorBlue,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                  children: const <Widget>[
                                Expanded(
                                    child: Divider(
                                  height: 1,
                                  color: AppColors.viewColor,
                                )),
                                SizedBox(
                                  width: 11,
                                ),
                                Text(
                                  "or",
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(
                                  width: 11,
                                ),
                                Expanded(
                                    child: Divider(
                                  height: 1,
                                  color: AppColors.viewColor,
                                )),
                              ]),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(11.0),
                                      topRight: Radius.circular(11.0),
                                    ),
                                    color: Colors.black.withOpacity(0.18)),
                                // padding: const EdgeInsets.only(bottom: 10),
                                child: TextFormField(
                                  controller: controller.userNameController,
                                  textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration(
                                    labelText: "Username",
                                    labelStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 10),
                                    hintText: 'Username',
                                    hintStyle: TextStyle(
                                        color: AppColors.hintPrimaryColor,
                                        fontSize: 21),
                                    errorStyle:
                                        TextStyle(color: AppColors.errorColor),
                                  ),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 21),
                                  validator: (v) {
                                    if (v!.isEmpty ||
                                        !RegExp(r"^[a-zA-Z0-9]+").hasMatch(v)) {
                                      return 'Enter a valid username!';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.18)),
                                // padding: const EdgeInsets.only(bottom: 10),
                                child: Obx(
                                  () => TextFormField(
                                    controller: controller.emailController.value,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: const InputDecoration(
                                        labelText: "Email",
                                        hintText: 'Email',
                                        hintStyle: TextStyle(
                                            color: AppColors.hintPrimaryColor,
                                            fontSize: 21),
                                        labelStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                        ),
                                        errorStyle: TextStyle(
                                            color: AppColors.errorColor),
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 10)),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 21),
                                    validator: (v) {
                                      if (v!.isEmpty) {
                                        return 'Enter a valid email!';
                                      } else if (!checkValidEmail(v)) {
                                        return 'Please enter valid email address';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        // bottomLeft: Radius.circular(11.0),
                                        // bottomRight: Radius.circular(11.0),
                                      ),
                                      color: Colors.black.withOpacity(0.18)),
                                  // padding: const EdgeInsets.only(bottom: 10),
                                  child: Obx(
                                    () => TextFormField(
                                      obscureText: controller.isObscure.value,
                                      controller: controller.passwordController,
                                      decoration: InputDecoration(
                                          labelText: "Password",
                                          hintText: 'Password',
                                          hintStyle: const TextStyle(
                                              color: AppColors.hintPrimaryColor,
                                              fontSize: 21),
                                          labelStyle: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                          ),
                                          errorStyle: const TextStyle(
                                              color: AppColors.errorColor),
                                          border: InputBorder.none,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 20.0,
                                                  vertical: 10),
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              controller.isObscure.value
                                                  ? Icons.visibility_outlined
                                                  : Icons.visibility_off,
                                              size: 15,
                                              color: AppColors.fieldBorderColor,
                                            ),
                                            onPressed: () {
                                              controller.isObscure.value =
                                                  !controller.isObscure.value;
                                            },
                                          )),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Please enter password";
                                        } else if (value.length < 8) {
                                          return "Please enter at least 8 characters";
                                        }
                                        return null;
                                      },
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 21),
                                    ),
                                  )),
                              const SizedBox(
                                height: 2,
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(11.0),
                                        bottomRight: Radius.circular(11.0),
                                      ),
                                      color: Colors.black.withOpacity(0.18)),
                                  // padding: const EdgeInsets.only(bottom: 10),
                                  child: Obx(
                                    () => TextFormField(
                                      obscureText: controller.isObscureCP.value,
                                      controller:
                                          controller.confirmPasswordController,
                                      decoration: InputDecoration(
                                          labelText: "Confirm Password",
                                          hintText: 'Confirm Password',
                                          hintStyle: const TextStyle(
                                              color: AppColors.hintPrimaryColor,
                                              fontSize: 21),
                                          labelStyle: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                          ),
                                          errorStyle: const TextStyle(
                                              color: AppColors.errorColor),
                                          border: InputBorder.none,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 20.0,
                                                  vertical: 10),
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              controller.isObscureCP.value
                                                  ? Icons.visibility_outlined
                                                  : Icons.visibility_off,
                                              size: 15,
                                              color: AppColors.fieldBorderColor,
                                            ),
                                            onPressed: () {
                                              controller.isObscureCP.value =
                                                  !controller.isObscureCP.value;
                                            },
                                          )),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Please enter confirm password";
                                        } else if (value !=
                                            controller.passwordController.text
                                                .toString()) {
                                          return "Password mismatch";
                                        }
                                        return null;
                                      },
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 21),
                                    ),
                                  )),
                              const SizedBox(height: 10),
                              GestureDetector(
                                onTap: () {
                                  controller.checkEmailExists();
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(11)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text(
                                        "Create Account",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontFamily: gibsonSemiBold),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.white,
                                        size: 10,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              InkWell(
                                onTap: () async {
                                  var result =
                                      await Get.toNamed(AppRoutes.signIn);
                                  if (result != null) {
                                    controller.emailController.value.text =
                                        result["email"];
                                  }
                                },
                                child: const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "Already a user? Click here",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppColors.fieldBorderColor,
                                        fontSize: 16,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ]))),
      ),
    ));
  }
}
