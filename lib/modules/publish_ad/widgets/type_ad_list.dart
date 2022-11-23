import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horecah/lang/translation_service.dart';
import 'package:horecah/modules/publish_ad/publish_ad_controller.dart';
import 'package:horecah/routes/app_pages.dart';
import 'package:horecah/shared/catalogs/list_enums.dart';
import 'package:horecah/shared/shared.dart';
import 'package:horecah/theme/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TypeAdList extends GetView<PublishAdController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: CommonWidget.getScreenSizeFontFixed(
      Container(
        child: new Wrap(children: itemsForTypeCategory()),
      ),
    ));
  }

  List<Widget> itemsForTypeCategory() {
    String locale = TranslationService.locale.toString();
    return [
      Container(
        height: 40,
        color: controller.currentCat.value.color,
        child: Center(
            child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
          locale == "it_IT" ? "PUBBLICA IN  ${ controller.currentCat.value.nameIt } " : locale == "en_US"  ? "PUBLISH IN ${ controller.currentCat.value.nameEn }" : "PUBLICAR EN ${ controller.currentCat.value.nameEs }",
              style: ThemeConfig.title1.override(
                color: Colors.white,
                fontSize: 18.sp
              ),
            ),
          ),
        )),
      ),
      if (controller.validateSellBuy())
        ListTile(
            leading: new Icon(Icons.sell, size: 25),
            title: new Text('sell'.tr,
                style: ThemeConfig.subtitle1.override(
                  color: Colors.black,
                )),
            onTap: () async {
              controller.setTypeAdcategory(EnumTypeAdList.sell);
              //CARGAR SUBCATEGORIAS============================
              final subCategoriesOptions = await controller.getSubCategoriesByCategory();
              controller.nexStep(Routes.HOME + Routes.CREATE_AD_STEP_ONE, options: subCategoriesOptions   );
            }),
      if (controller.validateSellBuy())
        ListTile(
            leading: new Icon(Icons.attach_money, size: 25),
            title: new Text('buy'.tr,
                style: ThemeConfig.subtitle1.override(
                  color: Colors.black,
                )),
            onTap: () async {
              //CARGAR SUBCATEGORIAS============================
              controller.setTypeAdcategory(EnumTypeAdList.buy);
               final subCategoriesOptions = await controller.getSubCategoriesByCategory();
              controller.nexStep(Routes.HOME + Routes.CREATE_AD_STEP_ONE, options: subCategoriesOptions   );
            }),
      if (controller.validateRent())
        ListTile(
            leading: new Icon(Icons.add_business_sharp, size: 25),
            title: new Text('rent2'.tr,
                style: ThemeConfig.subtitle1.override(
                  color: Colors.black,
                )),
            onTap: () async {
              //CARGAR SUBCATEGORIAS============================
              controller.setTypeAdcategory(EnumTypeAdList.rent);
               final subCategoriesOptions = await controller.getSubCategoriesByCategory();
              controller.nexStep(Routes.HOME + Routes.CREATE_AD_STEP_ONE, options: subCategoriesOptions   );
            }),
      if (controller.validateRent2())
        ListTile(
            leading: new Icon(Icons.add_business_sharp, size: 25),
            title: new Text('rent'.tr,
                style: ThemeConfig.subtitle1.override(
                  color: Colors.black,
                )),
            onTap: () async {
              //CARGAR SUBCATEGORIAS============================
              controller.setTypeAdcategory(EnumTypeAdList.rent2);
              final subCategoriesOptions = await controller.getSubCategoriesByCategory();
              controller.nexStep(Routes.HOME + Routes.CREATE_AD_STEP_ONE, options: subCategoriesOptions   );
            }),
      if (controller.validateFurniture())
        ListTile(
            leading: new Icon(Icons.local_shipping, size: 25),
            title: new Text(   locale == "it_IT" ? "Sono Fornitore" : locale == "en_US"  ? "I am a supplier" : "Soy proveedor",
                style: ThemeConfig.subtitle1.override(
                  color: Colors.black,
                )),
            onTap: () async {
              //CARGAR SUBCATEGORIAS============================
              controller.setTypeAdcategory(EnumTypeAdList.supplier);
              final subCategoriesOptions = await controller.getSubCategoriesByCategory();
              controller.nexStep(Routes.HOME + Routes.CREATE_AD_STEP_ONE, options: subCategoriesOptions   );
            }),
      if (controller.validateFurniture())
        ListTile(
            leading: new Icon(Icons.search, size: 25),
            title: new Text(locale == "it_IT" ? "Cerco Fornitore" : locale == "en_US"  ? "Searching a supplier" : "Busco proveedor",
                style: ThemeConfig.subtitle1.override(
                  color: Colors.black,
                )),
            onTap: () async {
              //CARGAR SUBCATEGORIAS============================
              controller.setTypeAdcategory(EnumTypeAdList.search_supplier);
               final subCategoriesOptions = await controller.getSubCategoriesByCategory();
              controller.nexStep(Routes.HOME + Routes.CREATE_AD_STEP_ONE, options: subCategoriesOptions   );
            }),
      if (controller.validateConsultant())
        ListTile(
            leading: new Icon(Icons.business_center, size: 25),
            title: new Text(locale == "it_IT" ? "Sono Consigliere" : locale == "en_US"  ? "I am an adviser" : "Soy asesor",
                style: ThemeConfig.subtitle1.override(
                  color: Colors.black,
                )),
            onTap: () async {
              //CARGAR SUBCATEGORIAS============================
              controller.setTypeAdcategory(EnumTypeAdList.consultant);
               final subCategoriesOptions = await controller.getSubCategoriesByCategory();
              controller.nexStep(Routes.HOME + Routes.CREATE_AD_STEP_ONE, options: subCategoriesOptions   );
            }),
      if (controller.validateConsultant())
        ListTile(
            leading: new Icon(Icons.search, size: 25),
            title: new Text(locale == "it_IT" ? "Cerco Consigliere" : locale == "en_US"  ? "Searching an adviser" : "Busco asesor",
                style: ThemeConfig.subtitle1.override(
                  color: Colors.black,
                )),
            onTap: () async {
              //CARGAR SUBCATEGORIAS============================
              controller.setTypeAdcategory(EnumTypeAdList.search_consultant);
               final subCategoriesOptions = await controller.getSubCategoriesByCategory();
              controller.nexStep(Routes.HOME + Routes.CREATE_AD_STEP_ONE, options: subCategoriesOptions   );
            }),
      if (controller.validateEntrepreneur())
        ListTile(
            leading: new Icon(Icons.monetization_on, size: 25),
            title: new Text(locale == "it_IT" ? "Sono Imprenditore" : locale == "en_US"  ? "I am entrepreneur" : "Soy emprendedor",
                style: ThemeConfig.subtitle1.override(
                  color: Colors.black,
                )),
            onTap: () async {
              //CARGAR SUBCATEGORIAS============================
              controller.setTypeAdcategory(EnumTypeAdList.entrepreneur);
              final subCategoriesOptions = await controller.getSubCategoriesByCategory();
              controller.nexStep(Routes.HOME + Routes.CREATE_AD_STEP_ONE, options: subCategoriesOptions   );
            }),
      if (controller.validateEntrepreneur())
        ListTile(
            leading: new Icon(Icons.search, size: 25),
            title: new Text(locale == "it_IT" ? "Cerco Imprenditore" : locale == "en_US"  ? "Searching an entrepreneur" : "Busco emprendedor",
                style: ThemeConfig.subtitle1.override(
                  color: Colors.black,
                )),
            onTap: ()  async{
              //CARGAR SUBCATEGORIAS============================
              controller.setTypeAdcategory(EnumTypeAdList.search_entrepreneur);
               final subCategoriesOptions = await controller.getSubCategoriesByCategory();
              controller.nexStep(Routes.HOME + Routes.CREATE_AD_STEP_ONE, options: subCategoriesOptions   );
            }),
    ];
  }
}
