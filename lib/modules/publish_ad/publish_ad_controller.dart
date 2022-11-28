import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horecah/api/api.dart';
import 'package:horecah/lang/lang.dart';
import 'package:horecah/models/models.dart';
import 'package:horecah/models/multimedia.dart';
import 'package:horecah/models/prices/prices.dart';
import 'package:horecah/models/products/products.dart';
import 'package:horecah/models/publish_ad_model.dart';
import 'package:horecah/models/subcategory.dart';
import 'package:horecah/routes/app_pages.dart';
import 'package:horecah/shared/catalogs/list_enums.dart';
import 'package:horecah/shared/constants/constants.dart';
import 'package:horecah/shared/shared.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'steps/steps_tabs.dart';

class PublishAdController extends GetxController {
  final ApiRepository apiRepository;
  var actualStep = 0.obs;
  var userStrapi = Rxn<UserStrapi>();

  Rx<PublishAdModel> publishAdModel = PublishAdModel(
          currentCategory: EnumCategoryList.none,
          currenTypeAd: EnumTypeAdList.none,
          currentSubCategory: EnumSubCategoryList.none)
      .obs;
      //PRODUCTS===========
  RxList<Products> allProducts = RxList<Products>();
  RxList<Products> filtersProducts = RxList<Products>([]);
  RxList<Products> recentlyProducts = RxList<Products>();
  RxList<Products> likedProducts = RxList<Products>();
  RxList<Products> myProducts = RxList<Products>();



  var imagesToUpload = List<XFile>.filled(6, XFile('')).obs;
  var controllerTitle = TextEditingController();
  var controllerDescription = TextEditingController();
  var controllerPrice = TextEditingController();
  var controllerNewCategoria = TextEditingController();
  var controllerPriceMax = TextEditingController();
  var controllerSearch = TextEditingController();
  var controllerPhone = TextEditingController();
  Rx<bool> postReady = false.obs;
  String peopleType = '';
  String statusProduct = '';
  String city = '';
  int idProduct = 0;
  List<Multimedia> multimediaProduct = [];
  UserStrapi? userProduct;
  Products? actualProduct;
  var prices = Prices().obs;

  //NUEVA IMPLEMENTACION
  var currentCategoria = "".obs;
  var currentSubcategoria = "".obs;

  var currentSubCat = SubCategory().obs;
  var currentCat = Category().obs;
  String currentCatStr = "";
  String currentSubCatStr = "";
  String currenPeopleTypeStr = "";
  String currentCondizioneStr = "";
  String currentAdTypeStr = "";

  var allCategories = RxList<Category>([]);
  var categoriesReady = false.obs;


  var productsRecentlyReady = false.obs;

  PublishAdController({required this.apiRepository, required this.userStrapi});
  
  @override
  void onInit() async {
    super.onInit();
    getPostAdHome();
    //getRecentlyProducts();
  }

  bool isActualCategory(EnumCategoryList category) {
    return publishAdModel.value.currentCategory == EnumCategoryList.none
        ? true
        : publishAdModel.value.currentCategory == category;
  }

  void setCategory(EnumCategoryList currentCategory) {
    publishAdModel.value.currentCategory = currentCategory;
  }

  void setTypeAdcategory(EnumTypeAdList typeAd, {bool next = true}) {
    publishAdModel.value.currenTypeAd = typeAd;
    //print(publishAdModel.value.currenTypeAd);
  }

  void setSubCategory(EnumSubCategoryList subCategory) {
    publishAdModel.value.currentSubCategory = subCategory;
    publishAdModel.refresh();
  }

  bool validateFurniture() {
    return publishAdModel.value.currentCategory == EnumCategoryList.supplier;
  }

  bool validateConsultant() {
    return publishAdModel.value.currentCategory == EnumCategoryList.consultant;
  }

  bool validateEntrepreneur() {
    return publishAdModel.value.currentCategory ==
        EnumCategoryList.entrepreneur;
  }

  bool validateSellBuy() {
    return publishAdModel.value.currentCategory == EnumCategoryList.furniture ||
        publishAdModel.value.currentCategory == EnumCategoryList.activity ||
        publishAdModel.value.currentCategory == EnumCategoryList.franchise;
  }

  bool validateRent() {
    return publishAdModel.value.currentCategory == EnumCategoryList.furniture;
  }

  bool validateRent2() {
    return publishAdModel.value.currentCategory == EnumCategoryList.activity ||
        publishAdModel.value.currentCategory == EnumCategoryList.franchise;
  }

  List<String> getCategoryList() {
    return [
      'furniture'.tr,
      'activity'.tr,
      'franchise'.tr,
      'supplier'.tr,
      'adviser'.tr,
      'entrepreneur'.tr,
    ];
  }

