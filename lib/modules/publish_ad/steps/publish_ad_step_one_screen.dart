import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:horecah/lang/translation_service.dart';
import 'package:horecah/modules/publish_ad/publish_ad_controller.dart';
import 'package:horecah/modules/publish_ad/widgets/dropdown_button_form.dart';
import 'package:horecah/modules/publish_ad/widgets/publish_ad_app_bar.dart';
import 'package:horecah/modules/publish_ad/widgets/select_image.dart';
import 'package:horecah/modules/registry/widgets/custom_radio_button.dart';
import 'package:horecah/routes/routes.dart';
import 'package:horecah/shared/constants/colors.dart';
import 'package:horecah/shared/shared.dart';
import 'package:horecah/theme/theme_data.dart';

class PublishAdStepOneScreen extends GetView<PublishAdController> {
  String lang = TranslationService.locale.toString();

  @override
  Widget build(BuildContext context) {
    return PublishAdAppBar(
      body: _bodyBuilder(Get.arguments == null
          ? [
              "Sottocategoria 1",
              "Sottocategoria 2",
              "Sottocategoria 3",
              "Sottocategoria 4"
            ]
          : Get.arguments),
    );
  }

  _bodyBuilder(
    List<String> subCategories,
  ) {
    print( "CurrentCatStr from Step 1 ${controller.currentCatStr} ${controller.getActualTypeAd()}" );

    List<String>? defaultList = [
      "Sottocategoria 1",
      "Sottocategoria 2",
      "Sottocategoria 3",
      "Sottocategoria 4"
    ];

   /* //=======================PEOPLETYPE===============================
    List<String> itListPeopleType = ['Privato', 'Partita IVA', 'Azienda'];
    List<String> enListPeopleType = ["Private", "IVA", "Agency"];
    List<String> esListPeopleType = ["Privado", "IVA", "Agencia"];

    //=======================ADTYPE===================================
    List<String> buyListIt = ['Vendo', 'Compro', 'Affitto'];
    List<String> proveedorListIt = [
      'Sono un Fornitore',
      'Cerco un Fornitore',
    ];
    List<String> asesorListIt = [
      'Sono un Consulente',
      'Cerco un Consulente',
    ];
    List<String> emprendedorListIt = [
      'Sono un Imprenditore',
      'Cerco un Imprenditore',
    ];

    List<String> buyListEn = ['Sell', 'Buy', 'Rent'];
    List<String> proveedorListEn = [
      'I am a supplier',
      'Searching a supplier',
    ];
    List<String> asesorListEn = [
      'I am an adviser',
      'Searching an adviser',
    ];
    List<String> emprendedorListEn = [
      'I am entrepreneur',
      'Searching an entrepreneur',
    ];

    List<String> buyListEs = ['Vendo', 'Compro', 'Rento'];
    List<String> proveedorListEs = [
      'Soy proveedor',
      'Busco proveedor',
    ];
    List<String> asesorListEs = [
      'Soy asesor',
      'Busco asesor',
    ];
    List<String> emprendedorListEs = [
      'Soy emprendedor',
      'Busco emprendedor',
    ];*/
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 60),
          child: ListView(
            children: [
               TitlePrincipalAds('adtype_ad'.tr),

                        DropDownButtonFormAdType(
                          listOptions: controller.getListAdType(),
                          actualValue: controller.getActualTypeAd(),
                          type: EnumTypeList.typePerson,
                        ),
              /*RadioButtonForm(
                options: controller.getTypeAdList(),
                onChanged: (value) {
                  controller.setTypeAdcategory(getEnumTypeAdFromString(value!),
                      next: false);
                },
                defaultOption: controller.getActualTypeAd(),
                optionHeight: 25,
                textStyle: ThemeConfig.bodyText1
                    .override(color: Colors.black, fontSize: 13),
                buttonPosition: RadioButtonPosition.left,
                direction: controller.publishAdModel.value.currentCategory ==
                            EnumCategoryList.supplier ||
                        controller.publishAdModel.value.currentCategory ==
                            EnumCategoryList.consultant ||
                        controller.publishAdModel.value.currentCategory ==
                            EnumCategoryList.entrepreneur
                    ? Axis.vertical
                    : Axis.horizontal,
                radioButtonColor: ColorConstants.principalColor,
                inactiveRadioButtonColor: Color(0x8A000000),
                toggleable: false,
                horizontalAlignment: WrapAlignment.spaceBetween,
                verticalAlignment: WrapCrossAlignment.start,
              ),*/
              SizedBox(
                height: 20,
              ),
              TitlePrincipalAds( lang == "it_IT" ? "Sottocategoria" : lang == "en_US"  ? "Subcategory" : "Subcategoría" , ),
              DropDownButtonForm(
                listOptions: subCategories.isEmpty
                    ? [
                        "Sottocategoria 1",
                        "Sottocategoria 2",
                        "Sottocategoria 3",
                        "Sottocategoria 4"
                      ]
                    : subCategories,
                actualValue: subCategories.isNotEmpty
                    ? subCategories[0]
                    : defaultList[0],
                type: EnumTypeList.subCategory,
              ),
              SizedBox(
                height: 20,
              ),
              TitlePrincipalAds(lang== "it_IT" ? "Immagini" : lang== "en_US"  ? "Images" : "Imágenes" ,),
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
                    child: ButtonNotFilledSecundary(lang== "it_IT" ? "Indietro" : lang== "en_US"  ? "Go back" : "Volver" ,),
                  ),
                  onTap: () {
                    CommonWidget.showModalInfo(
                            lang== "it_IT" ? "Sei sicuro di volver abbandonare I\'inserimento" : lang== "en_US"  ? "Are you sure you want to leave the post?" : "¿Estás seguro de que quieres dejar la publicación?" ,
                            hasCancel: true)
                        .then((onOK) {
                      if (onOK) {
                        controller.cleanControllers();
                        Get.toNamed(Routes.HOME);
                      }
                    });
                  }),
              InkWell(
                  child: Container(
                    height: 50,
                    width: SizeConfig().screenWidth * .45,
                    child: ButtonSecundary( lang== "it_IT" ? "Avanti" : lang== "en_US"  ? "Continue" : "Continuar" , ),
                  ),
                  onTap: () {
                    var imageEmpty = controller.imagesToUpload.where((element)=>element.path == "");
                    print("Yair: "+imageEmpty.length.toString());
                    if(controller.currentSubCatStr != 'Select'.tr){
                      if (imageEmpty.length > 0) {
                        controller
                            .nexStep(Routes.HOME + Routes.CREATE_AD_STEP_TWO);
                      } else {
                        CommonWidget.showError(lang== "it_IT" ? "Seleziona una immagini" : lang== "en_US"  ? "Select an image" : "Selecciona una imágen" ,);
                      }
                    }else{
                      CommonWidget.showError(lang== "it_IT" ? "Seleziona una Sottocategoria" : lang== "en_US"  ? "Select a Subcategory" : "Selecciona una Subcategoría" ,);
                    }
                  })
            ],
          ),
        ),
      ],
    );
  }
}
