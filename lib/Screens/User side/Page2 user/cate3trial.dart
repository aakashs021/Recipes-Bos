import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projectweek1/Firebase%20helper/firebase_adminrec3.dart';
import 'package:projectweek1/Hive%20helper/Hive%20favourites/favfunctions.dart';
import 'package:projectweek1/Hive%20helper/Hive%20favourites/favourite_model.dart';
import 'package:projectweek1/Hive%20helper/Hive%20shopping/shopping_functions.dart';
import 'package:projectweek1/Hive%20helper/Hive%20shopping/shopping_model.dart';
import 'package:projectweek1/Screens/Admin%20side/Admin%20category/adminindividualrecipe.dart';
import 'package:projectweek1/Screens/Admin%20side/Admin%20recipe%20adding/recipe%20add/widget%20refactor%20recipe/page1ref.dart';
// import 'package:projectweek1/firebase_helper/firebase_adminrec3.dart';
// import 'package:projectweek1/hive_helper/hive_favourites/favfunctions.dart';
// import 'package:projectweek1/hive_helper/hive_favourites/favourite_model.dart';
// import 'package:projectweek1/hive_helper/hive_shopping/shopping_functions.dart';
// import 'package:projectweek1/hive_helper/hive_shopping/shopping_model.dart';
import 'package:projectweek1/screens/Login%20pages/New%20user/new_user_login.dart';
import 'package:projectweek1/screens/Login%20pages/Normal%20login/main_login.dart';
// import 'package:projectweek1/screens/admin_side/Admin%20category/adminindividualrecipe.dart';
// import 'package:projectweek1/screens/admin_side/admin_recipe_adding/recipe%20add/widget%20refactor%20recipe/page1ref.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ignore: must_be_immutable
class Userfullreciptrial extends StatefulWidget {
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
  Userfullreciptrial({
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
  State<Userfullreciptrial> createState() => _UserfullreciptrialState();
}

class _UserfullreciptrialState extends State<Userfullreciptrial> {
  int selectedindex = 0;
  bool favcolor = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < favlist.value.length; i++) {
      if (favlist.value[i].id == widget.foodid) {
        favcolor = true;
      }
    }
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
              IconButton(
                  onPressed: () async {
                    Favourite fav = Favourite(
                        uid: useremail,
                        id: widget.foodid,
                        foodname: widget.foodname,
                        file: widget.foodphotolist,
                        description: widget.description,
                        ingredients: List.from(widget.ingredients),
                        direction: List.from(widget.direction),
                        hour: widget.hour,
                        date: DateTime.now(),
                        min: widget.min);
                    favcolor
                        ? await deletefavorite(favourite: fav)
                        : await addfavourite(favor: fav);
                    await getfavourite();
                    if (favcolor) {
                      print('added');
                    } else {
                      print('deleted');
                    }
                    setState(() {
                      favcolor = !favcolor;
                    });
                  },
                  icon: Icon(
                    favcolor ? Icons.favorite : Icons.favorite_outline_sharp,
                    color: favcolor ? Colors.red : Colors.white,
                  ))
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
              title: text(name: widget.foodname, colour: Colors.white),
              background: Stack(
                children: [
                  CarouselSlider.builder(
                      itemCount: widget.foodphotolist.length,
                      itemBuilder: (context, index, realIndex) {
                        return ClipRRect(
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
                text(name: time(hour: widget.hour, min: widget.min)),
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
                                  text(name: widget.description),
                                ],
                              ),
                            ))),
                  ),
                  const Divider(),
                  Stack(
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
                                child: ListView.separated(
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(
                                      height: 10,
                                    );
                                  },
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: widget.ingredients.length,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(top: 6),
                                          child: Icon(
                                            Icons.circle,
                                            size: 10,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: SizedBox(
                                              width: index > 8
                                                  ? width * 0.80
                                                  : width * 0.82,
                                              child: text(
                                                  name: widget
                                                      .ingredients[index]
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
                      Positioned(
                          right: 0,
                          child: IconButton(
                              onPressed: () async {
                                if (widget.ingredients.isNotEmpty) {
                                  late Shopping shop;
                                  for (String d in widget.ingredients) {
                                    shop = Shopping(
                                        id: DateTime.now().toString(),
                                        shoppinlist: d,
                                        count: 1,
                                        customcheckbox: false);
                                    await addshop(shopping: shop);
                                  }
                                }
                                await getshop();
                                snakbar(
                                    context: context,
                                    txt: 'Added successfully to shopping cart');
                              },
                              icon: Icon(
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
                            child: ListView.separated(
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 10,
                                );
                              },
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: widget.direction.length,
                              itemBuilder: (context, index) {
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    text(name: '${index + 1})'),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: SizedBox(
                                          width: index > 8
                                              ? width * 0.80
                                              : width * 0.82,
                                          child: text(
                                              name: widget.direction[index]
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