  List<String> getSubCategoryList() {
    switch (publishAdModel.value.currentCategory) {
      case EnumCategoryList.furniture:
        return furnitureSubCategoryList;
      case EnumCategoryList.activity:
      case EnumCategoryList.franchise:
        return activitySubCategoryList;
      case EnumCategoryList.supplier:
        return supplierSubCategoryList;
      case EnumCategoryList.consultant:
        return consultantSubCategoryList;
      case EnumCategoryList.entrepreneur:
        return entrepreneurSubCategoryList;
      default:
        return ['Selezionare:'];
    }
  }

  Color getCardCategoryColor() {
    switch (publishAdModel.value.currentCategory) {
      case EnumCategoryList.furniture:
        return ColorConstants.furnitureColor;
      case EnumCategoryList.activity:
        return ColorConstants.activityColor;
      case EnumCategoryList.franchise:
        return ColorConstants.franchiseColor;
      case EnumCategoryList.supplier:
        return ColorConstants.supplierColor;
      case EnumCategoryList.consultant:
        return ColorConstants.consultantColor;
      case EnumCategoryList.entrepreneur:
        return ColorConstants.entrepreneurColor;
      default:
        return ColorConstants.darkGray;
    }
  }

  String getActualCateogry() {
    switch (publishAdModel.value.currentCategory) {
      case EnumCategoryList.furniture:
        return 'furniture'.tr;
      case EnumCategoryList.activity:
        return 'activity'.tr;
      case EnumCategoryList.franchise:
        return 'franchise'.tr;
      case EnumCategoryList.supplier:
        return 'supplier'.tr;
      case EnumCategoryList.consultant:
        return 'adviser'.tr;
      case EnumCategoryList.entrepreneur:
        return 'entrepreneur'.tr;
      default:
        return '';
    }
  }

  List<String> getTypeAdList() {
    switch (publishAdModel.value.currentCategory) {
      case EnumCategoryList.furniture:
        return furnitureAdList;
      case EnumCategoryList.activity:
      case EnumCategoryList.franchise:
        return activityAdList;
      case EnumCategoryList.supplier:
        return supplierAdList;
      case EnumCategoryList.consultant:
        return consultantAdList;
      case EnumCategoryList.entrepreneur:
        return entrepreneurAdList;
      default:
        return ['option'];
    }
  }

  nexStep(String page, {List<String>? options}) {
    actualStep++;

    Get.toNamed(page, arguments: options);
  }

  backStep(String page) {
    actualStep--;

    if (page == 'back') {
      Get.back();
    } else {
      Get.toNamed(
        page,
      );
    }
  }

  Widget getActualStep() {
    switch (_getCurrentTab(actualStep.value)) {
      case StepsTabs.zero:
        return PublishAdStepZeroScreen();
      case StepsTabs.one:
        return PublishAdStepOneScreen();
      case StepsTabs.two:
        return PublishAdStepTwoScreen();
      case StepsTabs.three:
        return PublishAdStepThreeScreen();
      default:
        return PublishAdStepZeroScreen();
    }
  }

  StepsTabs _getCurrentTab(int index) {
    switch (index) {
      case 0:
        return StepsTabs.zero;
      case 1:
        return StepsTabs.one;
      case 2:
        return StepsTabs.two;
      case 3:
        return StepsTabs.three;
      default:
        return StepsTabs.zero;
    }
  }

  String getActualTypeAd() {
    return getStringTypeAd(publishAdModel.value.currenTypeAd);
  }

  String getActualSubCategory() {
    return getStringSubCategoryFromEnum(
        publishAdModel.value.currentSubCategory);
  }

  void itemUpdate(EnumTypeList type, dynamic value) {
    switch (type) {
      case EnumTypeList.category:
        publishAdModel.value.currentCategory = getEnumCategoryFromString(value);
        break;
      case EnumTypeList.subCategory:
        publishAdModel.value.currentSubCategory =
            getEnumSubCategoryFromString(value);
        break;
      case EnumTypeList.typePerson:
        this.peopleType = value;
        break;
      case EnumTypeList.statusProduct:
        this.statusProduct = value;
        break;
    }
  }

  Future<SubCategory> getSubCatToPost(String nameSubCat) async {
    String locale = TranslationService.locale.toString();

    final subCats =
        await apiRepository.getSubCategoriesForPost(nameSubCat, locale);

    return subCats[0];
  }

  Future<Prices> getPricesList() async {
    final prices = await apiRepository.getPrices();
    return prices;
  }

  Future<String> getCheckout(int option, Products product) async {
    return await apiRepository.getUrlCheckout(option, product.id!);
  }

  Future<SnackbarController> confirmCheckout(String endpoint) async {
    final response = await apiRepository.confirmCheckout(endpoint);
    if (!response)
      return Get.rawSnackbar(
          title: "Error",
          message:
              "No se pudo procesar la compra, comuniquese con el administrador.");

    return Get.rawSnackbar(
        title: "Exito",
        message: "Su producto estara siendo posicionado entre los primeros.");
  }

