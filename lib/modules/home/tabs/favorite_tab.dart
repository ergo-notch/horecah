import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horecah/modules/home/home.dart';
import 'package:horecah/modules/publish_ad/publish_ad.dart';
import 'package:horecah/modules/publish_ad/widgets/card_custom_ad.dart';
import 'package:horecah/shared/constants/colors.dart';
import 'package:horecah/theme/theme_data.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoriteTab extends GetView<PublishAdController> {
  @override
  Widget build(BuildContext context) {
    var homeController = Get.find<HomeController>();
    if(homeController.userLogued()) {
      controller.getLikedPosts();
    }else{
      if(controller.likedProducts.length > 0)
        controller.likedProducts.clear();
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('label2_nav'.tr, style: TextStyle( fontSize: 21.sp)),
        backgroundColor: ColorConstants.principalColor,
        brightness: Brightness.dark,
      ),
      body: Obx(() =>
          controller.likedProducts.length == 0
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 100),
                   Icon(
                    Icons.favorite_border,
                    color: ColorConstants.principalColor,
                    size: 100,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      'no_favorites'.tr,
                      textAlign: TextAlign.center,
                      style: ThemeConfig.title1
                    ),
                  ),
                 
                ],
              ),
            )
          : 
          ListView(
            physics: BouncingScrollPhysics(),
            children: controller.likedProducts.map((post) => 
            CardCustomAd(
              post
            )).toList()
          ),
        )
    );
  }
}
