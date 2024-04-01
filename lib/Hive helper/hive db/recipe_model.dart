import 'package:hive_flutter/hive_flutter.dart';
// import 'package:image_picker/image_picker.dart';
 part 'recipe_model.g.dart';
@HiveType(typeId: 2)
class Ownrecipe {
  @HiveField(0)
  String id;
  @HiveField(1)
  String foodname;
  @HiveField(2)
  String? description;
  @HiveField(3)
  List<String>? file;
  @HiveField(4)
  List<String>? ingredients;
  @HiveField(5)
  List<String>? direction;
  @HiveField(6)
  int? hour;
  @HiveField(7)
  int? min;
  @HiveField(8)
  DateTime datetime;
  @HiveField(9)
  String? uid;
  Ownrecipe(
      {required this.id,
      required this.description,
      required this.foodname,
      required this.file,
      required this.ingredients,
      required this.direction,
      required this.min,
      required this.hour,
     required this.uid,
      required this.datetime});
}
