

import 'package:get/get.dart';
import 'package:horecah/modules/forgot-password/forgot-password-controller.dart';

class ForgotPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordController>(
        () => ForgotPasswordController(apiRepository: Get.find()));
  }
}