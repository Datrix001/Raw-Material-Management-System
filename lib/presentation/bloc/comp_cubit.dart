import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmms/data/datasources/hive_data.dart';
import 'package:rmms/data/models/hive_model.dart';

class CompCubit extends Cubit<List<HiveModel>> {
  CompCubit() : super([]){
    loadCompositions();
  }

  void loadCompositions(){
    final compositions = HiveData().getAllCompositions();
    emit(compositions); 
  }

  Future<void> addComposition(Map<String, dynamic> productDetail)async {
    await HiveData().addComposition(
      productDetail['id'],
      productDetail['productName'],
      productDetail['material1'],
      productDetail['material2'],
      productDetail['material3'],
      productDetail['material4'],
    );

    loadCompositions();
  }
}
