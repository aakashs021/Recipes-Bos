// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:projectweek1/Screens/Admin%20side/Admin%20category/adminindividualrecipe.dart';
import 'package:projectweek1/Screens/Login%20pages/New%20user/new_user_login.dart';
bool isedit=false;
class Foodlist extends StatelessWidget {
  final List<String> foodid;
  final List<String> foodname;
  final List<String> foodphotolist;
  int? editindex;
  String? editid;
  dynamic b;
  String category;

  Foodlist(
      {super.key,
      this.editindex,
      required this.foodname,
      required this.foodid,
      required this.foodphotolist,
      required this.b,
      required this.category,
      this.editid
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: text(name: category),),
      body: SafeArea(
        child: foodid.isEmpty && foodphotolist.isEmpty
            ? Center(
                child: text(name: 'You have not added anything'),
              )
            : ListView.builder(
                itemCount: foodid.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(top: 15, left: 15, right: 15),
                    child: InkWell(
                      onTap: () {
                        List<String> foodphotolist = [];
                        Map<String, dynamic> individual = b[index];
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

                        // print(foodphotolist);
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Fullrecipe(
                            foodid: foodid[index],
                            category: category,
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
                                CachedNetworkImage(fit: BoxFit.cover,
                                width: double.infinity,
                                  imageUrl: foodphotolist[index],
                                  placeholder: (context, url) {
                                    return SizedBox(
                                        width: double.infinity,
                                        height: double.infinity,
                                        child: Stack(
                                          children: [
                                            const Center(child: CircularProgressIndicator(color: Colors.blue,)),
                                            Image.asset(
                                              'assets/images/11861789_7575.jpg',width: double.infinity,fit: BoxFit.cover,
                                            ),
                                          ],
                                        ));
                                  },
                                ),
                                text(
                                    name: '  ${foodname[index]}',
                                    colour: Colors.white),
                              ],
                            )),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
