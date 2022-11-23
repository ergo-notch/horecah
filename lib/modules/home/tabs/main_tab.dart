import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horecah/lang/translation_service.dart';
import 'package:horecah/models/subcategory.dart';
import 'package:horecah/modules/publish_ad/publish_ad.dart';
import 'package:horecah/shared/shared.dart';
import 'package:horecah/modules/home/home.dart';
import 'package:horecah/shared/widgets/widgets.dart';
import 'package:horecah/theme/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainTab extends GetView<HomeController> {
  String iconChair = "Icons.chair";

  @override
  Widget build(BuildContext context) {
    print(ColorConstants.furnitureColor.value);
    final adController = Get.find<PublishAdController>();

   /* if (controller.userLogued()) {
      Future.delayed(Duration(seconds: 2), () {
        adController.getRecentlyProducts();
      });
    }*/

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 110),
            child: ListView(
              children: [
                buildGridView(),
              ],
            ),
          ),
          CustomAppBar(),
        ],
      ),
    );
  }

  Widget buildGridView() {
    final adController = Get.find<PublishAdController>();

    /*if (controller.userLogued()) {
      Future.delayed(Duration(seconds: 2), () {
        adController.getRecentlyProducts();
      });
    }*/

    return Column(
      children: [
        Container(
            decoration: BoxDecoration(color: ColorConstants.principalColor),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
                alignment: Alignment.center,
                child: TitlePrincipal('explore_our_sections',
                    color: Colors.white))),
        Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: Align(
              alignment: Alignment.center,
              child: TitleSecundary('what_looking_one',
                  fontWeight: FontWeight.w600,
                  color: ColorConstants.principalColor),
            )),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          child: Container(
            width: Get.width,
            height: 100.h,
            //color: Colors.red,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children:
                    List.generate(adController.allCategories.length, (index) {
                  Category cat = adController.allCategories[index];
                  String? local = TranslationService.locale.toString();

                  return cat.type == "buy"
                      ? CardCategory(
                          local == "en_US"
                              ? cat.nameEn!
                              : local == "it_IT"
                                  ? cat.nameIt!
                                  : cat.nameEs!,
                          cat.icon!,
                          cat.color!, onTap: () {
                          adController.currentCat.value = cat;
                          print(adController.currentCat.value.nameEs);
                          adController.currentCatStr = cat.nameEs!;
                          adController.getPostAdToFilterScreen().then((value) {
                            Get.to(() => ListAdScreen());
                          });
                        })
                      : SizedBox();
                }),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Align(
            alignment: Alignment.center,
            child: TitleSecundary(
              'what_looking_two',
              fontWeight: FontWeight.w600,
              color: ColorConstants.principalColor,
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
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children:
                    List.generate(adController.allCategories.length, (index) {
                  Category cat = adController.allCategories[index];
                  String? local = TranslationService.locale.toString();

                  return cat.type == "business"
                      ? CardCategory(
                          local == "en_US"
                              ? cat.nameEn!
                              : local == "it_IT"
                                  ? cat.nameIt!
                                  : cat.nameEs!,
                          cat.icon!,
                          cat.color!, onTap: () {
                          adController.currentCat.value = cat;
                          print(adController.currentCat.value.nameEs);
                          adController.currentCatStr = cat.nameEs!;
                          adController.getPostAdToFilterScreen().then((value) {
                            Get.to(() => ListAdScreen());
                          });
                        })
                      : SizedBox();
                }),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'keep_searching'.tr,
                textAlign: TextAlign.left,
                style: ThemeConfig.bodyText1.override(
                  color: ColorConstants.titlePrincipal,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              InkWell(
                  child: ButtonSecundary('view_all'),
                  onTap: () {
                    adController.currentCatStr = "";
                    adController.getPostAdToFilterScreen().then((value) {
                      Get.to(() => ListAdScreen(
                        conCategoria: false,
                      ),
                      );
                    });
                  }
                      )
            ],
          ),
        ),
        Obx(() {
          var postAdController = Get.find<PublishAdController>();

          final cards = getListAll();
          return postAdController.postReady.value == true
              ? SizedBox(
                  height: 280.h,
                  
                  child: ListView.builder(
                    itemCount: cards.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return cards[index];
                    },
                  ),
                )
              : Center(child: SizedBox());
        }),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'ad_view_early'.tr,
              textAlign: TextAlign.left,
              style: ThemeConfig.bodyText1.override(
                color: ColorConstants.titlePrincipal,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        if (controller.userLogued())
        FutureBuilder(
          future: adController.getRecentlyProducts(),
          builder: (context, snapshot) {
          if( !snapshot.hasData ){
            return SizedBox();
          }else{
              return recentlyProds();
          }

        
        }),
          //recentlyProds(),
        if (!controller.userLogued())
          /*Center(
            child: Text(
              'You need to be logged in',
              textAlign: TextAlign.center,
              style: ThemeConfig.bodyText1.override(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),*/
          SizedBox(
            height: 20.h,
          ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
          child: _cardCreateAd(),
        ),
        SizedBox(
          height: 30.h,
        ),
      ],
    );
  }

   recentlyProds()  {

    final products =  getListRecently();

   if( products.isEmpty ){
      return SizedBox();
   }else{
    return Obx(() {
          var postAdController = Get.find<PublishAdController>();
          final recentlyProducs = getListRecently();
          return postAdController.postReady.value == true || postAdController.productsRecentlyReady.value == true
              ? 
           SizedBox(
                  height: 280.h,
                  child: ListView.builder(
                    itemCount: recentlyProducs.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return recentlyProducs[index];
                    },
                  ),
                )
              //Carousel(getListRecently() )
              : Center(child: CircularProgressIndicator()  );






        });
   }


   

    
  }

  _cardCreateAd() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: InkWell(
        child: ButtonSecundary('place_ad'),
        onTap: () => controller
            .switchTab(controller.getCurrentIndex(MainTabs.create_ads)),
      ),
    );
  }

  List<Widget> getListAll() {
    var postAdController = Get.find<PublishAdController>();

    return postAdController.allProducts.length > 0
        ? postAdController.allProducts.map<Widget>((product) {
            return InkWell(
              child: CardItemAd(product.title, product.description,
                  product.price.round().toString(), product.multimedia![0].url),
              onTap: () async {
                postAdController.setCurrentProduct(product);
                postAdController.setActualProduct(product);
                postAdController.currentCat.value =
                    product.subCategory!.category!;
                postAdController.currentCatStr =
                    product.subCategory!.category!.nameEs!;
                print("currentCatStr showAd ${postAdController.currentCatStr}");

                await postAdController.addToRecentlyProducts(product.id!);
                postAdController.getRecentlyProducts();
                Get.to(() => ShowAdScreen(color: Colors.red,));
              },
            );
          }).toList()
        : [
            Center(
                child: CircularProgressIndicator(
              color: ColorConstants.darkGray,
            ))
          ];
  }

  List<Widget> getListRecently() {
    var postAdController = Get.find<PublishAdController>();

    return postAdController.recentlyProducts.length > 0
        ? postAdController.recentlyProducts.map<Widget>((product) {
            return InkWell(
              child: CardItemAd(product.title, product.description,
                product.price.toString(), product.multimedia![0].url),
              onTap: () async {
                postAdController.setCurrentProduct(product);
                postAdController.setActualProduct(product);
                postAdController.currentCat.value =
                    product.subCategory!.category!;
                postAdController.currentCatStr =
                    product.subCategory!.category!.nameEs!;
                print("currentCatStr showAd ${postAdController.currentCatStr}");
                postAdController.getRecentlyProducts();
                await postAdController.addToRecentlyProducts(product.id!);
                postAdController.getRecentlyProducts();
                Get.to(() => ShowAdScreen(color: Colors.red));
              },
            );
          }).toList()
        : [

          ];
  }
}
