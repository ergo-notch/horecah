import 'package:get/get.dart';
import 'package:horecah/modules/auth/auth_controller.dart';
import 'package:horecah/modules/forgot-password/forgot-password.dart';
import 'package:horecah/modules/registry/widgets/button_continue_widget.dart';
import 'package:horecah/routes/routes.dart';
import 'package:horecah/shared/constants/colors.dart';
import 'package:horecah/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreenWidget extends StatefulWidget {
  LoginScreenWidget();

  @override
  _LoginScreenWidgetState createState() => _LoginScreenWidgetState();
}

class _LoginScreenWidgetState extends State<LoginScreenWidget> {
  bool passwordVisibility = false;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var controller = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "login_label".tr,
          style: TextStyle(color: ColorConstants.white, fontSize: 20.sp),
        ),
        backgroundColor: ColorConstants.principalColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 20, color: ColorConstants.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        iconTheme: IconThemeData(color: ColorConstants.titlePrincipal),
      ),
      body: ListView(children: [
        Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'login_title'.tr,
                  textAlign: TextAlign.start,
                  style: ThemeConfig.bodyText1.override(
                    color: Color(0xFF3C4858),
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 65, 0, 0),
                  child: Text(
                    'login_label1'.tr,
                    textAlign: TextAlign.start,
                    style: ThemeConfig.bodyText1.override(
                      color: Color(0xFF3C4858),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                TextFormField(
                  controller: controller.loginEmailController,
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: 'login_label2'.tr,
                    hintStyle: ThemeConfig.bodyText1.override(
                      color: Color(0xFF3C4858),
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF3C4858),
                        width: 0.5,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4.0),
                        topRight: Radius.circular(4.0),
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF3C4858),
                        width: 0.5,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4.0),
                        topRight: Radius.circular(4.0),
                      ),
                    ),
                  ),
                  style: ThemeConfig.bodyText1.override(
                    color: Color(0xFF3C4858),
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Devi catturare questo campo';
                    }
                    if (val.length < 5) {
                      return 'Requires at least 5 characters.';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
                  child: Text(
                    'login_label3'.tr,
                    textAlign: TextAlign.start,
                    style: ThemeConfig.bodyText1.override(
                      color: Color(0xFF3C4858),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                TextFormField(
                  controller: controller.loginPasswordController,
                  obscureText: !passwordVisibility,
                  decoration: InputDecoration(
                    hintText: 'login_label4'.tr,
                    hintStyle: ThemeConfig.bodyText1.override(
                      color: Color(0xFF3C4858),
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF3C4858),
                        width: 0.5,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4.0),
                        topRight: Radius.circular(4.0),
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF3C4858),
                        width: 0.5,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4.0),
                        topRight: Radius.circular(4.0),
                      ),
                    ),
                    suffixIcon: InkWell(
                      onTap: () => setState(
                        () => passwordVisibility = !passwordVisibility,
                      ),
                      child: Icon(
                        passwordVisibility
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: Color(0xFF757575),
                        size: 22,
                      ),
                    ),
                  ),
                  style: ThemeConfig.bodyText1.override(
                    color: Color(0xFF3C4858),
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Devi catturare questo campo';
                    }

                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: InkWell(
                    child: ButtonContinueWidget(labelButton:  "login_label".tr,),
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        controller.login(context);
                      }
                    },
                  ),
                ),
               /* InkWell(
                    onTap: () {
                      Get.toNamed(Routes.LOGIN + Routes.REGISTER);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 60,
                            constraints: BoxConstraints(
                              maxHeight: 40,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: ColorConstants.principalColor,
                                width: .5,
                              ),
                            ),
                            child: Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: Text(
                                'Registrati',
                                textAlign: TextAlign.center,
                                style: ThemeConfig.bodyText1.override(
                                  color: ColorConstants.principalColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )),*/
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.FORGOTPASSWORD);
                  },
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 40),
                    child: Text(
                      'label_forgot_password'.tr,
                      textAlign: TextAlign.start,
                      style: ThemeConfig.bodyText1.override(
                        color: ColorConstants.principalColor,
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        
      ]),
    );
  }
}
