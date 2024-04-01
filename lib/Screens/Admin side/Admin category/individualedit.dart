// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projectweek1/Firebase%20helper/firebase_adminrec3.dart';
import 'package:projectweek1/Screens/Admin%20side/Admin%20category/adminindividualrecipe.dart';
import 'package:projectweek1/Screens/Admin%20side/Admin%20recipe%20adding/firebasestoragefunctions.dart';
import 'package:projectweek1/Screens/Admin%20side/Admin%20recipe%20adding/recipe%20add/refactoring/rec_page_2.dart';
import 'package:projectweek1/Screens/Admin%20side/Admin%20recipe%20adding/recipe%20add/widget%20refactor%20recipe/numberpicker.dart';
import 'package:projectweek1/Screens/Admin%20side/Admin%20recipe%20adding/recipe%20add/widget%20refactor%20recipe/page1ref.dart';
// import 'package:projectweek1/firebase_helper/firebase_adminrec3.dart';
import 'package:projectweek1/screens/Login%20pages/New%20user/new_user_login.dart';
// import 'package:projectweek1/screens/admin_side/Admin%20category/adminindividualrecipe.dart';
// import 'package:projectweek1/screens/admin_side/admin_recipe_adding/firebasestoragefunctions.dart';
// import 'package:projectweek1/screens/admin_side/admin_recipe_adding/recipe%20add/refactoring/rec_page_2.dart';
// import 'package:projectweek1/screens/admin_side/admin_recipe_adding/recipe%20add/widget%20refactor%20recipe/numberpicker.dart';
// import 'package:projectweek1/screens/admin_side/admin_recipe_adding/recipe%20add/widget%20refactor%20recipe/page1ref.dart';

class Individualedit extends StatefulWidget {
  List<String> foodphotolistedit = [];
  String foodname;
  String foodid;
  String category;
  String description;
  List<String> ingredients;
  List<String> direction;
  int hour;
  int min;
  Individualedit(
      {super.key,
      required this.description,
      required this.foodid,
      required this.category,
      required this.foodname,
      required this.foodphotolistedit,
      required this.ingredients,
      required this.direction,
      required this.hour,
      required this.min});

  @override
  State<Individualedit> createState() => _IndividualeditState();
}

