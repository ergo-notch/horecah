import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:horecah/lang/translation_service.dart';
import 'package:horecah/modules/home/home.dart';
import 'package:horecah/modules/publish_ad/publish_ad_controller.dart';
import 'package:horecah/routes/app_pages.dart';
import 'package:horecah/shared/catalogs/list_enums.dart';
import 'package:horecah/shared/constants/colors.dart';
import 'package:horecah/shared/shared.dart';
import 'package:horecah/shared/utils/size_config.dart';
import 'package:horecah/theme/theme_data.dart';

class PublishAdAppBar extends GetView<PublishAdController> {
  final Widget body;

  @override
  PublishAdAppBar({required this.body});

  Widget build(BuildContext context) {
    var homeController = Get.find<HomeController>();

     String locale = TranslationService.locale.toString();

    return WillPopScope(
      onWillPop: () async {
        controller.setCategory(EnumCategoryList.none);
        controller.setSubCategory(EnumSubCategoryList.none);
        controller.backStep('back');
        return true;
      },
      child: Scaffold(
          backgroundColor: ColorConstants.lightScaffoldBackgroundColor,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(65.0),
            child: AppBar(
              automaticallyImplyLeading: false,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      locale == "it_IT" ? "PUBBLICA IN  ${ controller.currentCat.value.nameIt } " : locale == "en_US"  ? "PUBLISH IN ${ controller.currentCat.value.nameEn }" : "PUBLICAR EN ${ controller.currentCat.value.nameEs }",
                      style: ThemeConfig.title3
                          .override(fontWeight: FontWeight.w600),
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Text(
                      homeController.userStrapi.value!.email.toString(),
                      style: ThemeConfig.subtitle2.override(fontSize: 12),
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.white,
              brightness: Brightness.dark,
              leading: IconButton(
                  icon: Icon(Icons.close,
                      size: 24, color: ColorConstants.darkGray),
                  onPressed: () {
                    CommonWidget.showModalInfo(
                      locale== "it_IT" ? "Sei sicuro di volver abbandonare I\'inserimento" : locale== "en_US"  ? "Are you sure you want to leave the post?" : "¿Estás seguro de que quieres dejar la publicación?" ,
                      hasCancel: true
                    ).then((onOK) {
                      if(onOK){
                        controller.cleanControllers();
                        Get.toNamed(Routes.HOME);
                      }
                    });
                  }
              ),
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _step('1', controller.actualStep.value == 1),
                      Container(
                          height: 1.0,
                          width: (SizeConfig().screenWidth / 5),
                          color: Colors.black),
                      _step('2', controller.actualStep.value == 2),
                      Container(
                          height: 1.0,
                          width: (SizeConfig().screenWidth / 5),
                          color: Colors.black),
                      _step('3', controller.actualStep.value == 3),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: body,
                  ),
                ),
              )
            ],
          )),
    );
  }

  CircleAvatar _step(String stepNumber, bool actualStep) {
    return CircleAvatar(
      backgroundColor: Colors.grey,
      radius: actualStep ? 14 : 12,
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: actualStep ? 12 : 10,
        child: Text(
          stepNumber,
          style: ThemeConfig.subtitle1.override(
              color: actualStep ? ColorConstants.activityColor : Colors.grey,
              fontSize: actualStep ? 17 : 14,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
