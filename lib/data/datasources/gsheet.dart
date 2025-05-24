import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:rmms/data/models/hive_model.dart';

class Gsheet {
  Future<void> syncToGoogleSheets() async {
    final box = Hive.box<HiveModel>('composition');
    

    for (int i = 0; i < box.length; i++) {
      final key = box.keyAt(i);
      final item = box.get(key);

      if (item != null && item.isSynced == false) {
        final response = await http.post(
          Uri.parse('https://script.google.com/macros/s/AKfycbzrkWfoz3C2-QZNIUKNRr2phUMJgZzu-1M0XRfQmansV71jIX35eDvSdVSKJfnwWp7M/exec'),
          body: {
            'type':'composition_sheet',
            'id': item.id,
            'product': item.productName,
            'material1': item.material1.toString(),
            'material2': item.material2.toString(),
            'material3': item.material3.toString(),
            'material4': item.material4.toString(),
          },
        );

        if (response.statusCode == 200) {
          final updatedItem = item..isSynced = true;
          print('Syncing item: ${item.id}, product: ${item.productName}');

          await box.put(key, updatedItem);
        } else {
          print("Sync failed for item ${item.id}: ${response.body}");
        }
      }
    }
  }
}
