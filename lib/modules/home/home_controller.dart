import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:horecah/api/api.dart';
import 'package:horecah/models/chats/chats.dart';
import 'package:horecah/models/chats/rooms_chats.dart';
import 'package:horecah/models/models.dart';
import 'package:horecah/models/multimedia.dart';
import 'package:horecah/models/products/products.dart';
import 'package:horecah/models/response/users_response.dart';
import 'package:horecah/modules/chats/widgets/send_chat.dart';
import 'package:horecah/modules/home/home.dart';
import 'package:horecah/modules/publish_ad/publish_ad.dart';
import 'package:horecah/routes/app_pages.dart';
import 'package:horecah/shared/shared.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  final ApiRepository apiRepository;
  HomeController({required this.apiRepository});

  var currentTab = MainTabs.home.obs;
  var users = Rxn<UsersResponse>();
  var userStrapi = Rxn<UserStrapi>();
  var roomsChats = RxList<RoomsChats>();
  var actualChat = Rxn<Chats>();
  var actualRoom = Rxn<RoomsChats>();
  var imagesToUpload = <XFile>[].obs;

  late MainTab mainTab;
  late FavoriteTab discoverTab;
  late CreateAdsTab resourceTab;
  late InboxTab inboxTab;
  late MeTab meTab;
  var storage = Get.find<SharedPreferences>();

  //var logeado = false.obs;

  //EDITAR PERFIL (CONTROLADORES)

  GlobalKey<FormState> editProfileFormKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var city = TextEditingController();
  var birthDay = "".obs;

  @override
  void onInit() async {
    super.onInit();

    mainTab = MainTab();
    userLogued();

    discoverTab = FavoriteTab();
    resourceTab = CreateAdsTab();
    inboxTab = InboxTab();
    meTab = MeTab();
  }

  bool userLogued() {
    //print('Exist token ${storage.getString(StorageConstants.token)}');
    print("======== TOKEN ========");
    print("${storage.getString(StorageConstants.token)}");
    if (storage.getString(StorageConstants.token) != null) {
      if (this.userStrapi.value == null) {
        loadUser();
      }

      //this.logeado.value = true;
      return true;
    } else {
      //this.logeado.value = false;
      return false;
    }
  }

  Future<void> loadUser() async {
    var token = storage.getString(StorageConstants.token);
    this.userStrapi.value = await apiRepository.getUser(token!);
    // getRooms();
  }

  Future<void> editProfile() async {
    Map<String, dynamic> newUser = {
      "email": this.emailController.text,
      "nameLastname": this.nameController.text,
      "birthday": this.birthDay.value,
      "address": this.city.text
    };
    showLoading();
    final userUpdated = await apiRepository.updateUserProfile(
        newUser, this.userStrapi.value!.id!);
    Get.back();
    this.userStrapi.value = userUpdated;
    Get.snackbar(
        "Profilo aggiornato", "Le tue informazioni sono state aggiornate",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorConstants.principalColor);
  }

  showLoading() {
    Get.defaultDialog(
        title: "Caricamento in corso...",
        titleStyle: Get.textTheme.subtitle1,
        content: CircularProgressIndicator(),
        barrierDismissible: false);
  }

  void signout() {
    var prefs = Get.find<SharedPreferences>();
    prefs.clear();
    // NavigatorHelper.popLastScreens(popCount: 1);
    this.userStrapi.value = null;
    Get.toNamed(Routes.HOME);
  }

  void switchTab(index) {
    var tab = _getCurrentTab(index);
    currentTab.value = tab;
  }

  int getCurrentIndex(MainTabs tab) {
    switch (tab) {
      case MainTabs.home:
        return 0;
      case MainTabs.favorite:
        return 1;
      case MainTabs.create_ads:
        return 2;
      case MainTabs.inbox:
        return 3;
      case MainTabs.me:
        return 4;
      default:
        return 0;
    }
  }

  MainTabs _getCurrentTab(int index) {
    switch (index) {
      case 0:
        return MainTabs.home;
      case 1:
        return MainTabs.favorite;
      case 2:
        return MainTabs.create_ads;
      case 3:
        return MainTabs.inbox;
      case 4:
        return MainTabs.me;
      default:
        return MainTabs.home;
    }
  }

  /*showSear(EnumCategoryList enumCategoryList) {
    String path = '';
    switch (enumCategoryList) {
      case EnumCategoryList.none:
        path = Routes.FURNITURE;
        break;
      case EnumCategoryList.furniture:
        path = Routes.FURNITURE;
        break;
      case EnumCategoryList.activity:
        path = Routes.ACTIVITY;
        break;
      case EnumCategoryList.franchise:
        path = Routes.FRANCHISE;
        break;
      case EnumCategoryList.supplier:
        path = Routes.SUPPLIER;
        break;
      case EnumCategoryList.consultant:
        path = Routes.CONSULTANT;
        break;
      case EnumCategoryList.entrepreneur:
        path = Routes.ENTREPRENEUR;
        break;
    }
    var controllerPublishAd = Get.find<PublishAdController>();
    controllerPublishAd.setCategory(enumCategoryList);
    controllerPublishAd.setSubCategory(EnumSubCategoryList.none);
    controllerPublishAd.setTypeAdcategory(EnumTypeAdList.none);
    controllerPublishAd.peopleType = 'Selezionare:';
    controllerPublishAd.statusProduct = 'Selezionare:';
    controllerPublishAd
        .getPostAd()
        .then((value) => Get.toNamed(Routes.HOME + Routes.LIST_ADS + path));
  }*/

  void getRooms() async {
    await apiRepository
        .getRooms(this.userStrapi.value!.id!)
        .then((rooms) async {
      if (rooms != null) {
        for (var i = 0; i < rooms.length; i++) {
          await getChat(rooms[i].id!).then((value) {
            print("Yair Chat:"+jsonEncode(value));
            return rooms[i].chats = value;
          });
        }
        rooms.sort((a, b) => a.updatedAt!.compareTo(b.updatedAt!));
        this.roomsChats.value = rooms;
        this.roomsChats.refresh();
      }
    });
  }

  Future<List<Chats>> getChat(int id) async {
    return (await apiRepository.getChat(id))!;
  }

  Future<void> setChat(Chats chat) async {
    this.actualChat.value = chat;
  }

  Future<Chats> sendMessage(String message, int roomId,
      {String type = 'text'}) async {
    return (await apiRepository.sendMessage(Chats(
        message: message,
        type: type,
        user: this.userStrapi.value!,
        roomId: roomId)))!;
  }

  Future<void> sendMultipleMultimediaMessage(int roomId) async {
    imagesToUpload.forEach((element) async {
      await sendMessage('image', roomId, type: 'image').then((chat) async {
        var imageUploaded = await apiRepository.uploadImage(
            File(element.path), 'chats', 'multimedia', chat.id!);
        print(imageUploaded!.url);
      });
    });
  }

  Future<Multimedia> sendMultimediaMessage(File file, int chatId) async {
    return (await apiRepository.uploadImage(
        file, 'chats', 'multimedia', chatId))!;
  }

  Future<RoomsChats> createRoom(Products product) async {
    return (await apiRepository.createRoom(RoomsChats(
        product: product,
        usersRoom: [product.user!, this.userStrapi.value!])))!;
    //Get.to(() => SendChat(roomChat: roomChat));
  }

  setActualRoom(Products product) async {
    var existChat = false;
    for (var room
        in this.roomsChats.where((e) => e.product!.id == product.id)) {
      var user = room.usersRoom!
          .firstWhereOrNull((users) => users.id == this.userStrapi.value!.id);
      if (user != null) {
        existChat = true;
        this.actualRoom.value = room;
      }
    }
    if (!existChat) {
      this.actualRoom.value = RoomsChats(
          product: product, usersRoom: [product.user!, this.userStrapi.value!]);
    }
    Get.to(() => SendChat(roomChat: this.actualRoom.value!));
  }
}
