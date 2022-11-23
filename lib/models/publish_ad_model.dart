import 'package:horecah/models/products/products.dart';
import 'package:horecah/shared/catalogs/list_enums.dart';

class PublishAdModel {
  PublishAdModel({
    required this.currentCategory,
    required this.currenTypeAd,
    required this.currentSubCategory,
  });

  EnumCategoryList currentCategory;
  EnumTypeAdList currenTypeAd;
  EnumSubCategoryList currentSubCategory;
  Products? product;
}
