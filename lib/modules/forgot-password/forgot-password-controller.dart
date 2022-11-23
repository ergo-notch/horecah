import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horecah/api/api_repository.dart';
import 'package:horecah/lang/translation_service.dart';
import 'package:horecah/modules/forgot-password/new-password.dart';
import 'package:horecah/routes/app_pages.dart';
import 'package:horecah/shared/constants/colors.dart';

class ForgotPasswordController extends GetxController {
  final ApiRepository apiRepository;

  ForgotPasswordController({required this.apiRepository});

  var newPasswordController = TextEditingController();
  var newPasswordConfirmationController = TextEditingController();
  var codeController = TextEditingController();
  var emailController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  forgotPassword() async {
    final res =
        await this.apiRepository.forgotPassword(this.emailController.text);
    if (res == true) {

      Get.to(() => NewPasswordPage());
    }
  }

  resetPassword() async {
     String locale = TranslationService.locale.toString();
    final res = await apiRepository.resetPassword(
        this.codeController.text.trim(),
        this.newPasswordController.text.trim(),
        this.newPasswordConfirmationController.text.trim());

    if (res == true) {


      Get.snackbar(locale == "it_IT" ? "Password cambiata" : locale == "en_US"  ? "Password changed" : "Contraseña cambiada" ,
          locale == "it_IT" ? "La password è stata modificata correttamente." : locale == "en_US"  ? "The password has been changed successfully." : "La contraseña se ha modificado correctamente." ,
          backgroundColor: ColorConstants.principalColor,
          colorText: Colors.white,
          duration: Duration(seconds: 5),
          snackbarStatus: (status) {
        if (status == SnackbarStatus.CLOSED) {
          Get.back();
          Get.back();
        }
      });
    }
  }
}
