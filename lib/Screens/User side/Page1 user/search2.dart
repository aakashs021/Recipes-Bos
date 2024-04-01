import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projectweek1/Hive%20helper/Hive%20favourites/favfunctions.dart';
import 'package:projectweek1/Hive%20helper/Hive%20favourites/favourite_model.dart';
import 'package:projectweek1/Screens/Login%20pages/New%20user/new_user_login.dart';
import 'package:projectweek1/Screens/Login%20pages/Normal%20login/main_login.dart';
import 'package:projectweek1/Screens/User%20side/Page2%20user/cate3trial.dart';

class Usersearchpage2 extends StatefulWidget {
  List<Map<String, dynamic>> searchlist;
  Usersearchpage2({super.key, required this.searchlist});

  @override
  State<Usersearchpage2> createState() => _Usersearchpage2State();
}

class _Usersearchpage2State extends State<Usersearchpage2> {
  TextEditingController searchcontroller = TextEditingController();
  int selected = 0;
  List<Map<String, dynamic>> searchfilter = [];
  List<Map<String, dynamic>> subsearchfilter = [];
  List<String> foodid = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // reload();
    subsearchfilter = widget.searchlist;
    searchfilter = subsearchfilter;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            icon: const Icon(
              Icons.filter_alt_outlined,
              size: 30,
            ),
            itemBuilder: (context) {
              Color col(
                  {required int value,
                  required int selected,
                  required context}) {
                if (selected == value) {
                  return Colors.blue;
                } else {
                  return Colors.black;
                }
              }

              return [
                PopupMenuItem(
                    value: 0,
                    child: text(
                        name: 'food name',
                        colour: col(
                            value: 0, selected: selected, context: context))),
                PopupMenuItem(
                    value: 1,
                    child: text(
                        name: 'food description',
                        colour: col(
                            value: 1, selected: selected, context: context))),
                PopupMenuItem(
                    value: 2,
                    child: text(
                        name: 'food ingredients',
                        colour: col(
                            value: 2, selected: selected, context: context))),
                PopupMenuItem(
                    value: 3,
                    child: text(
                        name: 'food direction',
                        colour: col(
                            value: 3, selected: selected, context: context))),
                PopupMenuItem(
                    value: 4,
                    child: text(
                        name: 'minutes',
                        colour: col(
                            value: 4, selected: selected, context: context))),
                PopupMenuItem(
                    value: 5,
                    child: text(
                        name: 'hour',
                        colour: col(
                            value: 5, selected: selected, context: context))),
              ];
            },
            onSelected: (value) {
              setState(() {
                selected = value;
                List<Map<String, dynamic>> result = [];
                if (searchcontroller.text.isEmpty) {
                  result = subsearchfilter;
                } else {
                  result = subsearchfilter.where((mapEntry) {
                    var innerMap = mapEntry.values.first;
                    String foodName = innerMap['foodname'];
                    bool matchesFoodName = foodName
                        .toLowerCase()
                        .contains(searchcontroller.text.toLowerCase());

                    String description = innerMap['description'];
                    bool matchesDescription = description
                        .toLowerCase()
                        .contains(searchcontroller.text.toLowerCase());

                    List<String> ingredients =
                        List.from(innerMap['ingredients'] ?? []);
                    bool matchesIngredients = ingredients.any((ingredient) =>
                        ingredient
                            .toLowerCase()
                            .contains(searchcontroller.text.toLowerCase()));
                    List<String> direction =
                        List.from(innerMap['direction'] ?? []);
                    bool matchesDirection = direction.any((direction) =>
                        direction
                            .toLowerCase()
                            .contains(searchcontroller.text.toLowerCase()));

                    int hour = innerMap['hour'];
                    bool matchesHour =
                        hour.toString().contains(searchcontroller.text);

                    int min = innerMap['min'];
                    bool matchesMin = (hour == 0 &&
                            min.toString().contains(searchcontroller.text)) ||
                        (hour > 0 &&
                            min.toString().contains(searchcontroller.text));

                    if (selected == 1) {
                      return matchesDescription;
                    } else if (selected == 2) {
                      return matchesIngredients;
                    } else if (selected == 3) {
                      return matchesDirection;
                    } else if (selected == 4) {
                      return matchesMin;
                    } else if (selected == 5) {
                      return matchesHour;
                    } else {
                      return matchesFoodName;
                    }
                  }).toList();
                }

                searchfilter = result;
              });
            },
          )
        ],
        title: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.black)),
          child: TextField(
            controller: searchcontroller,
            decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 10),
                hintText: 'Search'),
            onChanged: (value) {
              // print('start');

              List<Map<String, dynamic>> result = [];
              // print(result);
              if (value.isEmpty) {
                result = subsearchfilter;
                // print(result);
              } else if (value == '') {
                result = subsearchfilter;
              } else {
                result = subsearchfilter.where((mapEntry) {
                  var innerMap = mapEntry.values.first;

                  String foodName = innerMap['foodname'];
                  bool matchesFoodName =
                      foodName.toLowerCase().contains(value.toLowerCase());

                  String description = innerMap['description'];
                  bool matchesDescription =
                      description.toLowerCase().contains(value.toLowerCase());

                  List<String> ingredients =
                      List.from(innerMap['ingredients'] ?? []);
                  bool matchesIngredients = ingredients.any((ingredient) =>
                      ingredient.toLowerCase().contains(value.toLowerCase()));

                  List<String> direction =
                      List.from(innerMap['direction'] ?? []);
                  bool matchesDirection = direction.any((direction) => direction
                      .toLowerCase()
                      .contains(searchcontroller.text.toLowerCase()));

                  int hour = innerMap['hour'];
                  bool matchesHour =
                      hour.toString().contains(searchcontroller.text);

                  int min = innerMap['min'];
                  bool matchesMin = (hour == 0 &&
                          min.toString().contains(searchcontroller.text)) ||
                      (hour > 0 &&
                          min.toString().contains(searchcontroller.text));
                  if (selected == 1) {
                    return matchesDescription;
                  } else if (selected == 2) {
                    return matchesIngredients;
                  } else if (selected == 3) {
                    return matchesDirection;
                  } else if (selected == 4) {
                    return matchesMin;
                  } else if (selected == 5) {
                    return matchesHour;
                  } else {
                    return matchesFoodName;
                  }

                  // return matchesFoodName ||
                  //     matchesDescription ||
                  //     matchesIngredients;
                }).toList();
                // result = subsearchfilter.where((mapEntry) {
                //   var innerMap = mapEntry.values.first;
                //   String foodName = innerMap['foodname'];
                //   return foodName.toLowerCase().contains(value.toLowerCase());
                // }).toList();
              }
              setState(() {
                // print(result);
                searchfilter = result;
              });
            },
          ),
        ),
      ),
      body: searchfilter.isEmpty
          ? Center(
              child: text(name: 'No data found'),
            )
          : ValueListenableBuilder(
              valueListenable: favlist,
              builder: (context, value, child) {
                return ListView.builder(
                  itemCount: searchfilter.length,
                  itemBuilder: (context, index) {
                    bool isfav = false;

                    for (int i = 0; i < favlist.value.length; i++) {
                      if (favlist.value[i].id ==
                          searchfilter[index].keys.first) {
                        isfav = true;
                      }
                    }
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return Userfullreciptrial(
                                foodid: searchfilter[index].keys.first,
                                category: 'category',
                                description: searchfilter[index]
                                    .values
                                    .first['description'],
                                min: searchfilter[index].values.first['min'],
                                hour: searchfilter[index].values.first['hour'],
                                ingredients: searchfilter[index]
                                    .values
                                    .first['ingredients'],
                                foodname: searchfilter[index]
                                    .values
                                    .first['foodname'],
                                foodphotolist: List.from(
                                    searchfilter[index].values.first['file']),
                                direction: searchfilter[index]
                                    .values
                                    .first['direction']);
                          },
                        ));
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 225,
                                imageUrl:
                                    searchfilter[index].values.first['file'][0],
                                placeholder: (context, url) {
                                  return Image.asset(
                                    'assets/images/11861789_7575.jpg',
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
                            ),
                            Positioned(
                              top: 10,
                              left: 10,
                              child: text(
                                  name: searchfilter[index]
                                      .values
                                      .first['foodname'],
                                  colour: Colors.white),
                            ),
                            Positioned(
                                right: 0,
                                child: IconButton(
                                    onPressed: () async {
                                      // int searchindex = 0;
                                      Favourite favor = Favourite(
                                        uid: useremail,
                                          id: searchfilter[index].keys.first,
                                          foodname: searchfilter[index]
                                              .values
                                              .first['foodname'],
                                          file: List.from(searchfilter[index]
                                              .values
                                              .first['file']),
                                          description: searchfilter[index]
                                              .values
                                              .first['description'],
                                          ingredients: List.from(
                                              searchfilter[index]
                                                  .values
                                                  .first['ingredients']),
                                          direction: List.from(
                                              searchfilter[index]
                                                  .values
                                                  .first['direction']),
                                          hour: searchfilter[index]
                                              .values
                                              .first['hour'],
                                          date: DateTime.now(),
                                          min: searchfilter[index]
                                              .values
                                              .first['min']);
                                      isfav
                                          ? await deletefavorite(
                                              favourite: favor)
                                          : await addfavourite(favor: favor);
                                      await getfavourite();

                                      isfav = !isfav;
                                      // print(isfav);
                                    },
                                    icon: Icon(
                                      isfav
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: isfav ? Colors.red : Colors.white,
                                    ))),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}

Future<List<Map<String, dynamic>>> Alllistformfirebaseforsearch() async {
  // List<String> foodid = [];
  QuerySnapshot qs =
      await FirebaseFirestore.instance.collection('category').get();
  List<QueryDocumentSnapshot> documents = qs.docs;

  var uniquelis = {};
  List<Map<String, dynamic>> lis = [];
  for (int i = 0; i < documents.length; i++) {
    Map<String, dynamic> a = {};
    a = documents[i].data() as Map<String, dynamic>;
    for (var d in a.entries) {
      if (d.key != 'categoryimg') {
        uniquelis[d.key] = d.value;
      }
    }
  }

  lis = uniquelis.entries
      .map((entry) => {entry.key.toString(): entry.value as dynamic})
      .toList();
  return lis;
}
