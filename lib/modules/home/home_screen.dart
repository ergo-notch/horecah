import 'package:flutter/material.dart';
import 'package:horecah/modules/home/home.dart';
import 'package:horecah/modules/home/tabs/tabs.dart';
import 'package:horecah/shared/shared.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (controller.currentTab.value != MainTabs.home) {
          controller.switchTab(0);
        }
        return false;
      },
      child: Obx(() => _buildWidget()),
    );
  }

  Widget _buildWidget() {
    return Scaffold(
      body: Center(
        child: _buildContent(controller.currentTab.value),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          _buildNavigationBarItem(
              "tab_1".tr, Icons.home, MainTabs.home == controller.currentTab.value),
          _buildNavigationBarItem("tab_2".tr, Icons.favorite_border_rounded,
              MainTabs.favorite == controller.currentTab.value),
          _buildNavigationBarItem("tab_3".tr, Icons.add_box_outlined,
              MainTabs.create_ads == controller.currentTab.value),
          _buildNavigationBarItem("tab_4".tr, Icons.message_outlined,
              MainTabs.inbox == controller.currentTab.value),
          _buildNavigationBarItem("tab_5".tr, Icons.manage_accounts_outlined,
              MainTabs.me == controller.currentTab.value)
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: controller.getCurrentIndex(controller.currentTab.value),
        unselectedItemColor: ColorConstants.darkGray,
        selectedItemColor: ColorConstants.titlePrincipal,
        selectedLabelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 13,
        ),
        onTap: (index) => controller.switchTab(index),
      ),
    );
  }

  Widget _buildContent(MainTabs tab) {
    switch (tab) {
      case MainTabs.home:
        return controller.mainTab;
      case MainTabs.favorite:
        return controller.discoverTab;
      case MainTabs.create_ads:
        return controller.resourceTab;
      case MainTabs.inbox:
        return controller.inboxTab;
      case MainTabs.me:
        return controller.meTab;
      default:
        return controller.mainTab;
    }
  }

  BottomNavigationBarItem _buildNavigationBarItem(
      String label, IconData icon, bool activated) {
    return BottomNavigationBarItem(
      icon: Icon(icon,
          color: activated
              ? ColorConstants.titlePrincipal
              : ColorConstants.darkGray),
      label: label,
    );
  }
}
