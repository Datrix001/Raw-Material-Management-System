
import 'package:hive/hive.dart';


class CompositionModel {
  static final  String productName = "Product_Name";
  static final  String material1 = "Material1";
  static final  String material2 = "Material2";
  static final  String material3 = "Material3";
  static final  String material4 = "Material4";

  static List<String> getField() => [productName,material1,material2,material3,material4];



  // final String productNameValue;
  // final int material1Value;
  // final int material2Value;
  // final int material3Value;
  // final int material4Value;

  // CompositionModel({

  //   required this.productNameValue,
  //   required this.material1Value,
  //   required this.material2Value,
  //   required this.material3Value,
  //   required this.material4Value,
  // });

  // List<String> toSheetRow() => [
  //   productNameValue,
  //   material1Value.toString(),
  //   material2Value.toString(),
  //   material3Value.toString(),
  //   material4Value.toString(),
  // ];
}


