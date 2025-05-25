import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:rmms/data/models/hive_model.dart';
import 'package:rmms/presentation/bloc/inventory_cubit.dart';

class Gsheet {
  static const _scriptUrl =
      'https://script.google.com/macros/s/AKfycbxIB91pKlVwkTUgYaDf1cmx53o-o3ZPF8QtlYG7SA556RAgap9cSaQ1vZqWdpt5J2W-/exec';

  Future<void> syncToGoogleSheets() async {
    final box = Hive.box<HiveModel>('composition');

    for (int i = 0; i < box.length; i++) {
      final key = box.keyAt(i);
      final item = box.get(key);

      if (item != null && (item.isSynced ?? false) == false) {
        final response = await http.post(
          Uri.parse(_scriptUrl),
          body: {
            'type': 'composition_sheet',
            'id': item.id,
            'product': item.productName,
            'material1': item.material1.toString(),
            'material2': item.material2.toString(),
            'material3': item.material3.toString(),
            'material4': item.material4.toString(),
          },
        );

        final updatedItem = HiveModel()
          ..id = item.id
          ..productName = item.productName
          ..material1 = item.material1
          ..material2 = item.material2
          ..material3 = item.material3
          ..material4 = item.material4
          ..isSynced = true
          ..isUpdate = false;
        await box.put(key, updatedItem);
      }
    }
  }

  Future<void> updateGoogleSheet() async {
    final box = Hive.box<HiveModel>('composition');

    for (int i = 0; i < box.length; i++) {
      final key = box.keyAt(i);
      final item = box.get(key);

      if (item != null && (item.isUpdate ?? false) == true) {
        final response = await http.post(
          Uri.parse(_scriptUrl),

          body: {
            'type': 'update_sheet',
            'id': item.id,
            'product': item.productName,
            'material1': item.material1.toString(),
            'material2': item.material2.toString(),
            'material3': item.material3.toString(),
            'material4': item.material4.toString(),
          },
        );
        final updatedItem = HiveModel()
          ..id = item.id
          ..productName = item.productName
          ..material1 = item.material1
          ..material2 = item.material2
          ..material3 = item.material3
          ..material4 = item.material4
          ..isSynced = true
          ..isUpdate = false;

        await box.put(key, updatedItem);
      }
    }
  }

  Future<void> inventoryUpdate() async {
    final box = Hive.box<InventoryModel>('inventory');

    for (int i = 0; i < box.length; i++) {
      final key = box.keyAt(i);
      final item = box.get(key);

      if (item != null) {
        final response = await http.post(
          Uri.parse(
            "https://script.googleusercontent.com/macros/echo?user_content_key=AehSKLj3XusMsfa80-XxOgsabPNtqBwrlDGESm1xc1FxLnvfqJM5yq03YtoJubpwLjSmRHUnLM6zVeqMJUYb54xwVaxX8tgNB4eXOfUrg1tgW3Y5NKt7s2OlgPsZPyOWKc48w3yTtVfA0Pco8Joa8C1oD6_fZO3GVYKcAs9FjVROe_6uItB9_sZE_Iw7zysRhnajLXMjdd_RWKtM9o04IMsej2Nu88YMQrKJxJop9E8uhMKpMnNGmv-eyTMHs26rsDRwCJHqfEnrLBlkrFZV9HmfQXlFHUsQYGDtkQSUlgsHjbFAUotfBM72Tcjd2awFBg&lib=M9fFx6F6zr4n2CkLKlKt7Z4JaLnrymLVK",
          ),

          body: {
            'type': 'update_sheet',
            'material': item.material,
            'quantity': item.quantity.toString(),
            'threshold':item.threshold?.toString() ??'20'
          },
        );
      }
    }
  }

  Future<void> fetchInventoryFromGoogleSheets() async {
    try {
      final response = await http.get(
        Uri.parse(
          "https://script.googleusercontent.com/macros/echo?user_content_key=AehSKLj3XusMsfa80-XxOgsabPNtqBwrlDGESm1xc1FxLnvfqJM5yq03YtoJubpwLjSmRHUnLM6zVeqMJUYb54xwVaxX8tgNB4eXOfUrg1tgW3Y5NKt7s2OlgPsZPyOWKc48w3yTtVfA0Pco8Joa8C1oD6_fZO3GVYKcAs9FjVROe_6uItB9_sZE_Iw7zysRhnajLXMjdd_RWKtM9o04IMsej2Nu88YMQrKJxJop9E8uhMKpMnNGmv-eyTMHs26rsDRwCJHqfEnrLBlkrFZV9HmfQXlFHUsQYGDtkQSUlgsHjbFAUotfBM72Tcjd2awFBg&lib=M9fFx6F6zr4n2CkLKlKt7Z4JaLnrymLVK",
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);

        final inventoryBox = await Hive.openBox<InventoryModel>('inventory');
        await inventoryBox.clear();

        for (var item in jsonData) {
          final inventoryItem = InventoryModel(
            material: item['material'],
            quantity: int.tryParse(item['quantity'].toString()) ?? 0,
            threshold: int.tryParse(item['threshold'].toString()) ?? 0,
          );

          await inventoryBox.add(inventoryItem);
        }

        print("✅ Inventory data successfully fetched and saved to Hive.");
      } else {
        print(
          "❌ Failed to fetch inventory data. Status code: ${response.statusCode}",
        );
      }
    } catch (e) {
      print("❌ Error fetching inventory data: $e");
    }
  }

  Future<void> syncAll({required InventoryCubit cubit}) async {
    await Hive.openBox<String>('deleted_composition_ids');

    // await syncToGoogleSheets();
    await updateGoogleSheet();
    await inventoryUpdate();
    // InventoryCubit().refresh();
    cubit.refresh();
    // await deleteSync();
  }
}
