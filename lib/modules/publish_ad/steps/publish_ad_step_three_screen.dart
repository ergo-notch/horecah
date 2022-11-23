import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horecah/lang/translation_service.dart';
import 'package:horecah/modules/publish_ad/publish_ad_controller.dart';
import 'package:horecah/modules/publish_ad/widgets/publish_ad_app_bar.dart';
import 'package:horecah/modules/publish_ad/widgets/select_image.dart';
import 'package:horecah/shared/shared.dart';
import 'package:horecah/theme/theme_data.dart';

class PublishAdStepThreeScreen extends GetView<PublishAdController> {
  @override
  Widget build(BuildContext context) {
    String locale = TranslationService.locale.toString();
    
    return PublishAdAppBar(
        body: Stack(
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 60),
          child: ListView(
            children: [
              Align(
                alignment: Alignment.center,
                child: TitlePrincipalAds(   locale == "it_IT" ? "Conferma il tuo annuncio" : locale == "en_US"  ? "Confirm your ad" : "Confirma tu anuncio" ,),
              ),
              SizedBox(
                height: 20,
              ),
              TitlePrincipalAds( locale == "it_IT" ? "Titolo dell\'annuncio" : locale == "en_US"  ? "Ad title" : "Título del anuncio" ),
              Text(
                controller.controllerTitle.text,
                style: ThemeConfig.bodyText1,
              ),
              SizedBox(
                height: 20,
              ),
              TitlePrincipalAds(locale == "it_IT" ? "Testo dell\'annuncio" : locale == "en_US"  ? "Ad description" : "Descripción del anuncio"),
              Text(
                controller.controllerDescription.text,
                style: ThemeConfig.bodyText1,
              ),
              SizedBox(
                height: 20,
              ),
              TitlePrincipalAds("adtype_ad".tr),
              Text(
                controller.currentAdTypeStr.tr,
                style: ThemeConfig.bodyText1,
              ),
              SizedBox(
                height: 20,
              ),
              TitlePrincipalAds(locale == "it_IT" ? "Telefono" : locale == "en_US"  ? "Phone number" : "Número telefónico" ,),
              Text(
                controller.controllerPhone.text,
                style: ThemeConfig.bodyText1,
              ),
              SizedBox(
                height: 20,
              ),
              TitlePrincipalAds('peopletype_ad'.tr),
              Text(
                controller.currenPeopleTypeStr.tr,
                style: ThemeConfig.bodyText1,
              ),
              SizedBox(
                height: 20,
              ),
              TitlePrincipalAds(locale == "it_IT" ? "Comune" : locale == "en_US"  ? "Location" : "Ubicación" ,),
              Text(
                controller.city,
                style: ThemeConfig.bodyText1,
              ),
              SizedBox(
                height: 20,
              ),
              TitlePrincipalAds(locale == "it_IT" ? "Prezzo" : locale == "en_US"  ? "Price" : "Precio" ,),
              Text(
                controller.controllerPrice.text + ' ' + 'coin'.tr,
                style: ThemeConfig.bodyText1,
              ),
              SizedBox(
                height: 20,
              ),
              if (controller.publishAdModel.value.currentCategory ==
                  EnumCategoryList.furniture)
                TitlePrincipalAds(locale == "it_IT" ? "Condizione" : locale == "en_US"  ? "Condition" : "Condición" ,),
              if (controller.publishAdModel.value.currentCategory ==
                  EnumCategoryList.furniture)
                Text(
                  controller.currentCondizioneStr.tr,
                  style: ThemeConfig.bodyText1,
                ),
              if (controller.publishAdModel.value.currentCategory ==
                  EnumCategoryList.furniture)
                SizedBox(
                  height: 20,
                ),
              TitlePrincipalAds( locale== "it_IT" ? "Immagini" : locale== "en_US"  ? "Images" : "Imágenes" , ),
              SelectImage()
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                  child: Container(
                    height: 50,
                    width: SizeConfig().screenWidth * .45,
                    child: ButtonNotFilledSecundary(locale== "it_IT" ? "Indietro" : locale== "en_US"  ? "Go back" : "Volver" ,),
                  ),
                  onTap: () {
                    controller.backStep('back');
                  }),
              InkWell(
                child: Container(
                  height: 50,
                  width: SizeConfig().screenWidth * .45,
                  child: ButtonSecundary(locale== "it_IT" ? "Postare" : locale== "en_US"  ? "Publish" : "Publicar" , ),
                ),
                onTap: () {
                  controller.postAd(context);
                },
              )
            ],
          ),
        ),
      ],
    ));
  }
}
