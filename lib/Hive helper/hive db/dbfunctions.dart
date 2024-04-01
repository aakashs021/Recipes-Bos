import 'package:hive_flutter/hive_flutter.dart';
import 'package:projectweek1/Hive%20helper/hive%20db/recipe_model.dart';
import 'package:projectweek1/Screens/Login%20pages/Normal%20login/main_login.dart';

String ownrecipedb = 'ownrecipe';
List<Ownrecipe> recipelist = [];
addrecipe({required Ownrecipe own}) async {
  final box = await Hive.openBox(ownrecipedb);
  await box.put(own.id, own);
}

getrecipe() async {
  recipelist.clear();
  final box = await Hive.openBox(ownrecipedb);
  Future.forEach(box.values, (element) {
    if (element.uid == useremail) {
      recipelist.add(element);
    }
  });
}

deleterecipe({required Ownrecipe own}) async {
  final box = await Hive.openBox(ownrecipedb);
  box.delete(own.id);
}
