import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horecah/lang/translation_service.dart';
import 'package:horecah/models/subcategory.dart';
import 'package:horecah/modules/home/home_controller.dart';
import 'package:horecah/modules/publish_ad/widgets/dropdown_button_form.dart';
import 'package:horecah/modules/publish_ad/widgets/dropdown_google_places.dart';
import 'package:horecah/modules/publish_ad/widgets/postAd.dart';
import 'package:horecah/modules/publish_ad/widgets/postAdFiltersProducts.dart';
import 'package:horecah/modules/registry/widgets/custom_radio_button.dart';
import 'package:horecah/shared/constants/colors.dart';
import 'package:horecah/shared/shared.dart';
import 'package:horecah/theme/theme.dart';
import 'publish_ad.dart';

class ListAdScreen extends GetView<PublishAdController> {
  bool? conCategoria = true;
  Category cat = Category();
  ListAdScreen({this.conCategoria});

  @override
  Widget build(BuildContext context) {
    String locale = TranslationService.locale.toString();

    return WillPopScope(
      onWillPop: () async {
        final homeController = Get.find<HomeController>();
        controller.currentCat.value = Category();

        controller.currentCatStr = "";
        controller.setCategory(EnumCategoryList.none);
        controller.getPostAdHome().then((value) {
          controller.controllerSearch.clear();
          homeController.switchTab(0);
        });
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      InkWell(
                          child: Icon(
                            Icons.arrow_back,
                            color: ColorConstants.darkGray,
                            size: 26,
                          ),
                          onTap: () {
                            controller.currentCatStr = "";
                            controller.currentCat.value = Category();
                            controller.setCategory(EnumCategoryList.none);
                            controller.getPostAdHome().then((value) {
                              controller.controllerSearch.clear();
                              Get.back();
                            });
                          }),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Card(
                          color: Colors.white,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.search,
                                color: ColorConstants.darkGray,
                                size: 26,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: TextFormField(
                                    controller: controller.controllerSearch,
                                    style: ThemeConfig.bodyText1.override(
                                      color: Color(0xFF3C4858),
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    decoration: InputDecoration(
                                        labelText: 'search_anything'.tr,
                                        alignLabelWithHint: true,
                                        labelStyle:
                                            ThemeConfig.bodyText1.override(
                                          color: Color(0xFFB4B4B4),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w300,
                                        ),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.never,
                                        border: InputBorder.none,
                                        isDense: true),
                                    onChanged: (text) {
                                      if (text.length > 2) {
                                        controller.getPostAdFilter();
                                      } else if (text.length == 0) {
                                        controller.getPostAdToFilterScreen();
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Spacer(),
                      InkWell(
                        child: Container(
                            width: 130,
                            child: Obx(() =>
                                controller.currentCat.value.id == null
                                    ? ButtonSecundary('filter'.tr,
                                        color: Colors.red)
                                    : ButtonSecundary(
                                        'filter'.tr +
                                            ' ' +
                                            (locale == "it_IT"
                                                ? controller
                                                    .currentCat.value.nameIt!
                                                : locale == "en_US"
                                                    ? controller.currentCat
                                                        .value.nameEn!
                                                    : controller.currentCat
                                                        .value.nameEs!),
                                        color: Colors.red))),
                        onTap: () async {
                          //TODO: CONSULTAR SUBCATEGORIAS.
                          if (this.conCategoria == false) {
                            await showCategories(context);
                          } else {
                            final subCategoriesFilters =
                                await controller.getSubCategoriesByCategory();
                            print("Done!!!");
                            print(subCategoriesFilters);
                            showFullModalInfo(context, subCategoriesFilters);
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(children: [
                    PostAdFilterProducts(
                        color: controller.currentCat.value.color == null
                            ? ColorConstants.principalColor
                            : controller.currentCat.value.color!),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showCategories(BuildContext context) {
    print("from showCategories ${controller.currentCatStr}");

    return showModalBottomSheet(
        context: context,
        builder: (ctx) {
          String locale = TranslationService.locale.toString();
          return Column(
            children: [
              SizedBox(
                height: 15,
              ),
              TitlePrincipalAds(locale == "it_IT"
                  ? 'Seleziona una categoria'
                  : locale == "en_US"
                      ? "Select a category"
                      : "Selecciona una categoría"),
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: controller.allCategoriesFilter.length,
                    itemBuilder: (BuildContext context, int index) {
                      Category category = controller.allCategoriesFilter[index];
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ListTile(
                          onTap: () async {
                            controller.currentCat.value = category;
                            print('category.toJson() -*-*-*-*-*-*');
                            print(category.toJson());
                            controller.currentCatStr = category.nameEs!;
                            this.controller.currentCat.refresh();
                            Navigator.pop(context);
                            final subCategoriesFilters =
                                await controller.getSubCategoriesByCategory();

                            showFullModalInfo(context, subCategoriesFilters);
                          },
                          leading: CircleAvatar(
                            backgroundColor: category.color,
                            child: Icon(category.icon, color: Colors.white),
                          ),
                          title: Text(locale == "it_IT"
                              ? category.nameIt!
                              : locale == "en_US"
                                  ? category.nameEn!
                                  : category.nameEs!),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          );
        });
  }

  Future<void> showFullModalInfo(
      BuildContext context, List<String> subCategoriesFilters) async {
    final controller = Get.find<PublishAdController>();
    String lang = TranslationService.locale.toString();

    controller.setCurrentPeopleType();

    controller.setCurrentAdType();

    print(
        "currentPeopleType from showfullModal ${controller.currenPeopleTypeStr} ");
    print("currentAdType from showFullModal ${controller.currentAdTypeStr}");

    await Get.dialog(
      WillPopScope(
        onWillPop: () async {
          controller.currentSubCatStr = "";
          controller.currenPeopleTypeStr = "";
          controller.currentAdTypeStr = "";
          controller.controllerPrice.text = "";
          controller.controllerPriceMax.text = "";

          print("Back!!");
          return true;
        },
        child: AlertDialog(
            title: Text('filter'.tr,
                textScaleFactor: 1,
                style: ThemeConfig.title2.override(
                    color: ColorConstants.principalColor,
                    fontWeight: FontWeight.bold)),
            insetPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            content: Container(
              height: SizeConfig().screenHeight,
              width: SizeConfig().screenWidth,
              child: Stack(children: [
                Container(
                  padding: EdgeInsets.only(bottom: 60),
                  child: ListView(
                    children: [
                      TitlePrincipalAds('write_anything'.tr),
                      TextFormField(
                        controller: controller.controllerSearch,
                        keyboardType: TextInputType.text,
                        style: ThemeConfig.bodyText1.override(
                          color: Color(0xFF3C4858),
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                        decoration: InputDecoration(
                            labelText: 'write_anything'.tr,
                            labelStyle: ThemeConfig.bodyText1.override(
                              color: Color(0xFFB4B4B4),
                              fontSize: 14,
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
                      TitlePrincipalAds("adtype_ad".tr),

                      DropDownButtonFormAdType(
                        listOptions: controller.getListAdType(),
                        actualValue: controller.getListAdType()[0],
                        type: EnumTypeList.typePerson,
                      ),

                      /* RadioButtonForm(
                        options: controller.getTypeAdList(),
                        onChanged: (value) {
                          controller.setTypeAdcategory(
                              getEnumTypeAdFromString(value!),
                              next: false);
                        },
                        defaultOption: controller.getActualTypeAd(),
                        optionHeight: 25,
                        textStyle: ThemeConfig.bodyText1
                            .override(color: Colors.black, fontSize: 13),
                        buttonPosition: RadioButtonPosition.left,
                        direction:
                            controller.publishAdModel.value.currentCategory ==
                                        EnumCategoryList.supplier ||
                                    controller.publishAdModel.value
                                            .currentCategory ==
                                        EnumCategoryList.consultant ||
                                    controller.publishAdModel.value
                                            .currentCategory ==
                                        EnumCategoryList.entrepreneur
                                ? Axis.vertical
                                : Axis.horizontal,
                        radioButtonColor:
                            controller.currentCat.value.color == null
                                ? ColorConstants.principalColor
                                : controller.currentCat.value.color!,
                        inactiveRadioButtonColor: Color(0x8A000000),
                        toggleable: false,
                        horizontalAlignment: WrapAlignment.spaceBetween,
                        verticalAlignment: WrapCrossAlignment.start,
                      ),*/
                      SizedBox(
                        height: 20,
                      ),
                      TitlePrincipalAds('subcategory_ad'.tr),
                      DropDownButtonForm(
                        listOptions: subCategoriesFilters,
                        actualValue: subCategoriesFilters.isNotEmpty
                            ? subCategoriesFilters[0]
                            : "Selezionare: ",
                        type: EnumTypeList.subCategory,
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
                      if (controller.publishAdModel.value.currentCategory ==
                          EnumCategoryList.furniture)
                        TitlePrincipalAds('condition_ad'.tr),
                      if (controller.publishAdModel.value.currentCategory ==
                          EnumCategoryList.furniture)
                        /* DropDownButtonForm(
                          listOptions: [
                            'Selezionare:',
                            'Nuovo (mai usato)',
                            'Come nuovo (poco usato)',
                            'Buono (normale uso)',
                            'Usurato (ma funzionante)',
                            'Danneggiato (da riparare)'
                          ],
                          actualValue: controller.statusProduct,
                          type: EnumTypeList.statusProduct,
                        ),*/
                        SizedBox(
                          height: 20,
                        ),
                      // TitlePrincipalAds('Comune'),
                      // DropDownGooglePlaces(),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      TitlePrincipalAds('money_range'.tr),
                      Row(
                        children: [
                          Flexible(
                            child: TextFormField(
                              controller: controller.controllerPrice,
                              keyboardType: TextInputType.number,
                              style: ThemeConfig.bodyText1.override(
                                color: Color(0xFF3C4858),
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                              decoration: InputDecoration(
                                  labelText: '0 ' + 'coin'.tr,
                                  labelStyle: ThemeConfig.bodyText1.override(
                                    color: Color(0xFFB4B4B4),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  border: OutlineInputBorder(),
                                  isDense: true,
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 0.7)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFB4B4B4),
                                          width: 0.7))),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Flexible(
                            child: TextFormField(
                              controller: controller.controllerPriceMax,
                              keyboardType: TextInputType.number,
                              style: ThemeConfig.bodyText1.override(
                                color: Color(0xFF3C4858),
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                              decoration: InputDecoration(
                                  labelText: '100 ' + 'coin'.tr,
                                  labelStyle: ThemeConfig.bodyText1.override(
                                    color: Color(0xFFB4B4B4),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  border: OutlineInputBorder(),
                                  isDense: true,
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 0.7)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFB4B4B4),
                                          width: 0.7))),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                      child: Container(
                        height: 50,
                        child: ButtonSecundary('apply'.tr,
                            color: controller.currentCat.value.color),
                      ),
                      onTap: () {
                        Get.back();
                        controller.getPostAdFilter().then((value) {
                          AppFocus.unfocus(context);
                        });
                      }),
                )
              ]),
            )),
      ),
      barrierDismissible: true,
    );
  }
}
