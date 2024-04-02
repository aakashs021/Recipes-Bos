import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:projectweek1/Firebase%20helper/firebase_adminrec3.dart';
import 'package:projectweek1/Hive%20helper/Hive%20shopping/shopping_functions.dart';
import 'package:projectweek1/Hive%20helper/Hive%20shopping/shopping_model.dart';
import 'package:projectweek1/Screens/Admin%20side/Admin%20category/adminindividualrecipe.dart';
import 'package:projectweek1/Screens/Admin%20side/Admin%20recipe%20adding/recipe%20add/widget%20refactor%20recipe/page1ref.dart';
import 'package:projectweek1/screens/Login%20pages/New%20user/new_user_login.dart';
import 'package:projectweek1/screens/User%20side/4ownrecipe.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ignore: must_be_immutable
class Userrecipedetail extends StatefulWidget {
  String foodname;
  String foodid;
  // int? editindex;
  int? hour = 0;
  int? min = 0;
  String? description = "";
  // String category;
  List<String>? foodphotolist;
  List<dynamic>? ingredients = [];
  List<dynamic>? direction = [];
  Userrecipedetail({
    super.key,
    // this.editindex,
    required this.foodid,
    required this.description,
    required this.min,
    required this.hour,
    required this.ingredients,
    required this.foodname,
    required this.foodphotolist,
    required this.direction,
  });

  @override
  State<Userrecipedetail> createState() => UserrecipedetailState();
}

class UserrecipedetailState extends State<Userrecipedetail> {
  int selectedindex = 0;
  // bool favcolor = false;
  List<String> photooffood = [];

  @override
  void initState() {
    super.initState();

    photooffood = widget.foodphotolist ?? ['assets/images/11861789_7575.jpg'];
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
          child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar.large(
            actions: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.blue[300],
                child: Center(
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Userownrecipe(
                            id: widget.foodid,
                            name: widget.foodname,
                            ing: widget.ingredients?.map((e) => e.toString())
                                    .toList(),
                            des: widget.description,
                            hour: widget.hour,
                            min: widget.min,
                            dir: widget.direction?.map((e) => e.toString())
                                    .toList(),
                            // image: widget.foodphotolist==null?['assets/images/11861789_7575.jpg']:widget.foodphotolist,
                            image: widget.foodphotolist == null ||
                                    widget.foodphotolist![0] ==
                                        'assets/images/11861789_7575.jpg'
                                ? null
                                : widget.foodphotolist,
                            usereditrecipe: true,
                          ),
                        ));
                      },
                      icon: const Icon(
                        Icons.edit_note_rounded,
                        size: 40,
                        color: Colors.white,
                      )),
                ),
              ),
              const SizedBox(
                width: 10,
              )
            ],
            leading: IconButton(
                onPressed: () {
                  navigatorpop(context);
                },
                icon:
                    const Icon(Icons.arrow_back_ios_new, color: Colors.white)),
            backgroundColor: Colors.white,
            title: text(name: widget.foodname, colour: Colors.black),
            expandedHeight: height * 0.3,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 20, bottom: 10),
              title: text(
                  name: widget.foodname,
                  colour: photooffood[0] == 'assets/images/11861789_7575.jpg'
                      ? Colors.black
                      : Colors.white),
              background: Stack(
                children: [
                  CarouselSlider.builder(
                      itemCount: photooffood.length,
                      itemBuilder: (context, index, realIndex) {
                        return ClipRRect(
                          child: photooffood[index] ==
                                  'assets/images/11861789_7575.jpg'
                              ? Lottie.asset('assets/images/userecpadded.json')
                              // Image.asset(photooffood[index],
                              //     width: double.infinity, fit: BoxFit.cover)
                              : Image.file(
                                  File(photooffood[index]),
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                        );
                      },
                      options: CarouselOptions(
                        scrollPhysics: photooffood.length > 1
                            ? null
                            : const NeverScrollableScrollPhysics(),
                        height: height * 0.3,
                        autoPlayAnimationDuration: const Duration(seconds: 1),
                        viewportFraction: 1,
                        autoPlay: photooffood.length > 1 ? true : false,
                        onPageChanged: (index, reason) {
                          setState(() {
                            selectedindex = index;
                          });
                        },
                      )),
                  photooffood.length != 1
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
                                count: photooffood.length),
                          ),
                        )
                      : const SizedBox()
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/clock-removebg-preview.png',
                  width: 60,
                  height: 60,
                ),
                text(name: time(hour: widget.hour!, min: widget.min!)),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SizedBox(
                        width: double.infinity,
                        child: Card(
                            elevation: 10,
                            color: Colors.green[100],
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  text(name: 'Description', fsize: 20),
                                  text(
                                      name: widget.description == ""
                                          ? "No desciption added"
                                          : widget.description!),
                                ],
                              ),
                            ))),
                  ),
                  const Divider(),
                  Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            width: double.infinity,
                            child: Card(
                              color: Colors.blue[100],
                              elevation: 20,
                              child: Column(
                                children: [
                                  text(name: 'Ingredients', fsize: 20),
                                  Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: widget.ingredients!.isEmpty
                                        ? text(name: 'No ingredients added')
                                        : ListView.separated(
                                            separatorBuilder: (context, index) {
                                              return const SizedBox(
                                                height: 10,
                                              );
                                            },
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount:
                                                widget.ingredients!.length,
                                            itemBuilder: (context, index) {
                                              return Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.only(top: 6),
                                                    child: Icon(
                                                      Icons.circle,
                                                      size: 10,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: SizedBox(
                                                        width: index > 8
                                                            ? width * 0.80
                                                            : width * 0.82,
                                                        child: text(
                                                            name: widget
                                                                .ingredients![
                                                                    index]
                                                                .toString())),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                          right: 0,
                          child: IconButton(
                              onPressed: () async {
                                if (widget.ingredients != null &&
                                    widget.ingredients!.isNotEmpty) {
                                  late Shopping shop;
                                  for (String d in widget.ingredients!) {
                                    shop = Shopping(
                                        id: DateTime.now().toString(),
                                        shoppinlist: d,
                                        count: 1,
                                        customcheckbox: false);
                                    await addshop(shopping: shop);
                                  }
                                  await getshop();
                                  snakbar(
                                      // ignore: use_build_context_synchronously
                                      context: context,
                                      txt:
                                          'Added successfully to shopping cart');
                                }
                              },
                              icon: const Icon(
                                Icons.add_shopping_cart_sharp,
                                size: 30,
                              )))
                    ],
                  ),
                  const Divider(),
                  Container(
                    padding: const EdgeInsets.all(4),
                    width: double.infinity,
                    child: Card(
                      color: Colors.yellow[100],
                      elevation: 20,
                      child: Column(
                        children: [
                          text(name: 'Direction', fsize: 20),
                          Padding(
                            padding: const EdgeInsets.all(0),
                            child: widget.direction!.isEmpty
                                ? text(name: 'No direstion added')
                                : ListView.separated(
                                    separatorBuilder: (context, index) {
                                      return const SizedBox(
                                        height: 10,
                                      );
                                    },
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: widget.direction!.length,
                                    itemBuilder: (context, index) {
                                      return Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          text(name: '${index + 1})'),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: SizedBox(
                                                width: index > 8
                                                    ? width * 0.80
                                                    : width * 0.82,
                                                child: text(
                                                    name: widget
                                                        .direction![index]
                                                        .toString())),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                          ),
                          const SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
                  ),
                  // Container(),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