  Future<void> postAd(BuildContext context) async {

    String locale = TranslationService.locale.toString();

    AppFocus.unfocus(context);
    var newPost = await apiRepository.publishAd(Products(
        title: controllerTitle.text,
        description: controllerDescription.text,
        city: city,
        currency: 'euro',
        peopleType: this.currenPeopleTypeStr,
        price: double.parse(controllerPrice.text),
        phoneNumber: controllerPhone.text.isNotEmpty
            ? int.parse(controllerPhone.text)
            : 0,
        statusProduct: this.currentCondizioneStr,
        status: 'published',
        adType: this.currentAdTypeStr,
        category: getActualCateogry(),
        subCategory: await getSubCatToPost(this.currentSubCatStr),
        user: this.userStrapi.value));
    imagesToUpload.forEach((element) async {
      if (element.path != '') {
        var imageUploaded = await apiRepository.uploadImage(
            File(element.path), 'product', 'multimedia', newPost!);
      }
    });
    CommonWidget.showModalInfo(
            'ad_revision2'.tr,
            title: 'ad_revision1'.tr)
        .then((value) {
      cleanControllers();
      clearData();
      getPostAdHome().then((value) {
        Get.toNamed(Routes.HOME);
      });
    });
  }

  clearData() {
    this.currentCat.value = Category();
    this.currentSubCatStr = "";
    this.currenPeopleTypeStr = "";
    this.currentCondizioneStr = "";
  }

  void cleanControllers() {
    controllerDescription.clear();
    controllerPrice.clear();
    controllerTitle.clear();
    controllerPhone.clear();
    this.publishAdModel.value.currentCategory = EnumCategoryList.none;
    this.publishAdModel.value.currenTypeAd = EnumTypeAdList.none;
    this.publishAdModel.value.currentSubCategory = EnumSubCategoryList.none;
    this.peopleType = '';
    this.statusProduct = '';
    this.city = '';
    this.actualStep.value = 0;
    this.imagesToUpload = List<XFile>.filled(6, XFile('')).obs;
  }

  void cleanControllerOnly() {
    controllerDescription.clear();
    controllerPrice.clear();
    controllerTitle.clear();
    controllerPhone.clear();
    this.peopleType = 'Selezionare:';
    this.statusProduct = 'Selezionare:';
    this.publishAdModel.value.currentSubCategory = EnumSubCategoryList.none;
    this.city = '';
  }

  Future<void> getAllCategories() async {
    categoriesReady.value = false;
    this.allCategories.value = (await apiRepository.getAllCategories());
    this.allCategories.refresh();
    categoriesReady.value = true;
  }

  Future<List<String>> getSubCategoriesByCategory() async {
    if (this.currentCat.value.id == null) return [];

    final subCategories = await apiRepository.getSubCategoriesByCategory(this.currentCat.value.nameEs!);
    List<String> subCategoriesFiltersList = [];
    subCategories.forEach((subCat) {
      String locale = TranslationService.locale.toString();
      subCategoriesFiltersList.add(subCat.nameEn!);
      /*switch (locale) {
        case "en_US":
          {
            subCategoriesFiltersList.add(subCat.nameEn!);
          }
          break;
        case "it_IT":
          {
            subCategoriesFiltersList.add(subCat.nameIt!);
          }
          break;
        case "es_ES":
          {
            subCategoriesFiltersList.add(subCat.nameEs!);
          }
          break;
           case "es_US":
          {
            subCategoriesFiltersList.add(subCat.nameEs!);
          }
          break;
        default:
      }*/
    });
    return subCategoriesFiltersList;
  }

  /*RxList<SubCategory> subCategoriesToPost = RxList<SubCategory>([]);

  Future<List<String>> getSubCategoriesToPost() async {
    final subCategories = await apiRepository.getSubCategoriesByCategory(this.currentCat.value.nameEs!);

    return [];
  }*/

  setCurrentPeopleType() {
    String lang = TranslationService.locale.toString();

    this.currenPeopleTypeStr = lang == "it_IT"
        ? itListPeopleType[0]
        : lang == "en_US"
            ? enListPeopleType[0]
            : lang == "es_ES"
                ? esListPeopleType[0]
                : enListPeopleType[0];
  }

