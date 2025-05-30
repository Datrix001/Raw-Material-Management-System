import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmms/data/datasources/hive_data.dart';
import 'package:rmms/data/models/hive_model.dart';

class InventoryCubit extends Cubit<List<InventoryModel>> {
  InventoryCubit() : super([]) {
    loadAllData();
  }

  void loadAllData() {
    final compositions = HiveData().fetchData();
    emit(compositions);
  }

  Future<void> updateInventoryComposition(
    Map<String, dynamic> productDetail,
  ) async {
    await HiveData().inventoryUpdate(
      material: productDetail['material'],
      quantity: productDetail['quantity'],
    );
    loadAllData();
  }


  void refresh() {
    loadAllData();
  }

  // Your existing methods...
}
