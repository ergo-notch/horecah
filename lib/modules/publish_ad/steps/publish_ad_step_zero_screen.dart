import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horecah/lang/translation_service.dart';
import 'package:horecah/models/subcategory.dart';
import 'package:horecah/modules/home/home.dart';
import 'package:horecah/modules/publish_ad/widgets/type_ad_list.dart';
import 'package:horecah/shared/catalogs/list_enums.dart';
import 'package:horecah/shared/constants/colors.dart';
import 'package:horecah/shared/shared.dart';
import 'package:horecah/shared/widgets/custom_widgets.dart';
import 'package:horecah/theme/theme.dart';
import '../publish_ad_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PublishAdStepZeroScreen extends GetView<PublishAdController> {
  @override
  Widget build(BuildContext context) {
    var homeController = Get.find<HomeController>();
    Get.lazyPut<PublishAdController>(() => PublishAdController(
        apiRepository: Get.find(), userStrapi: homeController.userStrapi));

    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'create_ad_titie_create_ad'.tr,
                          textAlign: TextAlign.center,
                          textScaleFactor: 1,
                          style: ThemeConfig.bodyText1.override(
                            color: ColorConstants.principalColor,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        )))
              ],
            )),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          child: Container(
            width: Get.width,
            height: 100.h,
            //color: Colors.red,
            child: Padding(
             padding: const EdgeInsets.symmetric( horizontal: 8.0 ),
              child: Row(
                children:
                    List.generate(controller.allCategories.length, (index) {
                  Category cat = controller.allCategories[index];
                  String? local = TranslationService.locale.toString();

                 return cat.type == "buy"
                      ? Obx(() => CardCategory(
                              local == "en_US"
                                  ? cat.nameEn!
                                  : local == "it_IT"
                                      ? cat.nameIt!
                                      : cat.nameEs!,
                              cat.icon!,
                              cat.color!, onTap: () {
                            controller.currentCat.value = cat;
                            controller.currentCatStr = cat.nameEs!;
                            _showPicker(
                                context,
                                cat.nameEs == "MUEBLES"
                                    ? EnumCategoryList.furniture
                                    : cat.nameEs == "ACTIVIDAD"
                                        ? EnumCategoryList.activity
                                        : cat.nameEs == "FRANQUICIA"
                                            ? EnumCategoryList.franchise
                                            : EnumCategoryList.furniture);
                          },
                              isSelected: controller
                                  .isActualCategory(cat.nameEs == "MUEBLES"
                                      ? EnumCategoryList.furniture
                                      : cat.nameEs == "ACTIVIDAD"
                                          ? EnumCategoryList.activity
                                          : cat.nameEs == "FRANQUICIA"
                                              ? EnumCategoryList.franchise
                                              : EnumCategoryList.furniture)))
                      : SizedBox();
                }),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          child: Container(
            width: Get.width,
            height: 100.h,
            //color: Colors.red,
            child: Padding(
              padding: const EdgeInsets.symmetric( horizontal: 8.0 ),
              child: Row(
                
                children:
                    List.generate(controller.allCategories.length, (index) {
                  Category cat = controller.allCategories[index];
                  String? local = TranslationService.locale.toString();

                 return cat.type == "business"
                      ? Obx(() => CardCategory(
                              local == "en_US"
                                  ? cat.nameEn!
                                  : local == "it_IT"
                                      ? cat.nameIt!
                                      : cat.nameEs!,
                              cat.icon!,
                              cat.color!, onTap: () {
                            controller.currentCat.value = cat;
                            controller.currentCatStr = cat.nameEs!;
                            _showPicker(
                                context,
                                cat.nameEs == "PROVEEDOR"
                                    ? EnumCategoryList.supplier
                                    : cat.nameEs == "ASESOR"
                                        ? EnumCategoryList.consultant
                                        : cat.nameEs == "EMPRENDEDOR"
                                            ? EnumCategoryList.entrepreneur
                                            : EnumCategoryList.furniture);
                          },
                              isSelected: controller
                                  .isActualCategory(cat.nameEs == "PROVEEDOR"
                                      ? EnumCategoryList.supplier
                                      : cat.nameEs == "ASESOR"
                                          ? EnumCategoryList.consultant
                                          : cat.nameEs == "EMPRENDEDOR"
                                              ? EnumCategoryList.entrepreneur
                                              : EnumCategoryList.furniture)))
                      : SizedBox();
                }),
              ),
            ),
          ),
        ),
        /*Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
          child: Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CardCategory(
                    'furniture'.tr, Icons.chair, ColorConstants.furnitureColor,
                    onTap: () =>
                        _showPicker(context, EnumCategoryList.furniture),
                    isSelected: controller
                        .isActualCategory(EnumCategoryList.furniture)),
                CardCategory('activity'.tr, Icons.food_bank,
                    ColorConstants.activityColor,
                    onTap: () =>
                        _showPicker(context, EnumCategoryList.activity),
                    isSelected:
                        controller.isActualCategory(EnumCategoryList.activity)),
                CardCategory('franchise'.tr, Icons.storefront,
                    ColorConstants.franchiseColor,
                    onTap: () =>
                        _showPicker(context, EnumCategoryList.franchise),
                    isSelected:
                        controller.isActualCategory(EnumCategoryList.franchise))
              ],
            ),
          ),
        ),*/

        /* Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
          child: Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CardCategory('supplier'.tr, Icons.local_shipping,
                    ColorConstants.supplierColor,
                    onTap: () =>
                        _showPicker(context, EnumCategoryList.supplier),
                    isSelected:
                        controller.isActualCategory(EnumCategoryList.supplier)),
                CardCategory('adviser'.tr, Icons.business_center,
                    ColorConstants.consultantColor,
                    onTap: () =>
                        _showPicker(context, EnumCategoryList.consultant),
                    isSelected: controller
                        .isActualCategory(EnumCategoryList.consultant)),
                CardCategory('entrepreneur'.tr, Icons.monetization_on,
                    ColorConstants.entrepreneurColor,
                    onTap: () =>
                        _showPicker(context, EnumCategoryList.entrepreneur),
                    isSelected: controller
                        .isActualCategory(EnumCategoryList.entrepreneur))
              ],
            ),
          ),
        ),*/
        Expanded(
          child: InkWell(
            onTap: () => controller.setCategory(EnumCategoryList.none),
          ),
        )
      ],
    );
  }

  Function? _showPicker(
      BuildContext context, EnumCategoryList currentCategory) {
    controller.setCategory(currentCategory);
    controller.publishAdModel.refresh();
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return TypeAdList();
        }).whenComplete(() {
      controller.setCategory(EnumCategoryList.none);
      controller.publishAdModel.refresh();
    });
  }
}
