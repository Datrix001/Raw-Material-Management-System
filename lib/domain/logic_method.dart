import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:rmms/data/models/hive_model.dart';

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

    // Define material names in order
    final materialNames = ['Iron', 'Copper', 'Steel', 'Plastic'];

    // Map material names to the quantity required per product
    final materialMap = {
      materialNames[0]: product.material1,
      materialNames[1]: product.material2,
      materialNames[2]: product.material3,
      materialNames[3]: product.material4,
    };

    // Step 1: Check inventory availability
    for (final entry in materialMap.entries) {
      final materialName = entry.key;
      final requiredQty = entry.value * quantity;

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

      if (inv.quantity < requiredQty) {
        return InventoryResult(
          success: false,
          message: "❌ Not enough stock for $materialName.",
          color: Colors.red,
        );
      }
    }

    // Step 2: Deduct inventory
    for (final entry in materialMap.entries) {
      final materialName = entry.key;
      final requiredQty = entry.value * quantity;

      final index = inventoryBox.values.toList().indexWhere(
        (inv) => inv.material == materialName,
      );

      final inv = inventoryBox.getAt(index)!;
      final newQty = inv.quantity - requiredQty;

      await inventoryBox.putAt(
        index,
        InventoryModel(
          material: inv.material,
          quantity: newQty < 0 ? 0 : newQty,
          threshold: inv.threshold,
        ),
      );
    }

    // Step 3: Check for low or out-of-stock materials
    List<String> lowStock = [];
    List<String> outOfStock = [];

    for (final entry in materialMap.entries) {
      final materialName = entry.key;
      final inv = inventoryBox.values.firstWhereOrNull(
        (inv) => inv.material == materialName,
      );

      if (inv != null) {
        if (inv.quantity <= 0) {
          outOfStock.add(inv.material);
        } else if (inv.quantity < (inv.threshold ?? 0)) {
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

  // Utility function to fetch all inventory
  Future<List<InventoryModel>> getData() async {
    final box = await Hive.openBox<InventoryModel>('inventory');
    return box.values.toList();
  }
}
