import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horecah/models/multimedia.dart';
import 'package:horecah/modules/publish_ad/publish_ad_controller.dart';
import 'package:photo_view/photo_view.dart';

import '../../routes/app_pages.dart';

class ShowImage extends StatelessWidget {
  ShowImage(this.url);

  final adController = Get.find<PublishAdController>();

  String url;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.toNamed(Routes.HOME);
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              PhotoView(
                backgroundDecoration: BoxDecoration(color: Colors.white),
                imageProvider: NetworkImage(this.url),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    InkWell(
                      child: Card(
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 6),
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 26,
                          ),
                        ),
                      ),
                      onTap: () {
                        adController.cleanControllerOnly();
                        Get.back();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
