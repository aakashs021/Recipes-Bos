import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:projectweek1/Firebase%20helper/firebase_adminrec3.dart';
import 'package:projectweek1/Hive%20helper/Hive%20favourites/favfunctions.dart';
import 'package:projectweek1/Hive%20helper/Hive%20favourites/favourite_model.dart';
import 'package:projectweek1/Hive%20helper/hive%20db/dbfunctions.dart';
import 'package:projectweek1/Hive%20helper/hive%20db/recipe_model.dart';
import 'package:projectweek1/Screens/Login%20pages/New%20user/new_user_login.dart';
import 'package:projectweek1/Screens/User%20side/Page2%20user/cate3trial.dart';
import 'package:projectweek1/Screens/User%20side/Page5.dart/userrecipedetail.dart';

int val = 0;

class Usersaverecipe extends StatefulWidget {
  const Usersaverecipe({super.key});

  @override
  State<Usersaverecipe> createState() => _UsersaverecipeState();
}

class _UsersaverecipeState extends State<Usersaverecipe>
    with SingleTickerProviderStateMixin {
  bool loading = true;
  late TabController t;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listing();
    t = TabController(length: 2, vsync: this, initialIndex: val);
  }

  listing() async {
    await getfavourite();
    loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: text(name: 'Favourites'),
        // ),
        body: Column(
      children: [
        Container(
          child: TabBar(
              unselectedLabelColor: Colors.black,
              labelColor: Colors.blue.shade300,
              indicatorColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.tab,
              controller: t,
              onTap: (value) {
                setState(() {
                  val = value;
                });
              },
              tabs: const [
                Tab(
                  text: 'Your own recipe',
                ),
                Tab(
                  text: 'Favourites',
                )
              ]),
        ),
        Expanded(
          child: TabBarView(controller: t, children: [
            Container(
              child: recipelist.isEmpty
                  ? Center(
                      child: text(name: 'No data found'),
                    )
                  : ListView.builder(
                      itemCount: recipelist.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                Ownrecipe own = Ownrecipe(
                                    id: recipelist[index].id,
                                    description: recipelist[index].description,
                                    foodname: recipelist[index].foodname,
                                    file: recipelist[index].file,
                                    ingredients: recipelist[index].ingredients,
                                    direction: recipelist[index].direction,
                                    min: recipelist[index].min,
                                    hour: recipelist[index].hour,
                                    uid: recipelist[index].uid,
                                    datetime: recipelist[index].datetime);
                                return Userrecipedetail(
                                    foodid: own.id,
                                    description: own.description,
                                    min: own.min,
                                    hour: own.hour,
                                    ingredients: own.ingredients,
                                    foodname: own.foodname,
                                    foodphotolist: own.file,
                                    direction: own.direction);
                              },
                            ));
                          },
                          child: Card(
                            color: Colors.white,
                            margin:
                                EdgeInsets.only(top: 15, left: 20, right: 20),
                            elevation: 10,
                            child: Container(
                              // decoration: BoxDecoration(),
                              margin: EdgeInsets.all(10),
                              height: 225,
                              child: Stack(
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: recipelist[index].file![0] !=
                                              'assets/images/11861789_7575.jpg'
                                          ? Image.file(
                                              File(recipelist[index].file![0]),
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            )
                                          : Center(
                                              child: Column(
                                                children: [
                                                  Lottie.asset(
                                                      'assets/images/no image found.json'),
                                                  text(name: 'No image found')
                                                ],
                                              ),
                                            )
                                      // Image.asset(
                                      //     'assets/images/11861789_7575.jpg',
                                      //     width: double.infinity,
                                      //     fit: BoxFit.cover,
                                      //   ),
                                      ),
                                  Container(
                                    color: Color.fromARGB(120, 255, 255, 255),
                                    width: double.infinity,
                                    height: 50,
                                  ),
                                  Positioned(
                                      right: 0,
                                      child: IconButton(
                                          onPressed: () async {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: text(
                                                      name:
                                                          'Are you sure you want to delete ${recipelist[index].foodname}'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () async {
                                                        Ownrecipe own = Ownrecipe(
                                                            id: recipelist[index]
                                                                .id,
                                                            description:
                                                                recipelist[index]
                                                                    .description,
                                                            foodname:
                                                                recipelist[index]
                                                                    .foodname,
                                                            file:
                                                                recipelist[index]
                                                                    .file,
                                                            ingredients:
                                                                recipelist[index]
                                                                    .ingredients,
                                                            direction:
                                                                recipelist[index]
                                                                    .direction,
                                                            min:
                                                                recipelist[index]
                                                                    .min,
                                                            hour: recipelist[
                                                                    index]
                                                                .hour,
                                                            uid: recipelist[
                                                                    index]
                                                                .uid,
                                                            datetime:
                                                                recipelist[index]
                                                                    .datetime);
                                                        await deleterecipe(
                                                            own: own);
                                                        await getrecipe();
                                                        setState(() {});
                                                        navigatorpop(context);
                                                      },
                                                      child: text(name: 'Yes'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        navigatorpop(context);
                                                      },
                                                      child: text(name: 'No'),
                                                    )
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          icon: Icon(Icons.delete))),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, top: 10),
                                    child:
                                        text(name: recipelist[index].foodname),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
            lastpagefac(
                loading: loading,
                set: () {
                  setState(() {});
                })
            // loading
            //     ? Center(child: CircularProgressIndicator())
            //     : ValueListenableBuilder(
            //         valueListenable: favlist,
            //         builder: (context, value, child) {
            //           return favlist.value.isEmpty
            //               ? Center(
            //                   child: text(name: 'No data added'),
            //                 )
            //               : ListView.builder(
            //                   itemCount: favlist.value.length,
            //                   itemBuilder: (context, index) {
            //                     return InkWell(
            //                       onTap: () {
            //                         Navigator.of(context)
            //                             .push(MaterialPageRoute(
            //                           builder: (context) =>
            //                               Userfullreciptrial(
            //                                   foodid:
            //                                       favlist.value[index].id,
            //                                   category: favlist
            //                                       .value[index].foodname,
            //                                   description: favlist
            //                                       .value[index].description,
            //                                   hour:
            //                                       favlist.value[index].hour,
            //                                   min: favlist.value[index].min,
            //                                   direction: favlist
            //                                       .value[index].direction,
            //                                   ingredients: favlist
            //                                       .value[index].ingredients,
            //                                   foodname: favlist
            //                                       .value[index].foodname,
            //                                   editindex: index,
            //                                   foodphotolist: favlist
            //                                       .value[index].file),
            //                         ));
            //                         print(favlist.value[index].description);
            //                       },
            //                       child: Container(
            //                         margin: EdgeInsets.all(10),
            //                         height: 225,
            //                         child: Stack(
            //                           children: [
            //                             ClipRRect(
            //                               borderRadius:
            //                                   BorderRadius.circular(20),
            //                               child: CachedNetworkImage(
            //                                 imageUrl: favlist
            //                                     .value[index].file[0],
            //                                 width: double.infinity,
            //                                 fit: BoxFit.cover,
            //                                 placeholder: (context, url) {
            //                                   return Image.asset(
            //                                     'assets/images/11861789_7575.jpg',
            //                                     width: double.infinity,
            //                                     fit: BoxFit.cover,
            //                                   );
            //                                 },
            //                               ),
            //                             ),
            //                             text(
            //                                 name: favlist
            //                                     .value[index].foodname,
            //                                 colour: Colors.white),
            //                             Positioned(
            //                                 right: 0,
            //                                 child: IconButton(
            //                                     onPressed: () async {
            //                                       await deletefavorite(
            //                                           favourite: favlist
            //                                               .value[index]);
            //                                       await getfavourite();
            //                                       setState(() {});
            //                                     },
            //                                     icon: Icon(
            //                                       Icons.favorite,
            //                                       color: Colors.red,
            //                                     )))
            //                           ],
            //                         ),
            //                       ),
            //                     );
            //                   },
            //                 );
            //         },
            //       )
          ]),
        ),
      ],
    ));
  }
}