  setCurrentAdType() {
    String lang = TranslationService.locale.toString();
    switch (lang) {
      case "it_IT":
        this.currentCatStr == "MUEBLES"
            ? this.currentAdTypeStr = buyListIt[0]
            : this.currentCatStr == "ASESOR"
                ? this.currentAdTypeStr = asesorListIt[0]
                : this.currentCatStr == "ACTIVIDAD"
                    ? this.currentAdTypeStr = buyListIt[0]
                    : this.currentCatStr == "FRANQUICIA"
                        ? this.currentAdTypeStr = buyListIt[0]
                        : this.currentCatStr == "PROVEEDOR"
                            ? this.currentAdTypeStr = proveedorListIt[0]
                            : this.currentCatStr == "EMPRENDEDOR"
                                ? this.currentAdTypeStr = emprendedorListIt[0]
                                : this.currentAdTypeStr = buyListIt[0];

        break;
      case "es_ES":
        this.currentCatStr == "MUEBLES"
            ? this.currentAdTypeStr = buyListEs[0]
            : this.currentCatStr == "ASESOR"
                ? this.currentAdTypeStr = asesorListEs[0]
                : this.currentCatStr == "ACTIVIDAD"
                    ? this.currentAdTypeStr = buyListEs[0]
                    : this.currentCatStr == "FRANQUICIA"
                        ? this.currentAdTypeStr = buyListEs[0]
                        : this.currentCatStr == "PROVEEDOR"
                            ? this.currentAdTypeStr = proveedorListEs[0]
                            : this.currentCatStr == "EMPRENDEDOR"
                                ? this.currentAdTypeStr = emprendedorListEs[0]
                                : this.currentAdTypeStr = buyListEs[0];

        break;
      case "en_US":
        this.currentCatStr == "MUEBLES"
            ? this.currentAdTypeStr = buyListEn[0]
            : this.currentCatStr == "ASESOR"
                ? this.currentAdTypeStr = asesorListEn[0]
                : this.currentCatStr == "ACTIVIDAD"
                    ? this.currentAdTypeStr = buyListEn[0]
                    : this.currentCatStr == "FRANQUICIA"
                        ? this.currentAdTypeStr = buyListEn[0]
                        : this.currentCatStr == "PROVEEDOR"
                            ? this.currentAdTypeStr = proveedorListEn[0]
                            : this.currentCatStr == "EMPRENDEDOR"
                                ? this.currentAdTypeStr = emprendedorListEn[0]
                                : this.currentAdTypeStr = buyListEn[0];

        break;
      default:
        this.currentCatStr == "MUEBLES"
            ? this.currentAdTypeStr = buyListEn[0]
            : this.currentCatStr == "ASESOR"
                ? this.currentAdTypeStr = asesorListEn[0]
                : this.currentCatStr == "ACTIVIDAD"
                    ? this.currentAdTypeStr = buyListEn[0]
                    : this.currentCatStr == "FRANQUICIA"
                        ? this.currentAdTypeStr = buyListEn[0]
                        : this.currentCatStr == "PROVEEDOR"
                            ? this.currentAdTypeStr = proveedorListEn[0]
                            : this.currentCatStr == "EMPRENDEDOR"
                                ? this.currentAdTypeStr = emprendedorListEn[0]
                                : this.currentAdTypeStr = buyListEn[0];
    }
  }

  List<String> getListPeopleType() {
    String lang = TranslationService.locale.toString();
    List<String> list = [];

    switch (lang) {
      case "it_IT":
        list = itListPeopleType;
        break;
      case "en_US":
        list = enListPeopleType;
        break;
      case "es_ES":
        list = esListPeopleType;
        break;
         case "es_US":
        list = esListPeopleType;
        break;
      default:
        list = enListPeopleType;
    }
    return enListPeopleType;
  }





   List<String> getListCondition() {
    String lang = TranslationService.locale.toString();
    List<String> list = [];

   /* switch (lang) {
      case "it_IT":
        list = itListCondition;
        break;
      case "en_US":
        list = enListCondition;
        break;
      case "es_ES":
        list = esListCondition;
        break;
         case "es_US":
        list = esListCondition;
        break;
      default:
        list = enListCondition;
    }*/
    return enListCondition;
  }





