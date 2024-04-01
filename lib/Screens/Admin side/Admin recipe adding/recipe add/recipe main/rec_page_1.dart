// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:projectweek1/Screens/Admin%20side/Admin%20recipe%20adding/firebasestoragefunctions.dart';
import 'package:projectweek1/Screens/Admin%20side/Admin%20recipe%20adding/recipe%20add/widget%20refactor%20recipe/page1ref.dart';
import 'package:projectweek1/Screens/Admin%20side/Admin%20recipe%20adding/recipe%20add/widget%20refactor%20recipe/adminfoodphoto.dart';
import 'package:projectweek1/Screens/Admin%20side/Admin%20recipe%20adding/recipe%20add/widget%20refactor%20recipe/numberpicker.dart';
import 'package:projectweek1/Screens/Admin%20side/Admin%20recipe%20adding/recipe%20add/refactoring/rec_page_2.dart';
import 'package:projectweek1/Screens/Admin%20side/Admin%20recipe%20adding/recipe%20add/refactoring/rec_page_3.dart';
import 'package:projectweek1/Screens/Login%20pages/New%20user/new_user_login.dart';

class Adminrecipeaddpage1 extends StatefulWidget {
  List<String>? foodphotolistedit = [];
  TextEditingController textcontroller = TextEditingController();
  Adminrecipeaddpage1({super.key, this.foodphotolistedit});

  @override
  State<Adminrecipeaddpage1> createState() => _Adminrecipeaddpage1State();
}

String? drop;
bool? checkbox = false;

class _Adminrecipeaddpage1State extends State<Adminrecipeaddpage1> {
  ValueNotifier<List<String>> ingredients = ValueNotifier([]);
  ValueNotifier<List<String>> direction = ValueNotifier([]);
  var formkey = GlobalKey<FormState>();
  TextEditingController ingredientscontroll = TextEditingController();
  TextEditingController directioncontroll = TextEditingController();
  TextEditingController editingController1 = TextEditingController();
  int hour = 0;
  int min = 0;
  List<String?> categorylist =
      fetchingcategoryphotoandname['categoryname'] ?? [];

  List<String>? a;
  bool isloading = false;
  int selectedindex = 0;
  List<XFile> file = [];
  TextEditingController foodname = TextEditingController();
  TextEditingController description = TextEditingController();
  void initState() {
    // TODO: implement initState
    super.initState();
    // foodname.text=isedit?widget.fname??"":'';

    if (categorylist.isNotEmpty) {
      drop = categorylist[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: text(name: 'Add recipe', colour: Colors.white, fsize: 22),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              text(name: 'Name of the food', fsize: 17),
              textformfeild(foodname: foodname),
              SizedBox(
                height: height * 0.03,
              ),
              text(name: 'Photos of the food', fsize: 17),
              Addfoodphoto(
                  file: file,
                  width: width,
                  height: height,
                  selectedindex: selectedindex),
              text(name: 'Description', colour: Colors.black),
              Container(
                  height: height * 0.2,
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(20)),
                  child: TextFormField(
                    controller: description,
                    expands: true,
                    minLines: null,
                    maxLines: null,
                    decoration: const InputDecoration(
                        focusedBorder: InputBorder.none,
                        border: InputBorder.none,
                        hintMaxLines: 2,
                        contentPadding: EdgeInsets.all(10),
                        hintText:
                            'Click here to add details of food.(eg: history or orgin of food)'),
                  )),
              Adminrecipeaddpage2(
                direction: direction,
                ingredients: ingredients,
                directioncontroll: directioncontroll,
                editingController1: editingController1,
                formkey: formkey,
                ingredientscontroll: ingredientscontroll,
              ),
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
              Adminrecipeaddpage3(),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      fixedSize: Size.fromWidth(width)),
                  onPressed: () async {
                    adminnextbutton(
                        context: context,
                        foodname: foodname,
                        file: file,
                        description: description,
                        ingredients: ingredients,
                        direction: direction,
                        hour: hour,
                        min: min,
                        isload: () {
                          setState(() {
                            isloading = true;
                          });
                          if (isloading) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Container(
                                    child: Lottie.asset(
                                  'assets/splash/circular.json',
                                ));
                              },
                            );
                          }
                        });
                    // checkbox=false;
                  },
                  child: isloading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : text(name: 'Add', colour: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
