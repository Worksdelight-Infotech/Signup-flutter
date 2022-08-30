import 'package:get/route_manager.dart';
import 'package:stasht/forgot_password/bindings/forgot_password_binding.dart';
import 'package:stasht/forgot_password/presentation/forget_password.dart';
import 'package:stasht/login_signup/bindings/signup_binding.dart';
import 'package:stasht/login_signup/presentation/sign_in.dart';
import 'package:stasht/routes/app_routes.dart';
import 'package:stasht/login_signup/domain/sign_up.dart';

class AppPages {
  static const initial = AppRoutes.signup;
  static final routes = [
    GetPage(
        name: AppRoutes.signIn, page: () => SignIn(), binding: SignupBinding()),
    GetPage(
        name: AppRoutes.signup, page: () => Signup(), binding: SignupBinding()),
    GetPage(
        name: AppRoutes.forgotPassword,
        page: () => ForgotPassword(),
        binding: ForgotPasswordBindings()),
  ];
}
