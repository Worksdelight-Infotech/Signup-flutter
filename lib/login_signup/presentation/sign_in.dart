import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:stasht/login_signup/controllers/signup_controller.dart';
import 'package:stasht/routes/app_routes.dart';
import 'package:stasht/utils/app_colors.dart';
import 'package:stasht/utils/assets_images.dart';
import 'package:stasht/utils/constants.dart';

class SignIn extends GetView<SignupController> {
  int val = -1;
  bool isEmail = false;
  bool isLoggedIn = false;
  var profileData;

  void onLoginStatusChanged(bool isLoggedIn, {profileData}) {
    this.isLoggedIn = isLoggedIn;
    this.profileData = profileData;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

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
            padding: const EdgeInsets.all(25),
            child: Form(
                key: controller.formkeySignin,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Expanded(
                          flex: 1,
                          child:
                          // Container(),

                        Center(
                              child: Center(
                                child: Image.asset(
                                  publishIcon,
                                  color: Colors.white,
                                ),
                              ),)
                      ),
                      Expanded(
                          flex: 3,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Center(
                                child: Text(
                                  "Sign-in",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontFamily: "gibsonsemibold",
                                    color: Colors.white,
                                    fontWeight: FontWeight.w100,
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
                                          color: AppColors.colorBlue),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(children: const <Widget>[
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
                                  controller: controller.email1Controller,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration(
                                      labelText: "Email",
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
                                    color: Colors.white,
                                    fontSize: 21,
                                  ),
                                  cursorColor: Colors.white,
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
                              const SizedBox(
                                height: 2,
                              ),
                              Container(
                                  // padding: const EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(11.0),
                                        bottomRight: Radius.circular(11.0),
                                      ),
                                      color: Colors.black.withOpacity(0.18)),
                                  child: Obx(
                                    () => TextFormField(
                                      obscureText: controller.isObscure.value,
                                      controller:
                                          controller.password1Controller,
                                      decoration: InputDecoration(
                                          labelText: "Password",
                                          labelStyle: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                          ),
                                          errorStyle: const TextStyle(
                                              color: AppColors.errorColor),
                                          hintText: 'Password',
                                          hintStyle: const TextStyle(
                                              color: AppColors.hintPrimaryColor,
                                              fontSize: 21),
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
                                              color: AppColors.hintPrimaryColor,
                                            ),
                                            onPressed: () {
                                              controller.isObscure.value =
                                                  !controller.isObscure.value;
                                            },
                                          )),
                                      cursorColor: Colors.white,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Please enter password";
                                        } else if (value.length < 6) {
                                          return "Please enter at least 6 characters";
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
                                  controller.signIn();
                                },
                                child: Container(
                                  height: 42,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(11)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text(
                                        "Login",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontFamily: gibsonSemiBold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              InkWell(
                                onTap: () {
                                  Get.toNamed(AppRoutes.forgotPassword);
                                },
                                child: const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "Forgot your password? ",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppColors.fieldBorderColor,
                                        fontSize: 14,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              InkWell(
                                onTap: ()  {
                                  Get.back();
                                },
                                child: const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "New user? Click here to create account",
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
                          ))
                    ]))),
      ),
    ));
  }
}
