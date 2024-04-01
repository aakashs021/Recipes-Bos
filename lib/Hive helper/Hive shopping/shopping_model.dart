import 'package:hive_flutter/hive_flutter.dart';
 part 'shopping_model.g.dart';
@HiveType(typeId: 3)
class Shopping{
  @HiveField(0)
   String id;
  @HiveField(1)
   String shoppinlist;
  @HiveField(2)
   bool customcheckbox;
  @HiveField(3)
  int count;

Shopping({required this.id, required this.shoppinlist,required this.customcheckbox,required this.count});
}