import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:horecah/lang/translation_service.dart';
import 'package:horecah/modules/publish_ad/publish_ad_controller.dart';
import 'package:horecah/modules/publish_ad/widgets/dropdown_button_form.dart';
import 'package:horecah/modules/publish_ad/widgets/dropdown_google_places.dart';
import 'package:horecah/modules/publish_ad/widgets/publish_ad_app_bar.dart';
import 'package:horecah/routes/routes.dart';
import 'package:horecah/shared/shared.dart';
import 'package:horecah/theme/theme_data.dart';

class PublishAdStepTwoScreen extends StatefulWidget {
  @override
  _PublishAdStepTwoScreenState createState() => _PublishAdStepTwoScreenState();
}

class _PublishAdStepTwoScreenState extends State<PublishAdStepTwoScreen> {
  var controller = Get.find<PublishAdController>();
  final ScrollController _scrollController = new ScrollController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool hidePhoneNumber = false;
  
 

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
  
    print("subCatStr ${controller.currentSubCatStr}");
  }

  Widget build(BuildContext context) {
    String locale = TranslationService.locale.toString();
    return PublishAdAppBar(
        body: Stack(
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 60),
          child: Form(
            key: formKey,
            child: ListView(
              controller: _scrollController,
              children: [
                TitlePrincipalAds( locale == "it_IT" ? "Titolo dell\'annuncio" : locale == "en_US"  ? "Ad title" : "Título del anuncio" ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                  child: TextFormField(
                    controller: controller.controllerTitle,
                    validator: (val) {
                      if (val!.isEmpty) {
                        _scrollController.animateTo(
                          0.0,
                          curve: Curves.easeOut,
                          duration: const Duration(milliseconds: 300),
                        );
                        return 'This field is required';
                      }
                      if (val.length < 5) {
                        _scrollController.animateTo(
                          0.0,
                          curve: Curves.easeOut,
                          duration: const Duration(milliseconds: 300),
                        );
                        return 'Requires at least 5 characters.';
                      }
                      return null;
                    },
                    style: ThemeConfig.bodyText1.override(
                      color: Color(0xFF3C4858),
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                    decoration: InputDecoration(
                      labelText: locale == "it_IT" ? "Scrivi un titolo per il tuo annuncio." : locale == "en_US"  ? "Write a title for your ad." : "Escriba un título para el anuncio." ,
                        labelStyle: ThemeConfig.bodyText1.override(
                          color: Color(0xFFB4B4B4),
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                        border: OutlineInputBorder(),
                        isDense: true,
                        errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 0.7)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFFB4B4B4), width: 0.7))),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TitlePrincipalAds(locale == "it_IT" ? "Testo dell\'annuncio" : locale == "en_US"  ? "Ad description" : "Descripción del anuncio"),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                  child: TextFormField(
                    controller: controller.controllerDescription,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'This field is required';
                      }
                      if (val.length < 5) {
                        return 'Requires at least 5 characters.';
                      }
                      return null;
                    },
                    maxLines: 5,
                    minLines: 5,
                    style: ThemeConfig.bodyText1.override(
                      color: Color(0xFF3C4858),
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                    decoration: InputDecoration(
                        labelStyle: ThemeConfig.bodyText1.override(
                          color: Color(0xFFB4B4B4),
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelText:
                            locale == "it_IT" ? "Scrivi una descrizione \ndel tuo annuncio, ricorda che non \ndeve contenere spam o nessun \nindirizzo email" : locale == "en_US"  ? "Write a description for your ad, remember that it must not contain spam or any email addresses" : "Escriba una descripción para su anuncio, recuerde que no debe contener spam ni ninguna dirección de correo electrónico" ,
                        border: OutlineInputBorder(),
                        isDense: true,
                        errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 0.7)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFFB4B4B4), width: 0.7))),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TitlePrincipalAds('peopletype_ad'.tr),
                      DropDownButtonFormPeopleType(
                        listOptions: controller.getListPeopleType(),
                        actualValue: controller.getListPeopleType()[0],
                        type: EnumTypeList.typePerson,
                      ),
                SizedBox(
                  height: 20,
                ),
                TitlePrincipalAds(locale == "it_IT" ? "Comune" : locale == "en_US"  ? "Location" : "Ubicación" ,),
                DropDownGooglePlaces(),
                SizedBox(
                  height: 20,
                ),
                TitlePrincipalAds(locale == "it_IT" ? "Prezzo" : locale == "en_US"  ? "Price" : "Precio" ,),
                TextFormField(
                  controller: controller.controllerPrice,
                  keyboardType: TextInputType.number,
                  validator: (val) {
                    if (val!.isEmpty) {
                      _scrollController.animateTo(
                        SizeConfig().screenHeight,
                        curve: Curves.easeOut,
                        duration: const Duration(milliseconds: 300),
                      );
                      return 'This field is required';
                    }
                    if (val.length < 1) {
                      _scrollController.animateTo(
                        SizeConfig().screenHeight,
                        curve: Curves.easeOut,
                        duration: const Duration(milliseconds: 300),
                      );
                      return 'Requires at least 1 characters.';
                    }
                    return null;
                  },
                  style: ThemeConfig.bodyText1.override(
                    color: Color(0xFF3C4858),
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                  decoration: InputDecoration(
                      labelText: 'coin'.tr,
                      labelStyle: ThemeConfig.bodyText1.override(
                        color: Color(0xFFB4B4B4),
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                      border: OutlineInputBorder(),
                      isDense: true,
                      errorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.red, width: 0.7)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xFFB4B4B4), width: 0.7))),
                ),
                if (controller.publishAdModel.value.currentCategory ==
                    EnumCategoryList.furniture)
                  SizedBox(
                    height: 20,
                  ),
                if (controller.publishAdModel.value.currentCategory ==
                    EnumCategoryList.furniture)
                  TitlePrincipalAds(locale == "it_IT" ? "Condizione" : locale == "en_US"  ? "Condition" : "Condición" ,),
                if (controller.publishAdModel.value.currentCategory ==
                    EnumCategoryList.furniture)
                  DropDownButtonFormCondizione(
                    listOptions: controller.getListCondition(),
                    actualValue: controller.getListCondition()[0],
                    type: EnumTypeList.statusProduct,
                  ),
                SizedBox(
                  height: 20,
                ),
                TitlePrincipalAds(locale == "it_IT" ? "Telefono" : locale == "en_US"  ? "Phone number" : "Número telefónico" ,),
                TextFormField(
                  controller: controller.controllerPhone,
                  keyboardType: TextInputType.phone,
                  enabled: !hidePhoneNumber,
                  maxLength: 12,
                  validator: (val) {
                    if (!hidePhoneNumber) {
                      if (val!.isEmpty) {
                        _scrollController.animateTo(
                          SizeConfig().screenHeight,
                          curve: Curves.easeOut,
                          duration: const Duration(milliseconds: 300),
                        );
                        return 'This field is required';
                      }
                      if (val.length < 1) {
                        _scrollController.animateTo(
                          SizeConfig().screenHeight,
                          curve: Curves.easeOut,
                          duration: const Duration(milliseconds: 300),
                        );
                        return 'Requires at least 1 characters.';
                      }
                    }
                    return null;
                  },
                  style: ThemeConfig.bodyText1.override(
                    color: Color(0xFF3C4858),
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                  decoration: InputDecoration(
                      labelText: !hidePhoneNumber
                          ? locale == "it_IT" ? "Scrivi il tuo telefono" : locale == "en_US"  ? "Type your phone number" : "Escriba su teléfono"
                          : locale == "it_IT" ? "Devi mostrare il tuo telefono" : locale == "en_US"  ? "You should show your phone number" : "Debe mostrar su teléfono",
                      labelStyle: ThemeConfig.bodyText1.override(
                        color: Color(0xFFB4B4B4),
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                      border: OutlineInputBorder(),
                      isDense: true,
                      errorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.red, width: 0.7)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xFFB4B4B4), width: 0.7))),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      locale == "it_IT" ? "Nascondi telefono" : locale == "en_US"  ? "Hide phone number" : "Ocultar teléfono",
                      textAlign: TextAlign.left,
                      textScaleFactor: 1,
                      style: ThemeConfig.bodyText1.override(
                        color: ColorConstants.titlePrincipal,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Switch(
                      value: hidePhoneNumber,
                      onChanged: (value) {
                        setState(() {
                          hidePhoneNumber = value;
                          print(hidePhoneNumber);
                        });
                      },
                      activeTrackColor: ColorConstants.secondaryAppColor,
                      activeColor: ColorConstants.principalColor,
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
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
                    child: ButtonNotFilledSecundary( locale== "it_IT" ? "Indietro" : locale== "en_US"  ? "Go back" : "Volver" , ),
                  ),
                  onTap: () {
                    controller
                        .backStep(Routes.HOME + Routes.CREATE_AD_STEP_ONE);
                  }),
              InkWell(
                  child: Container(
                    height: 50,
                    width: SizeConfig().screenWidth * .45,
                    child: ButtonSecundary(locale == "it_IT" ? "Avanti" : locale == "en_US"  ? "Continue" : "Continuar",),
                  ),
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      if (controller.city != '') {
                        if (controller.publishAdModel.value.currentCategory ==
                            EnumCategoryList.furniture) {
                          if (controller.statusProduct != '' &&
                              controller.statusProduct != 'Selezionare:') {
                            controller.nexStep(
                                Routes.HOME + Routes.CREATE_AD_STEP_THREE);
                          } else {
                            CommonWidget.showError(
                                 locale == "it_IT" ? "La Condizione deve essere specificata." : locale == "en_US"  ? "The condition need to be specified." : "La condición debe ser especificada." ,  );
                          }
                        } else {
                          controller.nexStep(
                              Routes.HOME + Routes.CREATE_AD_STEP_THREE);
                        }
                      } else {
                        _scrollController.animateTo(
                          SizeConfig().screenHeight - 100,
                          curve: Curves.easeOut,
                          duration: const Duration(milliseconds: 300),
                        );
                        CommonWidget.showError(
                           locale == "it_IT" ? "La Comune deve essere specificata." : locale == "en_US"  ? "The location need to be specified." : "La ubicación debe ser especificada."  );
                      }
                    }
                  })
            ],
          ),
        ),
      ],
    ));
  }
}
