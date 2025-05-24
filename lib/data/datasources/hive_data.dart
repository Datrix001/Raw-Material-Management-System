import 'dart:math';

import 'package:hive/hive.dart';

import 'package:rmms/data/models/hive_model.dart';

class HiveData {
  static Box<HiveModel>? _box;
  static Box<String>? _box1;

  static Future<void> init() async {
    Hive.registerAdapter(HiveModelAdapter());
    Hive.registerAdapter(InventoryModelAdapter());
    
    await Hive.openBox<InventoryModel>('inventory');
    _box = await Hive.openBox<HiveModel>('composition');
    _box1 = await Hive.openBox<String>('deleted_composition_ids');


  }

  String genrateUniqueId() {
    final random = Random().nextInt(10000);
    return "$random";
  }

  // Adding data to hive
  Future<void> addComposition(
    String id,
    String productName,
    int material1,
    int material2,
    int material3,
    int material4,
    bool isUpdate,
  ) async {
    final data = HiveModel()
      ..productName = productName
      ..material1 = material1
      ..material2 = material2
      ..material3 = material3
      ..material4 = material4
      ..id = id
      ..isSynced = false
      ..isUpdate = false;
    //test1
    await _box?.add(data);
    await _box?.flush();
  }

  // Getting all the data from hive
  List<HiveModel> getAllCompositions() {
    if (_box == null) return [];
    return _box!.values.toList();
  }

  // Updating data
  Future<void> updateComposition(
  String id, {
  required String productName,
  required int material1,
  required int material2,
  required int material3,
  required int material4,
  required bool isUpdate
}) async {
  if (_box == null) return;

  final keys = _box!.keys.toList();
  for (final key in keys) {
    final item = _box!.get(key);
    if (item?.id == id) {
      final updated = HiveModel()
        ..id = id
        ..productName = productName
        ..material1 = material1
        ..material2 = material2
        ..material3 = material3
        ..material4 = material4
        ..isSynced = false
        ..isUpdate = true;

      await _box!.put(key, updated);
      print("✅ Updated Hive item with id: $id");
      return;
    }
  }

  print("❌ Item not found with id: $id");
}


  // Deleting Data
  Future<void> deleteComposition(String id) async {
    if (_box == null) return;

    final index = _box!.values.toList().indexWhere((item) => item.id == id);
    if (index == -1) return;

    final key = _box!.keyAt(index);
    await _box!.delete(key);

    final deletedBox = await Hive.openBox<String>('deleted_composition_ids');
  await deletedBox.add(id); // Save ID for syncing deletion
  }
}
