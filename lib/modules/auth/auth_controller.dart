import 'package:flutter/material.dart';
import 'package:horecah/api/api.dart';
import 'package:horecah/models/models.dart';
import 'package:horecah/models/response/users_response.dart';
import 'package:horecah/modules/home/home.dart';
import 'package:horecah/routes/app_pages.dart';
import 'package:horecah/shared/shared.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final ApiRepository apiRepository;
  AuthController({required this.apiRepository});

  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  TextEditingController registerNameController = TextEditingController();
  TextEditingController registerEmailController = TextEditingController();
  TextEditingController registerPasswordController = TextEditingController();
  TextEditingController registerAddressController = TextEditingController();
  Rx<DateTime> registerBirthday = DateTime.now().obs;
  String registerGenderRadioButton = "man";
  bool registerTermsChecked = false;
  var passwordVisible = false.obs;
  var userStrapi = Rxn<UserStrapi>();

  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  bool changePassword(bool view) {
    this.passwordVisible.value = view;
    return this.passwordVisible.value;
  }

  String get getSelectedDate {
    return "${this.registerBirthday.value.year}-${this.registerBirthday.value.month.toString().padLeft(2, '0')}-${this.registerBirthday.value.day.toString().padLeft(2, '0')}";
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void register(BuildContext context) async {
    AppFocus.unfocus(context);
    final userStrapi = await apiRepository.register(
      RegisterRequest(
          nameLastname: registerNameController.text,
          userName: registerEmailController.text,
          email: registerEmailController.text,
          password: registerPasswordController.text,
          birthday: getSelectedDate,
          address: registerAddressController.text,
          gender: registerGenderRadioButton),
    );

    final prefs = Get.find<SharedPreferences>();
    if (userStrapi != null && userStrapi.token!.isNotEmpty) {
      prefs.setString(StorageConstants.token, userStrapi.token!);
      var controller = Get.find<HomeController>();
      controller.loadUser();
      Get.offAndToNamed(Routes.HOME);
      cleanInputs();
    }
  }

  void login(BuildContext context) async {
    AppFocus.unfocus(context);
    this.userStrapi.value = await apiRepository.login(
      LoginRequest(
        email: loginEmailController.text,
        password: loginPasswordController.text,
      ),
    );

    if (this.userStrapi != null && this.userStrapi.value!.token!.isNotEmpty) {
      final prefs = Get.find<SharedPreferences>();
      prefs.setString(
          StorageConstants.token, this.userStrapi.value!.token.toString());
      refresh();

      Get.toNamed(Routes.HOME);
      var controller = Get.find<HomeController>();
      controller.loadUser();
      cleanInputs();
    }
  }

  @override
  void onClose() {
    super.onClose();

    registerNameController.dispose();
    registerEmailController.dispose();
    registerPasswordController.dispose();
    loginEmailController.dispose();
    loginPasswordController.dispose();
  }

  void updateSelectedDate(DateTime? selected) {
    if (selected != null && selected != this.registerBirthday) {
      this.registerBirthday.value = selected;
      print(this.registerBirthday.value);
    }
  }

  void cleanInputs() async {
    registerNameController.clear();
    registerEmailController.clear();
    registerPasswordController.clear();
    registerGenderRadioButton = "man";
    registerAddressController.clear();
    registerBirthday.value = DateTime.now();
    loginEmailController.clear();
    loginPasswordController.clear();
  }
}
