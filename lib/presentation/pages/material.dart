import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:rmms/data/datasources/gsheet.dart';
import 'package:rmms/data/models/hive_model.dart';
import 'package:rmms/presentation/components/custom_button.dart';
import 'package:rmms/presentation/components/dropdown.dart';
import 'package:rmms/presentation/components/product_dropdown.dart';
import 'package:rmms/presentation/utils/fonts.dart';

class MaterialLayer extends StatefulWidget {
  const MaterialLayer({super.key});

  @override
  State<MaterialLayer> createState() => _MaterialLayerState();
}

class _MaterialLayerState extends State<MaterialLayer> {
  bool isSyncing = false;
  String syncStatus = "";

  bool isUpdate = true;

  String? selectedProduct;
  int selectedQuantity = 1;

  List<String> manufacturingLog = [];

  Future<void> deductInventory(String productName, int quantity) async {
    final compositionBox = await Hive.openBox<HiveModel>('composition');
    final inventoryBox = await Hive.openBox<InventoryModel>('inventory');

    final products = compositionBox.values.where(
      (item) => item.productName == productName,
    );
    final product = products.isEmpty ? null : products.first;

    if (product == null) {
      setState(() {
        syncStatus = "❌ Product not found in composition.";
      });
      return;
    }

    // Materials list may contain nulls, filter them out
    final materials = [
      product.material1,
      product.material2,
      product.material3,
      product.material4,
    ].whereType<String>().toList();

    for (String material in materials) {
      final index = inventoryBox.values.toList().indexWhere(
        (inv) => inv.material == material,
      );
      if (index != -1) {
        final inv = inventoryBox.getAt(index);
        if (inv == null) continue;

        final newQty = inv.quantity - quantity;

        final updated = InventoryModel(
          material: inv.material,
          quantity: newQty < 0 ? 0 : newQty,
          threshold: inv.threshold,
        );

        await inventoryBox.putAt(index, updated);
      }
    }

    // Check for low stock
    final lowStock = inventoryBox.values
        .where((inv) => inv.quantity < inv.threshold)
        .map((inv) => inv.material)
        .toList();

    if (lowStock.isNotEmpty) {
      setState(() {
        syncStatus = "⚠️ Low stock: ${lowStock.join(', ')}";
      });
    } else {
      setState(() {
        syncStatus = "✅ Inventory updated successfully!";
      });
    }
  }

  Future<void> syncData() async {
    setState(() {
      isSyncing = true;
      syncStatus = "Syncing...";
    });

    try {
      await Gsheet().syncToGoogleSheets();
      setState(() {
        isSyncing = false;
        syncStatus = "✅ Synced successfully!";
      });
    } catch (e) {
      setState(() {
        isSyncing = false;
        syncStatus = "❌ Sync failed: $e";
      });
    }
  }

  Future<void> updateData() async {
    setState(() {
      isUpdate = true;
      syncStatus = "Updating...";
    });

    try {
      await Gsheet().UpdateGoogleSheet();
      setState(() {
        syncStatus = "✅ Updated successfully!";
      });
    } catch (e) {
      setState(() {
        syncStatus = "❌ Update failed: $e";
      });
    } finally {
      setState(() {
        isUpdate = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Column(
        children: [
          Container(
            height: 500,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  ProductDropdown(
                    label: "Select Product",
                    onchanged: (val) {
                      setState(() {
                        selectedProduct = val;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomDropdown(
                    label: "Select Amount",
                    onchanged: (val) {
                      // val could be dynamic, cast to string safely
                      final strVal = val.toString() ?? "1";
                      setState(() {
                        selectedQuantity = int.tryParse(strVal) ?? 1;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomButton(
                    function: () async {
                      if (selectedProduct == null || selectedProduct!.isEmpty) {
                        setState(() {
                          syncStatus = "Please select a product.";
                        });
                        return;
                      }
                      if (selectedQuantity <= 0) {
                        setState(() {
                          syncStatus = "Please select a valid quantity.";
                        });
                        return;
                      }

                      
                      await deductInventory(selectedProduct!, selectedQuantity);

                      setState(() {
                        manufacturingLog.add(
                          "$selectedQuantity units of $selectedProduct manufactured",
                        );
                      });

                    },
                    name: "Save",
                    color: Colors.green,
                  ),

                  const SizedBox(height: 10),
                  isSyncing
                      ? const CircularProgressIndicator()
                      : Column(
                          children: [
                            CustomButton(
                              function: syncData,
                              name: "Refresh",
                              color: Colors.lightBlue,
                            ),
                            CustomButton(
                              function: updateData,
                              name: "Update",
                              color: Colors.orange,
                            ),
                          ],
                        ),
                  const SizedBox(height: 5),
                  Text(syncStatus, style: CustomFonts.body1Black),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          Align(
            alignment: Alignment.topLeft,
            child: Text("Manufacturing Log", style: CustomFonts.title1),
          ),
          SizedBox(height: 10),
          Expanded(
            child: Container(
              height: 200, 
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: manufacturingLog.isEmpty
                  ? Center(child: Text("No manufacturing logs yet"))
                  : ListView.builder(
                      itemCount: manufacturingLog.length,
                      itemBuilder: (context, index) {
                        return ListTile(title: Text(manufacturingLog[index]));
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