class _IndividualeditState extends State<Individualedit> {
  TextEditingController foodnamecontroller = TextEditingController();
  int selectedindex = 0;
  ValueNotifier<List<String>> ingredients = ValueNotifier([]);
  ValueNotifier<List<String>> direction = ValueNotifier([]);
  var formkey = GlobalKey<FormState>();
  TextEditingController ingredientscontroll = TextEditingController();
  TextEditingController directioncontroll = TextEditingController();
  TextEditingController editingController1 = TextEditingController();
  TextEditingController description = TextEditingController();
  int hour = 0;
  int min = 0;
  String? drop;
  bool? checkbox;
  List<String?> categorylist =
      fetchingcategoryphotoandname['categoryname'] ?? [];
  List<dynamic> photolist = [];
  @override
  void initState() {
    super.initState();
    foodnamecontroller.text = widget.foodname;
    ingredients.value = widget.ingredients;
    direction.value = widget.direction;
    hour = widget.hour;
    min = widget.min;
    description.text = widget.description;
    photolist = [...widget.foodphotolistedit];
    // drop=widget.category;
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.ingredients);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              text(name: 'Name of the food', fsize: 17),
              textformfeild(foodname: foodnamecontroller),
              text(name: 'Description', colour: Colors.black),
              Container(
                  height: height * 0.2,
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      controller: description,
                      minLines: 1,
                      maxLines: 10,
                      decoration: const InputDecoration(
                          focusedBorder: InputBorder.none,
                          border: InputBorder.none,
                          hintText:
                              'Click here to add details of food.(eg: history or orgin of food)'),
                    ),
                  )),
              text(name: 'Photos of the food', fsize: 17),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    width: width,
                    height: height * 0.3,
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: photolist[selectedindex] is String
                              ? CachedNetworkImage(
                                  width: width,
                                  imageUrl: photolist[selectedindex],
                                  fit: BoxFit.cover,
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
                                )
                              : Image.file(
                                  File(photolist[selectedindex].path),
                                  width: width,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        Positioned(
                            right: 0,
                            child: IconButton(
                                onPressed: () {
                                  photolist.length == 1
                                      ? snakbar(
                                          context: context,
                                          txt:
                                              'Atleast one photo should be there')
                                      : showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: text(
                                                  name:
                                                      'Are you sure you want to delete this photo?'),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        if (photolist.length -
                                                                1 ==
                                                            selectedindex) {
                                                          photolist.removeAt(
                                                              selectedindex);
                                                          selectedindex--;
                                                        } else {
                                                          photolist.removeAt(
                                                              selectedindex);
                                                        }
                                                      });
                                                      navigatorpop(context);
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
                                icon: const Icon(Icons.delete))),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: IconButton(
                                onPressed: () async {
                                  photolist.addAll(
                                      await ImagePicker().pickMultiImage());
                                  setState(() {});
                                },
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ))),
                        Positioned(
                            right: 40,
                            child: IconButton(
                                onPressed: () async {
                                  XFile? f = await ImagePicker()
                                      .pickImage(source: ImageSource.gallery);
                                  if (f != null) {
                                    photolist.removeAt(selectedindex);
                                    setState(() {
                                      photolist.insert(selectedindex, f);
                                    });
                                  }
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                )))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.07,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: photolist.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                            splashColor: Colors.transparent,
                            onTap: () {
                              setState(() {
                                selectedindex = index;
                              });
                            },
                            child: Container(
                              decoration: selectedindex == index
                                  ? BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color: Colors.blue, width: 2))
                                  : null,
                              margin: const EdgeInsets.only(left: 10),
                              width: 150,
                              height: 10,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(18),
                                child: photolist[index] is String
                                    ? CachedNetworkImage(
                                        imageUrl: photolist[index],
                                        fit: BoxFit.cover,
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
                                      )
                                    : Image.file(
                                        File(photolist[index].path),
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ));
                      },
                    ),
                  ),
                ],
              ),
              Adminrecipeaddpage2(
                  direction: direction,
                  ingredients: ingredients,
                  directioncontroll: directioncontroll,
                  editingController1: editingController1,
                  formkey: formkey,
                  ingredientscontroll: ingredientscontroll),
              Numberpicker(
                hour: hour,
                min: min,
                onhourchange: (int updatedhour) {
                  setState(() {
                    hour = updatedhour;
                  });
                },
                onminchange: (int updatemin) {
                  setState(() {
                    min = updatemin;
                  });
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent),
                        onPressed: () async {
                          List<String> urls = [];
                          for (int i = 0; i < photolist.length; i++) {
                            dynamic d = photolist[i];
                            if (d is XFile) {
                              Reference refdir = FirebaseStorage.instance
                                  .ref()
                                  .child('Category');
                              Reference refupload = refdir.child(d.path);
                              await refupload.putFile(File(d.path));
                              String newurl = await refupload.getDownloadURL();
                              // photolist[i] = newurl;
                              urls.add(newurl);
                            } else {
                              urls.add(photolist[i]);
                            }
                          }
                          Map<String, dynamic> m = {
                            'foodname': foodnamecontroller.text,
                            'description': description.text,
                            'ingredients': ingredients.value,
                            'direction': direction.value,
                            'hour': hour,
                            'min': min,
                            'file': urls,
                          };
                          try {
                            await FirebaseFirestore.instance
                                .collection('category')
                                .doc(widget.category)
                                .update({widget.foodid: FieldValue.delete()});
                            await uploadeverythingtofirebase(
                                category: widget.category,
                                foodlist: m,
                                checkbox: false);
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => Fullrecipe(
                                        foodid: widget.foodid,
                                        category: widget.category,
                                        description: description.text,
                                        min: min,
                                        hour: hour,
                                        ingredients: ingredients.value,
                                        foodname: foodnamecontroller.text,
                                        foodphotolist: photolist
                                            .map(
                                                (element) => element.toString())
                                            .toList(),
                                        direction: direction.value)),
                                (route) => route.isFirst);
                          } catch (e) {
                            if (kDebugMode) {
                              print(e);
                            }
                          }
                        },
                        child: text(name: 'Update', colour: Colors.white)),
                  ),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
