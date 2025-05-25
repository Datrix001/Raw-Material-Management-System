import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:rmms/data/models/hive_model.dart';
// import 'package:rmms/data/models/inventory_result.dart'; // <-- Import this

class InventoryResult {
  final bool success;
  final String message;
  final Color color;

  InventoryResult({
    required this.success,
    required this.message,
    required this.color,
  });
}

class InventoryService {
  static Future<InventoryResult> deductInventory({
    required String productName,
    required int quantity,
  }) async {
    final compositionBox = await Hive.openBox<HiveModel>('composition');
    final inventoryBox = await Hive.openBox<InventoryModel>('inventory');

    final HiveModel? product = compositionBox.values
        .cast<HiveModel>()
        .firstWhereOrNull((item) => item.productName == productName);

    if (product == null) {
      return InventoryResult(
        success: false,
        message: "❌ Product not found in composition data.",
        color: Colors.red,
      );
    }

    final materials = {
      product.material1,
      product.material2,
      product.material3,
      product.material4,
    }.whereType<String>();

    for (final materialName in materials) {
      final inv = inventoryBox.values.firstWhereOrNull(
        (inv) => inv.material == materialName,
      );
      if (inv == null) {
        return InventoryResult(
          success: false,
          message: "❌ Material $materialName not found in inventory.",
          color: Colors.red,
        );
      }
      if (inv.quantity < quantity) {
        return InventoryResult(
          success: false,
          message: "❌ Not enough stock for $materialName.",
          color: Colors.red,
        );
      }
    }

    for (final materialName in materials) {
      final index = inventoryBox.values.toList().indexWhere(
        (inv) => inv.material == materialName,
      );
      final inv = inventoryBox.getAt(index)!;
      final newQty = inv.quantity - quantity;

      await inventoryBox.putAt(
        index,
        InventoryModel(
          material: inv.material,
          quantity: newQty < 0 ? 0 : newQty,
          threshold: inv.threshold,
        ),
      );
    }

    List<String> lowStock = [];
    List<String> outOfStock = [];

    for (final materialName in materials) {
      final inv = inventoryBox.values.firstWhereOrNull(
        (inv) => inv.material == materialName,
      );
      if (inv != null) {
        if (inv.quantity <= 0) {
          outOfStock.add(inv.material);
        } else if (inv.quantity < inv.threshold) {
          lowStock.add(inv.material);
        }
      }
    }

    if (outOfStock.isNotEmpty) {
      return InventoryResult(
        success: true,
        message: "❌ Out of stock: ${outOfStock.join(', ')}",
        color: Colors.red,
      );
    } else if (lowStock.isNotEmpty) {
      return InventoryResult(
        success: true,
        message: "⚠️ Low stock warning: ${lowStock.join(', ')}",
        color: Colors.orange,
      );
    }

    return InventoryResult(
      success: true,
      message: "✅ Inventory updated successfully!",
      color: Colors.green,
    );
  }

  Future<List<InventoryModel>> getData()async{
    final box = await Hive.openBox<InventoryModel>('inventory');
    return box.values.toList();
  }


}
