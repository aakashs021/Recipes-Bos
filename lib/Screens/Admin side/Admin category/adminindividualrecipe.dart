// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:projectweek1/Firebase%20helper/firebase_adminrec3.dart';
import 'package:projectweek1/Screens/Admin%20side/Admin%20category/admin_categoriespage.dart';
import 'package:projectweek1/Screens/Admin%20side/Admin%20category/foodlisting.dart';
import 'package:projectweek1/Screens/Admin%20side/Admin%20category/individualedit.dart';
// import 'package:projectweek1/firebase_helper/firebase_adminr/ec3.dart';
import 'package:projectweek1/screens/Login%20pages/New%20user/new_user_login.dart';
// import 'package:projectweek1/screens/admin_side/Admin%20category/admin_categoriespage.dart';
// import 'package:projectweek1/screens/admin_side/Admin%20category/foodlisting.dart';
// import 'package:projectweek1/screens/admin_side/admin_category/individualedit.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Fullrecipe extends StatefulWidget {
  String foodname;
  String foodid;
  int? editindex;
  int hour;
  int min;
  String description;
  String category;
  List<String> foodphotolist;
  List<dynamic> ingredients;
  List<dynamic> direction;
  Fullrecipe({
    super.key,
    this.editindex,
    required this.foodid,
    required this.category,
    required this.description,
    required this.min,
    required this.hour,
    required this.ingredients,
    required this.foodname,
    required this.foodphotolist,
    required this.direction,
  });

  @override
  State<Fullrecipe> createState() => _FullrecipeState();
}

class _FullrecipeState extends State<Fullrecipe> {
  int selectedindex = 0;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              navigatorpop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: text(
                          name:
                              'Are you sure you want to delete everything in ${widget.foodname}?'),
                      actions: [
                        TextButton(
                            onPressed: () async {
                              await deletingindividualfood(
                                  context: context,
                                  category: widget.category,
                                  foodid: widget.foodid);
                            },
                            child: text(name: 'Yes')),
                        TextButton(
                            onPressed: () {
                              navigatorpop(context);
                            },
                            child: text(name: 'No'))
                      ],
                    );
                  },
                );
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
                size: 35,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
                width: double.infinity,
                height: height * 0.3,
                child: Stack(
                  children: [
                    CarouselSlider.builder(
                        itemCount: widget.foodphotolist.length,
                        itemBuilder: (context, index, realIndex) {
                          return ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                bottom: Radius.circular(20)),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                              imageUrl: widget.foodphotolist[index],
                              placeholder: (context, url) {
                                return Stack(
                                  children: [
                                    const CircularProgressIndicator(
                                      color: Colors.blue,
                                    ),
                                    Image.asset(
                                      'assets/images/11861789_7575.jpg',
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    ),
                                  ],
                                );
                              },
                            ),
                          );
                        },
                        options: CarouselOptions(
                          scrollPhysics: widget.foodphotolist.length > 1
                              ? null
                              : const NeverScrollableScrollPhysics(),
                          height: height * 0.3,
                          autoPlayAnimationDuration: const Duration(seconds: 1),
                          viewportFraction: 1,
                          autoPlay:
                              widget.foodphotolist.length > 1 ? true : false,
                          onPageChanged: (index, reason) {
                            setState(() {
                              selectedindex = index;
                            });
                          },
                        )),
                    Positioned(
                        bottom: height * 0.017,
                        left: 20,
                        child: text(
                            name: widget.foodname,
                            colour: Colors.white,
                            fsize: 20)),
                    widget.foodphotolist.length != 1
                        ? SizedBox(
                            width: double.infinity,
                            height: double.infinity,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: AnimatedSmoothIndicator(
                                  activeIndex: selectedindex,
                                  effect: const JumpingDotEffect(
                                      activeDotColor: Colors.blue,
                                      dotColor: Colors.white,
                                      dotWidth: 15,
                                      dotHeight: 15,
                                      radius: 10),
                                  count: widget.foodphotolist.length),
                            ),
                          )
                        : const SizedBox()
                  ],
                )),
            SizedBox(
              height: height * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: text(name: 'Description', fsize: 18),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: text(name: widget.description),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: text(name: 'Ingredients', fsize: 18),
            ),
            listview(list: widget.ingredients),
            SizedBox(
              height: height * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: text(name: 'Direction', fsize: 18),
            ),
            listview(list: widget.direction),
            SizedBox(
              height: height * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: text(
                  name:
                      'Preparation Time: ${time(hour: widget.hour, min: widget.min)}',
                  fsize: 18),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Individualedit(
                            foodname: widget.foodname,
                            foodphotolistedit: widget.foodphotolist,
                            ingredients: List.from(widget.ingredients),
                            direction: List.from(widget.direction),
                            hour: widget.hour,
                            min: widget.min,
                            category: widget.category,
                            foodid: widget.foodid,
                            description: widget.description,
                          ),
                        ));
                      },
                      child: text(name: 'Edit', colour: Colors.white),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget listview({required List<dynamic> list}) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              text(name: '  ${index + 1})'),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  style: const TextStyle(
                    fontFamily: 'robotomonovariable',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  list[index].toString(),
                  softWrap: true, // Allow text to wrap to next line
                  textAlign: TextAlign.start, // Align text to start of the line
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

deletingindividualfood(
    {required context,
    required String category,
    required String foodid}) async {
  try {
    await FirebaseFirestore.instance
        .collection('category')
        .doc(category)
        .update({foodid: FieldValue.delete()});
    await categoryalldetails(document: category);
    Map<String, dynamic> a = everymap;
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => Foodlist(
            foodname: a['foodname'],
            category: category,
            foodid: a['foodid'],
            foodphotolist: a['singlephoto'],
            b: a['all'],
          ),
        ),
        (route) => route.isFirst);
    // print('completed');
  } catch (e) {
    if (kDebugMode) {
      print('abc $e');
    }
  }
}

Color imagecolor({required String url}) {
  if (url.contains('light-backgroud')) {
    return Colors.black;
  } else {
    return Colors.white;
  }
}

String time({required int hour, required int min}) {
  String minute = min == 1 ? 'minute' : 'minutes';
  String h = hour == 1 ? 'hour' : 'hours';
  if (hour == 0) {
    return '$min $minute';
  } else if (min == 0) {
    return '$hour $h';
  } else {
    return '$hour $h and $min $minute';
  }
}
