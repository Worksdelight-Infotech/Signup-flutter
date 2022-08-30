import 'package:get/get.dart';
import 'package:stasht/forgot_password/controller/forgot_password_controller.dart';

class ForgotPasswordBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(ForgotPasswordController());
  }
}
