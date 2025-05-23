import 'dart:math';

import 'package:hive/hive.dart';

import 'package:rmms/data/models/hive_model.dart';

class HiveData {
  static Box<HiveModel>? _box;

  static Future<void> init() async {
    Hive.registerAdapter(HiveModelAdapter());
    _box = await Hive.openBox<HiveModel>('composition');
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
  ) async {
    final data = HiveModel()
      ..productName = productName
      ..material1 = material1
      ..material2 = material2
      ..material3 = material3
      ..material4 = material4
      ..id = id
      ..isSynced = false;
//test1
    await _box?.add(data);
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
  }) async {
    if (_box == null) return;

    final index = _box!.values.toList().indexWhere((item) => item.id == id);
    if (index == -1) return;

    final key = _box!.keyAt(index);
    final updated = HiveModel()
      ..productName = productName
      ..material1 = material1
      ..material2 = material2
      ..material3 = material3
      ..material4 = material4
      ..id = id;

    await _box!.put(key, updated);
  }

  // Deleting Data
  Future<void> deleteComposition(String id) async {
    if (_box == null) return;

    final index = _box!.values.toList().indexWhere((item) => item.id == id);
    if (index == -1) return;

    final key = _box!.keyAt(index);
    await _box!.delete(key);
  }

}