  List<String> getListAdType() {
    String lang = TranslationService.locale.toString();
    List<String> list = [];

     this.currentCatStr == "MUEBLES"
            ? list = mueblesListEn
            : this.currentCatStr == "ASESOR"
                ? list = asesorListEn
                : this.currentCatStr == "ACTIVIDAD"
                    ? list = buyList
                    : this.currentCatStr == "FRANQUICIA"
                        ? list = buyList
                        : this.currentCatStr == "PROVEEDOR"
                            ? list = proveedorListEn
                            : this.currentCatStr == "EMPRENDEDOR"
                                ? list = emprendedorListEn
                                : list = buyListEn;

   /* switch (lang) {
      case "it_IT":
        this.currentCatStr == "MUEBLES"
            ? list = mueblesListIt
            : this.currentCatStr == "ASESOR"
                ? list = asesorListIt
                : this.currentCatStr == "ACTIVIDAD"
                    ? list = buyListIt
                    : this.currentCatStr == "FRANQUICIA"
                        ? list = buyListIt
                        : this.currentCatStr == "PROVEEDOR"
                            ? list = proveedorListIt
                            : this.currentCatStr == "EMPRENDEDOR"
                                ? list = emprendedorListIt
                                : list = buyListIt;

        break;
      case "es_ES":
        this.currentCatStr == "MUEBLES"
            ? list = mueblesListEs
            : this.currentCatStr == "ASESOR"
                ? list = asesorListEs
                : this.currentCatStr == "ACTIVIDAD"
                    ? list = buyListEs
                    : this.currentCatStr == "FRANQUICIA"
                        ? list = buyListEs
                        : this.currentCatStr == "PROVEEDOR"
                            ? list = proveedorListEs
                            : this.currentCatStr == "EMPRENDEDOR"
                                ? list = emprendedorListEs
                                : list = buyListEs;

        break;
        case "es_US":
        this.currentCatStr == "MUEBLES"
            ? list = mueblesListEs
            : this.currentCatStr == "ASESOR"
                ? list = asesorListEs
                : this.currentCatStr == "ACTIVIDAD"
                    ? list = buyListEs
                    : this.currentCatStr == "FRANQUICIA"
                        ? list = buyListEs
                        : this.currentCatStr == "PROVEEDOR"
                            ? list = proveedorListEs
                            : this.currentCatStr == "EMPRENDEDOR"
                                ? list = emprendedorListEs
                                : list = buyListEs;

        break;
      case "en_US":
        this.currentCatStr == "MUEBLES"
            ? list = mueblesListEn
            : this.currentCatStr == "ASESOR"
                ? list = asesorListEn
                : this.currentCatStr == "ACTIVIDAD"
                    ? list = buyListEn
                    : this.currentCatStr == "FRANQUICIA"
                        ? list = buyListEn
                        : this.currentCatStr == "PROVEEDOR"
                            ? list = proveedorListEn
                            : this.currentCatStr == "EMPRENDEDOR"
                                ? list = emprendedorListEn
                                : list = buyListEn;

        break;
      default:
        this.currentCatStr == "MUEBLES"
            ? list = buyListEn
            : this.currentCatStr == "ASESOR"
                ? list = asesorListEn
                : this.currentCatStr == "ACTIVIDAD"
                    ? list = buyListEn
                    : this.currentCatStr == "FRANQUICIA"
                        ? list = buyListEn
                        : this.currentCatStr == "PROVEEDOR"
                            ? list = proveedorListEn
                            : this.currentCatStr == "EMPRENDEDOR"
                                ? list = emprendedorListEn
                                : list = buyListEn;
    }*/
    return list;
  }

  Future<void> refreshProducts() async {
    String category = "";

    postReady.value = false;

    final products = await apiRepository.getPosts(category: category);

    if( products != null ){
      this.allProducts.value = products;
      this.allProducts.refresh();
      postReady.value = true;
    }

    /*this.allProducts.value = (await apiRepository.getPosts(category: category))!;
    this.allProducts.refresh();
    postReady.value = true;*/
  }

  Future<void> getPostAdHome() async {
    String category = this.currentCat.value.nameEs ?? "";

    postReady.value = false;

    final products = await apiRepository.getPosts(category: category);
     postReady.value = true;
    if ( products != null ){
      this.allProducts.value = products;
      this.allProducts.refresh();
      
    }

    /*this.allProducts.value = (await apiRepository.getPosts(category: category)  )!;
    this.allProducts.refresh();*/
   
  }


   Future<void> getPostAdToFilterScreen() async {
    String category = this.currentCat.value.nameEs ?? "";

    

    print("=============CATEGORY ================= $category");

    //postReady.value = false;

    this.filtersProducts.value = (await apiRepository.getPosts(category: category))!;
    this.filtersProducts.refresh();
    //postReady.value = true;
  }


  Future<bool> getRecentlyProducts() async {
    productsRecentlyReady.value = false;

    final productsRecent = await apiRepository.getRecentlyProducts(this.userStrapi.value!.id!);

    var isOkay = false;

    if(productsRecent != null) {
      this.recentlyProducts.value = productsRecent;
      this.recentlyProducts.refresh();
       productsRecentlyReady.value = true;
       isOkay = true;
    }
    return isOkay;

   /* this.recentlyProducts.value = (await apiRepository.getRecentlyProducts(this.userStrapi.value!.id!))!;
    this.recentlyProducts.refresh();
    productsRecentlyReady.value = true;
    return true;*/
  }

  Future<bool> addToRecentlyProducts(int productId) async {
    bool result = (await apiRepository.addToRecentlyProducts(productId))!;
    return result;
  }

