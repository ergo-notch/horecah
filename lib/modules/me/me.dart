import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horecah/lang/translation_service.dart';
import 'package:horecah/modules/home/home.dart';
import 'package:horecah/shared/constants/colors.dart';
import 'package:horecah/shared/shared.dart';
import 'package:horecah/theme/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Me extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {


    String locale = TranslationService.locale.toString();

    return CommonWidget.getScreenSizeFontFixed(
      Scaffold(
        appBar: AppBar(
          title: Text(
            locale == "it_IT" ? "Impostazioni" : locale == "en_US"  ? "Settings" : "Ajustes" ,
            style: TextStyle(color: ColorConstants.white, fontSize:  20.sp),
          ),
          backgroundColor: ColorConstants.principalColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back,
                size: 20, color: ColorConstants.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          iconTheme: IconThemeData(color: ColorConstants.titlePrincipal),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                  child: Text(
                    locale == "it_IT" ? "Cancella la sottoscrizione" : locale == "en_US"  ? "Log out" : "Cerrar sesión",
                    style: ThemeConfig.bodyText1.override(
                      color: ColorConstants.titlePrincipal,
                      fontSize: 24,
                      // fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: () {
                    controller.signout();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
