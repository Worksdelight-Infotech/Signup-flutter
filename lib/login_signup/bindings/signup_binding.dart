import 'package:get/instance_manager.dart';
import 'package:stasht/login_signup/controllers/signup_controller.dart';

class SignupBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(SignupController());
  }
}