  /*Future<void> getAllPostAd() async {
   /* String cat = getActualCateogry();
    print('category: ' + cat);
    postReady.value = false;
    this.allProducts.value = (await apiRepository.getAllPosts(category: cat))!;
    this.allProducts.refresh();
    postReady.value = true;*/
  }*/

 /* void getPostListAd(EnumCategoryList enumCategoryList) {
    this.allProducts.clear();
    setCategory(enumCategoryList);
    getPostAd();
  }*/

  Future<void> getAllPostDraftPublished() async {
    postReady.value = false;

    final products = await apiRepository.getAllPostsDraftPublished();

    if( products != null ){
      this.allProducts.value = products;
      this.allProducts.refresh();
    postReady.value = true;
    } 

    /*this.allProducts.value = (await apiRepository.getAllPostsDraftPublished()  )!;
    this.allProducts.refresh();
    postReady.value = true;*/
  }

  void getMyPostListAd() {
    getAllPostDraftPublished().then((value) {
      this.myProducts.value = this
          .allProducts
          .where((e) => e.user!.id == this.userStrapi.value!.id)
          .toList();
      this.myProducts.refresh();
      Future.delayed(Duration(seconds: 1), () {
        refreshProducts();
      });
    });
  }

  Future<Products?> addFavorite(Products product) async {
    //print("user sttrapi. ${userStrapi.value!.id}");

    return await apiRepository
        .addProductLike(
            Likes(userId: this.userStrapi.value!.id!, productId: product.id!))
        .then((value) async => await apiRepository.getPostsById(product.id!));
  }

  Future<Products?> removeFavorite(int likeId, int productId) async {
    return await apiRepository
        .removeProductLike(likeId)
        .then((value) async => await apiRepository.getPostsById(productId));
  }

  Future<void> getLikedPosts() async {
    await apiRepository.getProductsLiked(userStrapi.value!.id!).then((value) {
      if (value != null) {
        this.likedProducts.value = value;
        this.allProducts.refresh();
      }
    });
  }

  Future<void> getPostAdFilter() async {
    /* String cat = getActualCateogry();
    print('category: ' + cat);*/
    String query = '';
    if (this.controllerSearch.text.length > 0) {
      query += '&title_contains=${controllerSearch.text}';
    }

    if (this.currentCatStr != "") {
      query += "&sub_category.category.name_es=${this.currentCat.value.nameEs}";
    }

    if (this.currentSubCatStr != "") {
      String locale = TranslationService.locale.toString();
      print("=======================LANG====================== $locale");

      switch (locale) {
        case "en_US":
          {
            query += "&sub_category.name_en=${this.currentSubCatStr}";
          }
          break;
        case "it_IT":
          {
            query += "&sub_category.name_it=${this.currentSubCatStr}";
          }
          break;
        case "en_ES":
          {
            query += "&sub_category.name_es=${this.currentSubCatStr}";
          }
          break;
           case "es_US":
          {
            query += "&sub_category.name_es=${this.currentSubCatStr}";
          }
          break;
        default:
      }
    }

    //Todo:  FILTROS PARA EL PEOPLE - TYPE=====================

    String locale = TranslationService.locale.toString();
    switch (locale) {
      case "en_US":
        {
          if (currenPeopleTypeStr == "Private") {
            query +=
                "&_where[people_type_contains]=Private&_where[people_type_contains]=Privado&_where[people_type_contains]=Privato";
          } else if (currenPeopleTypeStr == "IVA") {
            query +=
                "&_where[people_type_contains]=IVA&_where[people_type_contains]=Partita IVA";
          } else if (currenPeopleTypeStr == "Agency") {
            query +=
                "&_where[people_type_contains]=Agency&_where[people_type_contains]=Agencia&_where[people_type_contains]=Azienda";
          }
        }
        break;
      case "it_IT":
        {
          if (currenPeopleTypeStr == "Privato") {
            query +=
                "&_where[people_type_contains]=Private&_where[people_type_contains]=Privado&_where[people_type_contains]=Privato";
          } else if (currenPeopleTypeStr == "Partita IVA") {
            query +=
                "&_where[people_type_contains]=IVA&_where[people_type_contains]=Partita IVA";
          } else if (currenPeopleTypeStr == "Azienda") {
            query +=
                "&_where[people_type_contains]=Agency&_where[people_type_contains]=Agencia&_where[people_type_contains]=Azienda";
          }
        }
        break;
      case "en_ES":
        {
          if (currenPeopleTypeStr == "Privado") {
            query +=
                "&_where[people_type_contains]=Private&_where[people_type_contains]=Privado&_where[people_type_contains]=Privato";
          } else if (currenPeopleTypeStr == "IVA") {
            query +=
                "&_where[people_type_contains]=IVA&_where[people_type_contains]=Partita IVA";
          } else if (currenPeopleTypeStr == "Agencia") {
            query +=
                "&_where[people_type_contains]=Agency&_where[people_type_contains]=Agencia&_where[people_type_contains]=Azienda";
          }
        }
        break;
         case "es_US":
        {
          if (currenPeopleTypeStr == "Privado") {
            query +=
                "&_where[people_type_contains]=Private&_where[people_type_contains]=Privado&_where[people_type_contains]=Privato";
          } else if (currenPeopleTypeStr == "IVA") {
            query +=
                "&_where[people_type_contains]=IVA&_where[people_type_contains]=Partita IVA";
          } else if (currenPeopleTypeStr == "Agencia") {
            query +=
                "&_where[people_type_contains]=Agency&_where[people_type_contains]=Agencia&_where[people_type_contains]=Azienda";
          }
        }
        break;
      default:
    }

    //==================================================FILTRO ADTYPE =====================================================================

    if (currentAdTypeStr == "Sell" || currentAdTypeStr == "Vendo") {
      query += "&_where[ad_type_contains]=Sell&_where[ad_type_contains]=Vendo";
    } else if (currentAdTypeStr == "Buy" || currentAdTypeStr == "Compro") {
      query += "&_where[ad_type_contains]=Buy&_where[ad_type_contains]=Compro";
    } else if (currentAdTypeStr == "Rent" ||
        currentAdTypeStr == "Rento" ||
        currentAdTypeStr == "Affitto" ||
        currentAdTypeStr == "Noleggio") {
      if (currentCat.value.nameEs != "MUEBLES") {
        
        query += "&_where[ad_type_contains]=Rent&_where[ad_type_contains]=Rento&_where[ad_type_contains]=Affitto";
      } else {
        print("CATEGORIA MUEBLES============");
       
        query += "&_where[ad_type_contains]=Rent&_where[ad_type_contains]=Rento&_where[ad_type_contains]=Noleggio";
      }
    } else if (currentAdTypeStr == "I am a supplier" ||
        currentAdTypeStr == "Soy proveedor" ||
        currentAdTypeStr == "Sono un Fornitore") {
      query +=
          "&_where[ad_type_contains]=I am a supplier&_where[ad_type_contains]=Soy proveedor&_where[ad_type_contains]=Sono un Fornitore";
    } else if (currentAdTypeStr == "Searching a supplier" ||
        currentAdTypeStr == "Busco proveedor" ||
        currentAdTypeStr == "Cerco un Fornitore") {
      query +=
          "&_where[ad_type_contains]=Searching a supplier&_where[ad_type_contains]=Busco proveedor&_where[ad_type_contains]=Cerco un Fornitore";
    } else if (currentAdTypeStr == "I am an adviser" ||
        currentAdTypeStr == "Soy asesor" ||
        currentAdTypeStr == "Sono un Consulente") {
      query +=
          "&_where[ad_type_contains]=I am an adviser&_where[ad_type_contains]=Soy asesor&_where[ad_type_contains]=Sono un Consulente";
    } else if (currentAdTypeStr == "Searching an adviser" ||
        currentAdTypeStr == "Busco asesor" ||
        currentAdTypeStr == "Cerco un Consulente") {
      query +=
          "&_where[ad_type_contains]=Searching an adviser&_where[ad_type_contains]=Busco asesor&_where[ad_type_contains]=Cerco un Consulente";
    } else if (currentAdTypeStr == "I am entrepreneur" ||
        currentAdTypeStr == "Soy emprendedor" ||
        currentAdTypeStr == "Sono un Imprenditore") {
      query +=
          "&_where[ad_type_contains]=I am entrepreneur&_where[ad_type_contains]=Soy emprendedor&_where[ad_type_contains]=Sono un Imprenditore";
    } else if (currentAdTypeStr == "Searching an entrepreneur" ||
        currentAdTypeStr == "Busco emprendedor" ||
        currentAdTypeStr == "Cerco un Imprenditore") {
      query +=
          "&_where[ad_type_contains]=Searching an entrepreneur&_where[ad_type_contains]=Busco emprendedor&_where[ad_type_contains]=Cerco un Imprenditore";
    }

    /*if (cat.isNotEmpty) {
      query += '&category=$cat';
    }
    if (getActualTypeAd() != 'Selezionare:') {
      query += '&ad_type=' + getActualTypeAd();
    }
    if (getActualSubCategory() != 'Selezionare:') {
      query += '&sub_category=' + getActualSubCategory();
    }
    if (this.peopleType != 'Selezionare:') {
      query += '&people_type=' + this.peopleType;
    }
    if (this.statusProduct != 'Selezionare:') {
      query += '&status_product=' + this.statusProduct;
    }*/
    if (controllerPrice.text.isNotEmpty) {
      query += '&_where[price_gte]=${controllerPrice.text}';
    }
    if (controllerPriceMax.text.isNotEmpty) {
      query += '&_where[price_lte]=${controllerPriceMax.text}';
    }

    final products = await apiRepository.getPostsByFilter(query);

    if( products != null ) {
      this.filtersProducts.value = products;
      this.filtersProducts.refresh();
    }

    /*this.filtersProducts.value = (await apiRepository.getPostsByFilter(query))!;
    this.filtersProducts.refresh();*/
    //postReady.value = true;
  }

  void setActualProduct(Products product) {
    String lang = TranslationService.locale.toString();

    this.publishAdModel.value.currentCategory =
        getEnumCategoryFromString(product.category);
    this.publishAdModel.value.currenTypeAd =
        getEnumTypeAdFromString(product.adType);
    //this.publishAdModel.value.currentSubCategory =getEnumSubCategoryFromString(product.subCategory);
    this.controllerTitle.text = product.title;
    this.controllerDescription.text = product.description;
    this.controllerPrice.text = product.price.toString();
    this.controllerPhone.text =
        product.phoneNumber != 0 ? product.phoneNumber.toString() : '';
    this.peopleType = product.peopleType;
    this.statusProduct = product.statusProduct;
    this.city = product.city;
    this.idProduct = product.id!;
    this.multimediaProduct = product.multimedia!;
    this.userProduct = product.user;
    this.actualProduct = product;
    this.controllerNewCategoria.text = lang == "it_IT"
        ? product.subCategory!.category!.nameIt!
        : lang == "es_ES"
            ? product.subCategory!.category!.nameEs!
            : product.subCategory!.category!.nameEn!;
  }

  Future<void> removeImage(int id) async {
    (await apiRepository.removeImage(id))!;
  }

  void updatePostAd() async {
    var updatedPost = await apiRepository.updateProducthAd(
        Products(
            title: controllerTitle.text,
            description: controllerDescription.text,
            city: city,
            currency: 'euro',
            peopleType: this.currenPeopleTypeStr,
            price: double.parse(controllerPrice.text),
            phoneNumber: controllerPhone.text.isNotEmpty
                ? int.parse(controllerPhone.text)
                : 0,
            statusProduct: this.statusProduct,
            status: 'published',
            adType: this.currentAdTypeStr,
            category: getActualCateogry(),
            subCategory: await getSubCatToPost(this.currentSubCatStr),
            user: this.userStrapi.value),
        this.actualProduct!.id!);
    imagesToUpload.forEach((element) async {
      print("Imagen!");
      if (element.path != '') {
        var imageUploaded = await apiRepository.uploadImage(
            File(element.path), 'product', 'multimedia', updatedPost!.id!);
        //print(imageUploaded!.url);
      }
    });
    setCategory(publishAdModel.value.currentCategory);
    getMyPostListAd();
    //setActualProduct(updatedPost!);
    Get.back();
    cleanControllers();
  }










  void updateProduct() async {

    Get.defaultDialog(  
      title: "update_title".tr,
      titleStyle: TextStyle( fontSize: 18.sp ),
      content: Center(
        child: CircularProgressIndicator(),
      ),
      
    );

    try {

      var updatedPost = await apiRepository.updateProduct(
        Products(
            title: controllerTitle.text,
            description: controllerDescription.text,
            city: city,
            currency: 'euro',
            peopleType: this.currenPeopleTypeStr,
            price: double.parse(controllerPrice.text),
            phoneNumber: controllerPhone.text.isNotEmpty
                ? int.parse(controllerPhone.text)
                : 0,
            statusProduct: this.statusProduct,
            status: 'published',
            adType: this.currentAdTypeStr,
            category: getActualCateogry(),
            subCategory: await getSubCatToPost(this.currentSubCatStr),
            user: this.userStrapi.value),
        this.actualProduct!.id!);


        //termino update

    imagesToUpload.forEach((element) async {
      print("Imagen!");
      if (element.path != '') {
        var imageUploaded = await apiRepository.uploadImage(
            File(element.path), 'product', 'multimedia', updatedPost!);
      }
    });
    Get.back();
    //MOSTRAR SNACKBAR
    
    
     Get.snackbar( "msg".tr , "update_ok".tr,
          backgroundColor: ColorConstants.principalColor,
          colorText: Colors.white,
          duration: Duration(seconds: 5),
          snackPosition: SnackPosition.BOTTOM,
          snackbarStatus: (status) async {
        if (status == SnackbarStatus.CLOSED)  {
          setCategory(publishAdModel.value.currentCategory);
    getMyPostListAd();
    final prodUpdated = await apiRepository.getProduct(updatedPost);
    setCurrentProduct(prodUpdated);
    //setActualProduct(updatedPost!);
    Get.back();
    cleanControllers();
        }
      });

      
    } catch (e) {
       Get.snackbar( "Error" , "error_update".tr,
          backgroundColor: ColorConstants.principalColor,
          colorText: Colors.white,
          duration: Duration(seconds: 5),
          snackPosition: SnackPosition.BOTTOM);
         
    }





    

    
  }














  var currentproduct = Products(
          title: "",
          category: "",
          subCategory: SubCategory(),
          currency: "",
          adType: "",
          description: "",
          phoneNumber: 1,
          statusProduct: "",
          peopleType: "",
          price: 1,
          city: "")
      .obs;

  setCurrentProduct(Products product) {
    this.currentproduct.value = product;
    this.currentproduct.refresh();
  }

  void disabledProduct(Products product) async {
    product.status = 'draft';

    var updatedPost =
        await apiRepository.changeProductStatus(product, product.id!);

    getMyPostListAd();
  }

  void publishProduct(Products product) async {
    product.status = 'published';
    var updatedPost =
        await apiRepository.changeProductStatus(product, product.id!);
    getMyPostListAd();
  }

  void removeProduct(Products product) async {
    if (product.multimedia != null) {
      product.multimedia!.map((e) => removeImage(e.id));
    }
    var updatedPost = await apiRepository.removeProduct(product.id!);
    getMyPostListAd();
  }
}
