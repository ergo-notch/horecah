import 'package:get/get.dart';
import 'package:horecah/lang/lang.dart';
import 'package:horecah/modules/auth/auth_controller.dart';
import 'package:horecah/modules/publish_ad/widgets/dropdown_google_places.dart';
import 'package:horecah/modules/registry/widgets/button_continue_widget.dart';
import 'package:horecah/shared/constants/colors.dart';
import 'package:horecah/shared/shared.dart';
import 'package:horecah/theme/theme.dart';

import 'widgets/custom_radio_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class RegisterLoginScreenWidget extends GetView<AuthController> {
  final TextEditingController textController4 = TextEditingController();
  final TextEditingController textController5 = TextEditingController();
  final FocusScopeNode _node = FocusScopeNode();
  final ScrollController _scrollController = new ScrollController();
  
  
  @override
  Widget build(BuildContext context) {

    String locale = TranslationService.locale.toString();
    
    return CommonWidget.getScreenSizeFontFixed(
      Scaffold(
        appBar: AppBar(
          title: Text(
             locale == "it_IT" ? "Registrazione" : locale == "en_US"  ? "Register" : "Registrarse"  ,
            style: TextStyle(color: ColorConstants.white, fontSize: 20.sp),
          ),
          backgroundColor: ColorConstants.principalColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back,
                size: 20, color: ColorConstants.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          iconTheme: IconThemeData(color: ColorConstants.titlePrincipal),
        ),
        body: FocusScope(
          node: _node,
          child: Form(
            key: controller.registerFormKey,
            child: ListView(
              controller: _scrollController,
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'join_horecah1'.tr,
                        textAlign: TextAlign.start,
                        style: ThemeConfig.bodyText1.override(
                          color: Color(0xFF3C4858),
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
                        child: Text(
                          locale == "it_IT" ? "Nome" : (locale == "en_US" ) ? "Name" : "Nombre", 
                          textAlign: TextAlign.start,
                          style: ThemeConfig.bodyText1.override(
                            color: Color(0xFF3C4858),
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                        child: TextFormField(
                          controller: controller.registerNameController,
                          onEditingComplete: _node.nextFocus,
                          validator: (val) {
                            if (val!.isEmpty) {
                              _scrollController.animateTo(
                                0.0,
                                curve: Curves.easeOut,
                                duration: const Duration(milliseconds: 300),
                              );
                              return 'Devi catturare questo campo';
                            }
                            if (val.length < 5) {
                               _scrollController.animateTo(
                                0.0,
                                curve: Curves.easeOut,
                                duration: const Duration(milliseconds: 300),
                              );
                              return 'Requires at least 5 characters.';
                            }
                            return null;
                          },
                          style: ThemeConfig.bodyText1.override(
                            color: Color(0xFF3C4858),
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                          decoration: InputDecoration(
                              labelText: locale == "it_IT" ? "Inserisci tuo nome" : (locale == "en_US" ) ? "Enter your name" : "Ingrese su nombre",
                              labelStyle: ThemeConfig.bodyText1.override(
                                color: Color(0xFFB4B4B4),
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                              border: OutlineInputBorder(),
                              isDense: true,
                              errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 0.7)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFFB4B4B4), width: 0.7))),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                        child: Text( locale == "it_IT" ? "Il tuo nome di utente sará visibile nel tuo profilo e nei tuoi annunci." : (locale == "en_US" ) ? "Your username will be visible on your profile and when you post an ad." : "Tu nombre de usuario será visible en tu perfíl y al realizar un anuncio." ,
                          textAlign: TextAlign.start,
                          style: ThemeConfig.bodyText1.override(
                            color: Color(0xFF3C4858),
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
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
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                        child: TextFormField(
                          controller: controller.registerEmailController,
                          keyboardType: TextInputType.emailAddress,
                          onEditingComplete: _node.nextFocus,
                          validator: (val) {
                            if (val!.isEmpty) {
                               _scrollController.animateTo(
                                0.0,
                                curve: Curves.easeOut,
                                duration: const Duration(milliseconds: 300),
                              );
                              return 'Devi catturare questo campo';
                            }
                            if (val.length < 5) {
                               _scrollController.animateTo(
                                0.0,
                                curve: Curves.easeOut,
                                duration: const Duration(milliseconds: 300),
                              );
                              return 'Requires at least 5 characters.';
                            }
                            if(!Regex.isEmail(val)){
                               _scrollController.animateTo(
                                0.0,
                                curve: Curves.easeOut,
                                duration: const Duration(milliseconds: 300),
                              );
                              return 'Inserisci un indirizzo email corretta';
                            }
                            return null;
                          },
                          style: ThemeConfig.bodyText1.override(
                            color: Color(0xFF3C4858),
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                          decoration: InputDecoration(
                              labelText: 'login_label2'.tr,
                              labelStyle: ThemeConfig.bodyText1.override(
                                color: Color(0xFFB4B4B4),
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                              border: OutlineInputBorder(),
                              isDense: true,
                              errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 0.7)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFFB4B4B4), width: 0.7))),
                        ),
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
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                        child: TextFormField(
                          obscureText: true,
                          controller: controller.registerPasswordController,
                          onEditingComplete: _node.nextFocus,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Devi catturare questo campo';
                            }
                            if (val.length < 5) {
                              return 'Requires at least 5 characters.';
                            }
                            return null;
                          },
                          style: ThemeConfig.bodyText1.override(
                            color: Color(0xFF3C4858),
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                          decoration: InputDecoration(
                              labelText: 'login_label4'.tr,
                              labelStyle: ThemeConfig.bodyText1.override(
                                color: Color(0xFFB4B4B4),
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                              border: OutlineInputBorder(),
                              isDense: true,
                              errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 0.7)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFFB4B4B4), width: 0.7))),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
                        child: Text(
                          locale == "it_IT" ? "Data di nascita" : (locale == "en_US" ) ? "Birthday" : "Fecha de Nacimiento" ,
                          textAlign: TextAlign.start,
                          style: ThemeConfig.bodyText1.override(
                            color: Color(0xFF3C4858),
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                        child: InkWell(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: Color(0xFFB4B4B4),
                                width: 0.7,
                              ),
                            ),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Obx(
                                  () => Text(
                                    controller.getSelectedDate,
                                    textAlign: TextAlign.left,
                                    style: ThemeConfig.bodyText1.override(
                                      color: Color(0xFFB4B4B4),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                )),
                          ),
                          onTap: () => _selectDate(context),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
                        child: Text(
                          locale == "it_IT" ? "Sesso" : (locale == "en_US" ) ? "Sex" : "Sexo" ,
                          textAlign: TextAlign.start,
                          style: ThemeConfig.bodyText1.override(
                            color: Color(0xFF3C4858),
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: RadioButtonForm(
                          options:  locale == "it_IT" ? ['Maschio', 'Femmina'] : (locale == "en_US" ) ? ['Male', 'Female'] : ['Hombre', 'Mujer'] ,        
                          onChanged: (value) {
                            if (value == 'Maschio' || value == 'Male' || value == 'Hombre') {
                              controller.registerGenderRadioButton = 'man';
                            } else {
                              controller.registerGenderRadioButton = 'woman';
                            }
                          },
                          optionHeight: 25,
                          textStyle: ThemeConfig.bodyText1.override(
                            color: Colors.black,
                            fontSize: 13
                          ),
                          buttonPosition: RadioButtonPosition.left,
                          direction: Axis.horizontal,
                          radioButtonColor: ColorConstants.principalColor,
                          inactiveRadioButtonColor: Color(0x8A000000),
                          toggleable: false,
                          horizontalAlignment: WrapAlignment.spaceBetween,
                          verticalAlignment: WrapCrossAlignment.start,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
                        child: Text(
                           locale == "it_IT" ? "Comune" : (locale == "en_US" ) ? "Location" : "Ubicación" ,
                          textAlign: TextAlign.start,
                          style: ThemeConfig.bodyText1.override(
                            color: Color(0xFF3C4858),
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      DropDownGooglePlaces(type: "register",),
                       SizedBox(
                  height: 20,
                ),
                     /* Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                        child: TextFormField(
                          controller: controller.registerAddressController,
                          onEditingComplete: _node.nextFocus,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Devi catturare questo campo';
                            }
                            if (val.length < 5) {
                              return 'Requires at least 5 characters.';
                            }
                            return null;
                          },
                          style: ThemeConfig.bodyText1.override(
                            color: Color(0xFF3C4858),
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                          decoration: InputDecoration(
                              labelText: 'Inserisci un comune',
                              labelStyle: ThemeConfig.bodyText1.override(
                                color: Color(0xFFB4B4B4),
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                              border: OutlineInputBorder(),
                              isDense: true,
                              errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 0.7)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFFB4B4B4), width: 0.7))),
                        ),
                      ),*/
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: Text(
                          locale == "it_IT" ? "termini d\'uso del servizio" : locale == "en_US"  ? "Terms and conditions" : "Términos y condiciones" ,
                          textAlign: TextAlign.start,
                          style: ThemeConfig.bodyText1.override(
                            color: ColorConstants.principalColor,
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 40),
                        child: InkWell(
                          onTap: () {
                            if (controller.registerFormKey.currentState!.validate()) {
                              controller.register(context);
                            }
                          },
                          child: ButtonContinueWidget(labelButton: 'register_label'.tr),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: controller.registerBirthday.value,
      firstDate: DateTime(1900),
      lastDate: DateTime(2025),
    );
    controller.updateSelectedDate(selected);
  }
}
