import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmms/data/datasources/hive_data.dart';
import 'package:rmms/data/models/hive_model.dart';
import 'package:rmms/data/datasources/gsheet.dart';

class CompCubit extends Cubit<List<HiveModel>> {
  CompCubit() : super([]) {
    loadCompositions();
  }
  void loadCompositions() {
    final compositions = HiveData().getAllCompositions();
    emit(compositions);
  }

  Future<void> addComposition(Map<String, dynamic> productDetail) async {
    await HiveData().addComposition(
      productDetail['id'],
      productDetail['productName'],
      productDetail['material1'],
      productDetail['material2'],
      productDetail['material3'],
      productDetail['material4'],
      false
    );
    Gsheet().syncToGoogleSheets();
    loadCompositions();
  }

  Future<void> getCompositions() async {
    final compositions = HiveData().getAllCompositions();
    emit(compositions);
  }

  Future<void> deleteComposition(String id) async {
    await HiveData().deleteComposition(id);
    loadCompositions();
  }

  Future<void> editComposition(Map<String, dynamic> productDetail) async {
    await HiveData().updateComposition(
      productDetail['id'],
      productName: productDetail['productName'],
      material1: productDetail['material1'],
      material2: productDetail['material2'],
      material3: productDetail['material3'],
      material4: productDetail['material4'],
      isUpdate: true
    );
    loadCompositions();
  }

  

}
