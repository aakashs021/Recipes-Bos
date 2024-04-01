import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:projectweek1/Hive%20helper/Hive%20favourites/favfunctions.dart';
import 'package:projectweek1/Hive%20helper/Hive%20favourites/favourite_model.dart';
import 'package:projectweek1/Hive%20helper/Hive%20shopping/shopping_functions.dart';
import 'package:projectweek1/Hive%20helper/Hive%20shopping/shopping_model.dart';
import 'package:projectweek1/Hive%20helper/hive%20db/dbfunctions.dart';
import 'package:projectweek1/Hive%20helper/hive%20db/recipe_model.dart';
import 'package:projectweek1/Screens/Admin%20side/Admin%20category/admin_categoriespage.dart';
import 'package:projectweek1/Screens/Admin%20side/Admin%20recipe%20adding/firebasestoragefunctions.dart';
import 'package:projectweek1/Screens/Login%20pages/New%20user/new_user_login.dart';
import 'package:projectweek1/Screens/splash_screen.dart';

import 'package:projectweek1/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(FavouriteAdapter().typeId)) {
    Hive.registerAdapter(FavouriteAdapter());
  }

 if (!Hive.isAdapterRegistered(OwnrecipeAdapter().typeId)) {
    Hive.registerAdapter(OwnrecipeAdapter());
  } 
  if (!Hive.isAdapterRegistered(ShoppingAdapter().typeId)) {
    Hive.registerAdapter(ShoppingAdapter());
  } 

   await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await getshop();
  await getdetailsfromuserinmainpage();
  await getfavourite();
  await getrecipe();
  img = await Trending();
  runApp(const MyApp());
  firebasegetinglist();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Splashscreen());
  }
}
