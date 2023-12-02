import 'package:hive/hive.dart';
part 'data_model.g.dart';

@HiveType(typeId: 1)
class MoneyModel extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  String explain;
  @HiveField(2)
  String amount;
  @HiveField(3)
  String type;
  @HiveField(4)
  DateTime datetime;
  @HiveField(5)
  String id;

  MoneyModel(
    {required this.type, 
    required this.amount, 
    required this.datetime, 
    required this.explain, 
    required this.name,
    required this.id});
}
