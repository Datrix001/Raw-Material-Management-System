import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:rmms/data/datasources/gsheet.dart';
import 'package:rmms/presentation/bloc/inventory_cubit.dart';

class SyncService {
  static Timer? _timer;

  static void startSyncing({
    required InventoryCubit cubit,
    Duration interval = const Duration(minutes: 2)}) {
    _timer?.cancel();
    _timer = Timer.periodic(interval, (timer) async {
      try {
        print('Timer callback fired');
        final isConnected = await _checkInternetConnection();
        if (isConnected) {
          print('Synching Starting!!!!');
          await Gsheet().syncAll(cubit:cubit);
          // await Gsheet().fetchInventoryData();
        } else {
          print('No internet connection!!!!!!!');
        }
      } catch (e, stackTrace) {
        print('Error in timer callback: \$e');
        print(stackTrace);
      }
    });
  }

  static void stopSyncing() {
    _timer?.cancel();
    _timer = null;
  }

  static Future<bool> _checkInternetConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }
}
