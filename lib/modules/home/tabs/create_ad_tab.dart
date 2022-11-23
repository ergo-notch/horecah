import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horecah/modules/publish_ad/publish_ad_screen.dart';
import 'package:horecah/shared/constants/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateAdsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('label3_nav'.tr, style: TextStyle( fontSize: 21.sp)),
        backgroundColor: ColorConstants.principalColor,
        brightness: Brightness.dark,
      ),
      body: PublishAdScreen()
    );
  }
}
