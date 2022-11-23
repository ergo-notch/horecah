import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horecah/lang/translation_service.dart';
import 'package:horecah/modules/forgot-password/forgot-password-controller.dart';
import 'package:horecah/modules/forgot-password/new-password.dart';
import 'package:horecah/shared/constants/colors.dart';
import 'package:horecah/shared/widgets/custom_widgets.dart';
import 'package:horecah/theme/theme_data.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({Key? key}) : super(key: key);

  final forgotPassCtrl = Get.find<ForgotPasswordController>();

  @override
  Widget build(BuildContext context) {
    String locale = TranslationService.locale.toString();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            locale == "it_IT" ? "Resetta la password" : locale == "en_US"  ? "Reset password" : "Resetear contraseña" ,
            style: TextStyle(color: ColorConstants.white, fontSize:  20.sp),
          ),
          centerTitle: true,
          backgroundColor: ColorConstants.principalColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, size: 20, color: ColorConstants.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          iconTheme: IconThemeData(color: ColorConstants.titlePrincipal),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              TitlePrincipalAds(locale == "it_IT" ? "Hai dimenticato la tua password?" : locale == "en_US"  ? "Forgot your password?" : "¿Haz olvidado tu contraseña?" ,
                  color: Colors.black),
              SizedBox(
                height: 15,
              ),
              TitlePrincipalAds(
                  locale == "it_IT" ? "Inserisci la tua email, premi conferma e riceverai un codice di verifica nella tua email." : locale == "en_US"  ? "Enter your email, press confirm and you will receive a verification code in your email." : "Ingrese su correo electrónico, presione confirmar y recibirá un codigo de verificación en su correo." ,),
              SizedBox(
                height: 10,
              ),
                TextFormField(
          controller: forgotPassCtrl.emailController,
          obscureText: false,
          decoration: InputDecoration(
            hintText: "login_label2".tr,
            hintStyle: ThemeConfig.bodyText1.override(
              color: Color(0xFF3C4858),
              fontSize: 18,
              fontWeight: FontWeight.w300,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFF3C4858),
                width: 0.5,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4.0),
                topRight: Radius.circular(4.0),
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFF3C4858),
                width: 0.5,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4.0),
                topRight: Radius.circular(4.0),
              ),
            ),
          ),
          style: ThemeConfig.bodyText1.override(
            color: Color(0xFF3C4858),
            fontSize: 18,
            fontWeight: FontWeight.w300,
          ),
          keyboardType: TextInputType.emailAddress,
          validator: (val) {
            if (val!.isEmpty) {
              return 'This field is required.';
            }
            if (val.length < 5) {
              return 'Requires at least 5 characters.';
            }
            return null;
          },
        ),

         SizedBox(
                height: 20,
              ),
              Container(
                width: Get.width,
                height: 50,
                child: TextButton(
                    onPressed: () {
                      
                      forgotPassCtrl.forgotPassword();
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: ColorConstants.principalColor),
                    child: Text(
                     locale == "it_IT" ? "Confermare" : locale == "en_US"  ? "Confirm" : "Confirmar" ,
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    )),
              ),
              SizedBox(
                height: 25,
              ),
              Divider(),
              SizedBox(
                height: 40,
              ),
             
            ],
          ),
        )),
      ),
    );
  }
}