Widget lastpagefac({required bool loading, required Function set}) {
  return loading
      ? Center(child: CircularProgressIndicator())
      : ValueListenableBuilder(
          valueListenable: favlist,
          builder: (context, value, child) {
            return favlist.value.isEmpty
                ? Center(
                    child: text(name: 'No data added'),
                  )
                : ListView.builder(
                    itemCount: favlist.value.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Userfullreciptrial(
                                foodid: favlist.value[index].id,
                                category: favlist.value[index].foodname,
                                description: favlist.value[index].description,
                                hour: favlist.value[index].hour,
                                min: favlist.value[index].min,
                                direction: favlist.value[index].direction,
                                ingredients: favlist.value[index].ingredients,
                                foodname: favlist.value[index].foodname,
                                editindex: index,
                                foodphotolist: favlist.value[index].file),
                          ));
                          print(favlist.value[index].description);
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          height: 225,
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: CachedNetworkImage(
                                  imageUrl: favlist.value[index].file[0],
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) {
                                    return Image.asset(
                                      'assets/images/11861789_7575.jpg',
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 10),
                                child: text(
                                    name: favlist.value[index].foodname,
                                    colour: Colors.white),
                              ),
                              Positioned(
                                  right: 0,
                                  child: IconButton(
                                      onPressed: () async {
                                        await deletefavorite(
                                            favourite: favlist.value[index]);
                                        await getfavourite();
                                        set();
                                      },
                                      icon: Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                      )))
                            ],
                          ),
                        ),
                      );
                    },
                  );
          },
        );
}
