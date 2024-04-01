// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:projectweek1/Hive%20helper/Hive%20favourites/favfunctions.dart';
import 'package:projectweek1/Hive%20helper/Hive%20favourites/favourite_model.dart';
import 'package:projectweek1/Screens/Login%20pages/New%20user/new_user_login.dart';
import 'package:projectweek1/Screens/Login%20pages/Normal%20login/main_login.dart';
import 'package:projectweek1/Screens/User%20side/Page2%20user/cate3trial.dart';

bool isedit = false;

class Userfoodlist extends StatefulWidget {
  final List<String> foodid;
  final List<String> foodname;
  final List<String> foodphotolist;
  int? editindex;
  String? editid;
  dynamic b;
  String category;
  Userfoodlist(
      {super.key,
      this.editindex,
      required this.foodname,
      required this.foodid,
      required this.foodphotolist,
      required this.b,
      required this.category,
      this.editid});

  @override
  State<Userfoodlist> createState() => _UserfoodlistState();
}

class _UserfoodlistState extends State<Userfoodlist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: text(name: widget.category),
      ),
      body: SafeArea(
        child: widget.foodid.isEmpty && widget.foodphotolist.isEmpty
            ? Center(
                child: text(name: 'No recipe found'),
              )
            : ValueListenableBuilder(
                valueListenable: favlist,
                builder: (context, value, child) {
                  return ListView.builder(
                    itemCount: widget.foodid.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> individual = widget.b[index];
                      bool isfav = false;
                      for (int i = 0; i < favlist.value.length; i++) {
                        if (favlist.value[i].id == widget.foodid[index]) {
                          isfav = true;
                        }
                      }
                      print('lll $isfav');
                      return Padding(
                        padding:
                            const EdgeInsets.only(top: 15, left: 15, right: 15),
                        child: InkWell(
                          onTap: () {
                            List<String> foodphotolist = [];
                            String foodname = individual['foodname'];
                            dynamic ingredients = individual['ingredients'];
                            dynamic direction = individual['direction'];
                            String description = individual['description'];
                            int hour = individual['hour'];
                            int min = individual['min'];
                            for (var e in individual['file']) {
                              String a = e.toString();
                              foodphotolist.add(a);
                            }

                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Userfullreciptrial(
                                  foodid: widget.foodid[index],
                                  category: widget.category,
                                  description: description,
                                  hour: hour,
                                  min: min,
                                  direction: direction,
                                  ingredients: ingredients,
                                  foodname: foodname,
                                  editindex: index,
                                  foodphotolist: foodphotolist),
                            ));
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox(
                                width: double.infinity,
                                height: 200,
                                child: Stack(
                                  children: [
                                    CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      imageUrl: widget.foodphotolist[index],
                                      placeholder: (context, url) {
                                        return SizedBox(
                                            width: double.infinity,
                                            height: double.infinity,
                                            child: Stack(
                                              children: [
                                                const Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                  color: Colors.blue,
                                                )),
                                                Image.asset(
                                                  'assets/images/11861789_7575.jpg',
                                                  width: double.infinity,
                                                  fit: BoxFit.cover,
                                                ),
                                              ],
                                            ));
                                      },
                                    ),
                                    text(
                                        name: '  ${widget.foodname[index]}',
                                        colour: Colors.white),
                                    Positioned(
                                        right: 0,
                                        child: IconButton(
                                            onPressed: () async {
                                              Favourite favor = Favourite(
                                                  id: widget.foodid[index],
                                                  uid: useremail,
                                                  foodname:
                                                      widget.foodname[index],
                                                  file: List.from(
                                                      individual['file']),
                                                  description:
                                                      individual['description'],
                                                  ingredients: List.from(
                                                      individual[
                                                          'ingredients']),
                                                  direction: List.from(
                                                      individual['direction']),
                                                  hour: individual['hour'],
                                                  date: DateTime.now(),
                                                  min: individual['min']);
                                              print('first $isfav');
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
                                  ],
                                )),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
      ),
    );
  }
}
