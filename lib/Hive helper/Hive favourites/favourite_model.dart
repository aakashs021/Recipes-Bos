import 'package:hive_flutter/hive_flutter.dart';
part 'favourite_model.g.dart';

@HiveType(typeId: 1) 
class Favourite {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String foodname;
  @HiveField(2)
  final List<String> file;
  @HiveField(3)
  final String description;
  @HiveField(4)
  final List<String> ingredients;
  @HiveField(5)
  final List<String> direction;
  @HiveField(6)
  final int hour;
  @HiveField(7)
  final int min;
  @HiveField(8)
  final DateTime date;
  @HiveField(9)
  final String? uid;

  Favourite(
      {required this.id,
      required this.foodname,
      required this.file,
      required this.description,
      required this.ingredients,
      required this.direction,
      required this.hour,
      required this.date,
      required this.min,
      required this.uid}
      
      );
}
