

import 'package:hive_flutter/hive_flutter.dart';
import 'package:projectweek1/Hive%20helper/Hive%20shopping/shopping_model.dart';
List<Shopping> shoppinglisthive=[];
const String shopdb = "shopping";
addshop({required Shopping shopping})async{
  final box= await Hive.openBox<Shopping>(shopdb);
 await box.put(shopping.id, shopping);

}
getshop()async{
final box= await Hive.openBox<Shopping>(shopdb);
shoppinglisthive=box.values.toList();
}
updateshop({required Shopping shop})async{
  final box= await Hive.openBox<Shopping>(shopdb);
  box.put(shop.id, shop);

}
deleteshop({required String shop})async{
   final box= await Hive.openBox<Shopping>(shopdb);
   box.delete(shop);
}