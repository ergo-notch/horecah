import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horecah/modules/chats/widgets/send_chat.dart';
import 'package:horecah/modules/home/home.dart';
import 'package:horecah/shared/constants/constants.dart';
import 'package:horecah/theme/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class InboxChatListScreen extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    if (controller.userLogued()) {
      controller.getRooms();
    }

   

    return Obx(() => controller.roomsChats.length == 0
        ? Center(
            child: Text(
              'no_messages'.tr,
              textAlign: TextAlign.center,
              style: ThemeConfig.bodyText1.override(
                color: ColorConstants.principalColor,
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        : ListView(
            children: controller.roomsChats.map((roomChat) {
              return InkWell(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  height: 100,
                  decoration: BoxDecoration(
                      border: Border.all(
                    width: .5,
                    color: Colors.grey.shade400,
                  )),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10, left: 16, right: 16),
                        child: Container(
                            width: 60,
                            height: 60,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: roomChat.product != null
                                ? CachedNetworkImage(
                                    imageUrl:
                                        roomChat.product!.multimedia!.first.url,
                                    fit: BoxFit.cover)
                                : Container(
                                    child: Icon(
                                      Icons.thumb_down_off_alt_rounded,
                                      color: ColorConstants.darkGray,
                                      size: 30,
                                    ),
                                  )),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                roomChat.usersRoom!
                                    .firstWhere((element) =>
                                        element.id !=
                                        controller.userStrapi.value!.id)
                                    .nameLastname!
                                    .capitalize!,
                                style: ThemeConfig.subtitle1.override(
                                  color: Color(0xFF15212B),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Flexible(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  roomChat.product != null
                                      ? roomChat.product!.title.length > 16
                                          ? '${roomChat.product!.title.substring(0, 16)}...'
                                          : roomChat.product!.title.capitalize!
                                      : 'Annuncio no disponible',
                                  style: ThemeConfig.subtitle1.override(
                                    color: Color(0xFF15212B),
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 4, 4, 0),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    roomChat.chats!.last.message,
                                    overflow: TextOverflow.clip,
                                    style: ThemeConfig.bodyText2.override(
                                      color: Color(0xFF8B97A2),
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                onTap: () => Get.to(() => SendChat(roomChat: roomChat)),
              );
            }).toList(),
          ));
  }
}
