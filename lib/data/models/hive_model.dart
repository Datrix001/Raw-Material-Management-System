import 'package:hive/hive.dart';

part 'hive_model.g.dart';

@HiveType(typeId: 0)
class HiveModel extends HiveObject{
  @HiveField(0)
  late String productName;

  @HiveField(1)
  late int material1;

  @HiveField(2)
  late int material2;

  @HiveField(3)
  late int material3;

  @HiveField(4)
  late int material4;

  @HiveField(5)
  late bool isSynced = false;

  @HiveField(6)
  late String id;



  
}