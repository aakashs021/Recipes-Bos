import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:projectweek1/Hive%20helper/Hive%20favourites/favourite_model.dart';
import 'package:projectweek1/Screens/Login%20pages/Normal%20login/main_login.dart';

const String favdb = "favourite";
ValueNotifier<List<Favourite>> favlist = ValueNotifier([]);
addfavourite({required Favourite favor}) async {
  final box = await Hive.openBox<Favourite>(favdb);
  await box.put(favor.id, favor);
}

getfavourite() async {
  favlist.value.clear();
  
  final box = await Hive.openBox<Favourite>(favdb);
  
  // favlist.value = box.values.toList();
   Future.forEach(box.values, (element)  {
    if(element.uid==useremail){
      favlist.value.add(element);
    }
  });
 favlist.notifyListeners();
}
deletefavorite({required Favourite favourite})async{
final box= await Hive.openBox<Favourite>(favdb);
await box.delete(favourite.id);
}
