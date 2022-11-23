import 'package:get/get.dart';
import 'package:horecah/modules/auth/auth_controller.dart';
import 'package:horecah/modules/forgot-password/forgot-password-controller.dart';
import 'package:horecah/modules/forgot-password/forgot-password.dart';
import 'package:horecah/modules/registry/widgets/button_continue_widget.dart';
import 'package:horecah/routes/routes.dart';
import 'package:horecah/shared/constants/colors.dart';
import 'package:horecah/shared/widgets/custom_widgets.dart';
import 'package:horecah/theme/theme.dart';
import 'package:flutter/material.dart';

class NewPasswordPage extends StatefulWidget {
  NewPasswordPage();

  @override
  _NewPasswordPageState createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  bool passwordVisibility = false;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  //var controller = Get.find<AuthController>();

  final forgotPassCtrl = Get.find<ForgotPasswordController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "New Password",
          style: TextStyle(color: ColorConstants.white),
        ),
        backgroundColor: ColorConstants.principalColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 20, color: ColorConstants.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        iconTheme: IconThemeData(color: ColorConstants.titlePrincipal),
      ),
      body: ListView(children: [
        IngresarCodigo(),
        SizedBox(
          height: 20.0,
        ),
        Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ingresa una nueva contraseña',
                  textAlign: TextAlign.start,
                  style: ThemeConfig.bodyText1.override(
                    color: Color(0xFF3C4858),
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
                  child: Text(
                    'Nueva Contraseña',
                    textAlign: TextAlign.start,
                    style: ThemeConfig.bodyText1.override(
                      color: Color(0xFF3C4858),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: forgotPassCtrl.newPasswordController,
                  obscureText: !passwordVisibility,
                  decoration: InputDecoration(
                    hintText: 'Ingresa contraseña nueva',
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
                SizedBox(height: 8.0),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
                  child: Text(
                    'Confirmar Nueva Contraseña',
                    textAlign: TextAlign.start,
                    style: ThemeConfig.bodyText1.override(
                      color: Color(0xFF3C4858),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: forgotPassCtrl.newPasswordConfirmationController,
                  obscureText: !passwordVisibility,
                  decoration: InputDecoration(
                    hintText: 'Confirma contraseña nueva',
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
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: Get.width,
                  height: 50,
                  child: TextButton(
                      onPressed: () {
                        forgotPassCtrl.resetPassword();
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: ColorConstants.principalColor),
                      child: Text(
                        "Cambiar contraseña",
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      )),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

class IngresarCodigo extends StatelessWidget {
  IngresarCodigo({
    Key? key,
  }) : super(key: key);

  final forgotPassCtrl = Get.find<ForgotPasswordController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
      child: Column(
        children: [
          TitlePrincipalAds('Ingresa el código de verificación',
              color: Colors.black),
          SizedBox(
            height: 10,
          ),
          TitlePrincipalAds(
            'Hemos enviado un código de verificación a tu correo electrónico, pégalo a continuación',
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: forgotPassCtrl.codeController,
            decoration: InputDecoration(
              hintText: 'Ingrese código de verificación',
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
            validator: (val) {
              if (val!.isEmpty) {
                return 'Devi catturare questo campo';
              }

              return null;
            },
          ),
        ],
      ),
    );
  }
}
