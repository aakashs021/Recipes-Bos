// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projectweek1/Hive%20helper/Hive%20favourites/favfunctions.dart';
import 'package:projectweek1/Hive%20helper/Hive%20favourites/favourite_model.dart';
import 'package:projectweek1/Screens/Login%20pages/New%20user/new_user_login.dart';
import 'package:projectweek1/Screens/Login%20pages/Normal%20login/main_login.dart';
import 'package:projectweek1/Screens/User%20side/Page1%20user/drawer2.dart';
import 'package:projectweek1/Screens/User%20side/Page2%20user/cate3trial.dart';

bool isloadinguser = false;

class Usertrending extends StatefulWidget {
  const Usertrending({super.key});

  @override
  State<Usertrending> createState() => _UsertrendingState();
}

class _UsertrendingState extends State<Usertrending> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.red[100],
      drawer: drawer2(context: context),

      // appBar: AppBar(
      //   title: text(name: 'Trending'),
      //   actions: [
      //     IconButton(
      //         onPressed: () async {
      //           List<Map<String, dynamic>> subsearchfilter =
      //               await Alllistformfirebaseforsearch();
      //           Navigator.of(context).push(MaterialPageRoute(
      //             builder: (context) => Usersearchpage2(
      //               searchlist: subsearchfilter,
      //             ),
      //           ));
      //         },
      //         icon: const Icon(Icons.search))
      //   ],
      // ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('category')
            .doc('Trending')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasData) {
              Map<String, dynamic> docdata =
                  snapshot.data!.data() as Map<String, dynamic>;
              List<Map<String, dynamic>> individual = [];
              docdata.remove('categoryimg');
              List<String> foodnamelist = [];
              List<String> foodphotolist = [];
              List<String> foodid = [];
              for (String d in docdata.keys) {
                foodid.add(d);
              }
              for (var d in docdata.values) {
                foodnamelist.add(d['foodname']);
                foodphotolist.add(d['file'][0]);
                individual.add(d);
              }

              return foodid.isEmpty
                  ? Center(child: text(name: 'No recipe added in trending'))
                  : ValueListenableBuilder(
                      valueListenable: favlist,
                      builder: (context, value, child) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: foodphotolist.length,
                          itemBuilder: (context, index) {
                            bool isfav = false;

                            for (int i = 0; i < favlist.value.length; i++) {
                              if (favlist.value[i].id == foodid[index]) {
                                isfav = true;
                              }
                            }
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) {
                                    return Userfullreciptrial(
                                        foodid: foodid[index],
                                        category: 'Trending',
                                        description: individual[index]
                                            ['description'],
                                        min: individual[index]['min'],
                                        hour: individual[index]['hour'],
                                        ingredients: individual[index]
                                            ['ingredients'],
                                        foodname: individual[index]['foodname'],
                                        foodphotolist: List.from(
                                            individual[index]['file']),
                                        direction: individual[index]
                                            ['direction']);
                                  },
                                ));
                              },
                              child: Container(
                                margin: const EdgeInsets.all(10),
                                child: Stack(children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: 225,
                                      imageUrl: foodphotolist[index],
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
                                      right: 0,
                                      child: IconButton(
                                          onPressed: () async {
                                            Favourite favor = Favourite(
                                                id: foodid[index],
                                                foodname: foodnamelist[index],
                                                file: List.from(
                                                    individual[index]['file']),
                                                description: individual[index]
                                                    ['description'],
                                                ingredients: List.from(
                                                    individual[index]
                                                        ['ingredients']),
                                                direction: List.from(
                                                    individual[index]
                                                        ['direction']),
                                                hour: individual[index]['hour'],
                                                date: DateTime.now(),
                                                min: individual[index]['min'],
                                                uid: useremail);
                                            isfav
                                                ? await deletefavorite(
                                                    favourite: favor)
                                                : await addfavourite(
                                                    favor: favor);
                                            await getfavourite();
                                            isfav = !isfav;
                                          },
                                          icon: Icon(
                                            isfav
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: isfav
                                                ? Colors.red
                                                : Colors.white,
                                          ))),
                                  Positioned(
                                      left: 10,
                                      top: 10,
                                      child: text(
                                          name: foodnamelist[index],
                                          colour: Colors.white))
                                ]),
                              ),
                            );
                          },
                        );
                      },
                    );
            } else {
              return Center(child: text(name: 'No recipe added in trending'));
            }
          }
        },
      ),
    );
  }
}

TableRow userdetailshowingindrawer(
    {required String detail2,
    required String detail1,
    required IconData icondata,
    bool issize = false}) {
  return TableRow(children: [
    issize
        ? const SizedBox(
            height: 20,
          )
        : Icon(icondata),
    issize
        ? const SizedBox(
            height: 20,
          )
        : text(name: detail1, fsize: 20),
    issize
        ? const SizedBox(
            height: 20,
          )
        : text(name: ':'),
    issize
        ? const SizedBox(
            height: 20,
          )
        : FutureBuilder(
            future: getdetailsfromuserinmainpage(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text('some error');
              } else if (snapshot.hasError) {
                return const Text('snapshot error');
              } else {
                String a = snapshot.data![detail2] ?? "";
                return text(
                    name: a == "" ? "" : snapshot.data![detail2], fsize: 17);
              }
            },
          )
  ]);
}
