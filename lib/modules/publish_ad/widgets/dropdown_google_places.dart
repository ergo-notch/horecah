import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_place/google_place.dart';
import 'package:horecah/api/api_constants.dart';
import 'package:horecah/lang/translation_service.dart';
import 'package:horecah/modules/auth/auth_controller.dart';
import 'package:horecah/modules/home/home_controller.dart';
import 'package:horecah/modules/publish_ad/publish_ad.dart';
import 'package:horecah/theme/theme.dart';

class DropDownGooglePlaces extends StatefulWidget {
  @override
  _DropDownGooglePlacesState createState() => _DropDownGooglePlacesState();

  String type;
  DropDownGooglePlaces({this.type = ""});
}

class _DropDownGooglePlacesState extends State<DropDownGooglePlaces> {
  GooglePlace googlePlace = GooglePlace(ApiConstants.googleApiKey);
  List<AutocompletePrediction> predictions = [];
  var controller = Get.find<PublishAdController>();
  @override
  Widget build(BuildContext context) {

     String locale = TranslationService.locale.toString();


    return Autocomplete<AutocompletePrediction>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return [];
        }
        if (textEditingValue.text.isNotEmpty) {
          autoCompleteSearch(textEditingValue.text);
        }
        return predictions
            .where((AutocompletePrediction county) => county.description!
                .toLowerCase()
                .startsWith(textEditingValue.text.toLowerCase()))
            .toList();
      },
      displayStringForOption: (AutocompletePrediction option) =>
          option.description!,
      onSelected: (AutocompletePrediction selection) {
        print('places: You just selected ${selection.description}');
        print('places: You just selected ${selection.placeId}');
        print("Type ${widget.type}");
        controller.city = selection.description!;
        if (widget.type == "register") {
          final authController = Get.find<AuthController>();
          authController.registerAddressController.text =
              selection.description!;
        } else if (widget.type == "edit-profile") {
          final homeController = Get.find<HomeController>();
          homeController.city.text = selection.description!;
         
        }
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<AutocompletePrediction> onSelected,
          Iterable<AutocompletePrediction> options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            child: Container(
              width: 300,
              child: ListView.builder(
                padding: EdgeInsets.all(10.0),
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) {
                  final AutocompletePrediction option =
                      options.elementAt(index);

                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: ListTile(
                      title: Text(option.description!,
                          textScaleFactor: 1, style: ThemeConfig.bodyText1),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
      fieldViewBuilder: (BuildContext context,
          TextEditingController fieldTextEditingController,
          FocusNode fieldFocusNode,
          VoidCallback onFieldSubmitted) {
        if (fieldTextEditingController.text == '' && controller.city != '') {
          fieldTextEditingController.text = controller.city;
        }
        return TextField(
          controller: fieldTextEditingController,
          focusNode: fieldFocusNode,
          decoration: InputDecoration(
              labelText:    locale == "it_IT" ? "Inserisci un comune" : locale == "en_US"  ? "Search your location" : "Ingrese su dirección" ,   
              labelStyle: ThemeConfig.bodyText1.override(
                color: Color(0xFFB4B4B4),
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
              border: OutlineInputBorder(),
              isDense: true,
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 0.7)),
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color(0xFFB4B4B4), width: 0.7))),
          style: ThemeConfig.bodyText1,
        );
      },
    );
  }

  void autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value);
   
    if (result != null && result.predictions != null && mounted) {
      setState(() {
        predictions = result.predictions!;
      });
    }
  }
}
