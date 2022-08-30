import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stasht/forgot_password/controller/forgot_password_controller.dart';
import 'package:stasht/utils/app_colors.dart';

import '../../utils/assets_images.dart';

class ForgotPassword extends GetView<ForgotPasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 50, left: 25, right: 25),
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child:
                      // Container(),

                    Center(
                        child: Center(
                          child: Image.asset(
                            publishIcon,
                            color: Color.fromRGBO(108, 96, 255, 1),
                          ),
                        ),)
                  ),
                  // Expanded(
                  //   flex: 1,
                  //   child: Center(
                  //       child: SvgPicture.asset(
                  //     stashtLogo,
                  //   )),
                  // ),
                 Expanded(
                   flex: 2,
                   child: Column(
                   children: [
          
                  const Center(
                    child: Text(
                      "Forget Password",
                      style: TextStyle(
                        fontSize: 21, fontFamily: "gibsonsemibold",
                        color: Color.fromRGBO(108, 96, 255, 1),
                        fontWeight: FontWeight.w200,
          
                        //fontFamily: "adobe-clean-cufonfonts"),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Form(
                    key: controller.formkey,
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: const Color.fromRGBO(169, 165, 218, 1)),
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        controller: controller.emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                            labelText: "Email",
                            labelStyle: TextStyle(
                              color: Color.fromRGBO(108, 96, 255, 1),
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.only(bottom: 10, left: 15, top: 5)),
                        style: const TextStyle(color: Colors.black),
                        validator: (v) {
                          if (v!.isEmpty) {
                            return 'Enter a valid email!';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  InkWell(
                    onTap: () {
                      controller.sendResendLink();
                      //  Navigator.push(context, MaterialPageRoute(builder: (context)=> Step_2()));
                    },
                    child: Center(
                      child: Container(
                        height: 42,
                        width: 96,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(22)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "Send Link",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w200),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "Back to login",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color.fromRGBO(108, 96, 255, 1),
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  )
                   ],
                 ))
                ],
              ),
            ),
          ),
        ));
  }
}
