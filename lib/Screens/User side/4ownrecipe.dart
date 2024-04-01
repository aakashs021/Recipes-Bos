import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projectweek1/Firebase%20helper/firebase_adminrec3.dart';
import 'package:projectweek1/Hive%20helper/hive%20db/dbfunctions.dart';
import 'package:projectweek1/Hive%20helper/hive%20db/recipe_model.dart';
import 'package:projectweek1/Screens/Admin%20side/Admin%20recipe%20adding/recipe%20add/refactoring/rec_page_2.dart';
import 'package:projectweek1/Screens/Admin%20side/Admin%20recipe%20adding/recipe%20add/widget%20refactor%20recipe/adminfoodphoto.dart';
import 'package:projectweek1/Screens/Admin%20side/Admin%20recipe%20adding/recipe%20add/widget%20refactor%20recipe/numberpicker.dart';
import 'package:projectweek1/Screens/Admin%20side/Admin%20recipe%20adding/recipe%20add/widget%20refactor%20recipe/page1ref.dart';
// import 'package:projectweek1/firebase_helper/firebase_adminrec3.dart';
// import 'package:projectweek1/hive_helper/hive%20db/dbfunctions.dart';
// import 'package:projectweek1/hive_helper/hive%20db/recipe_model.dart';
import 'package:projectweek1/screens/Login%20pages/New%20user/new_user_login.dart';
import 'package:projectweek1/screens/Login%20pages/Normal%20login/main_login.dart';
import 'package:projectweek1/screens/User%20side/user_bottomnav.dart';
// import 'package:projectweek1/screens/admin_side/admin_recipe_adding/recipe%20add/refactoring/rec_page_2.dart';
// import 'package:projectweek1/screens/admin_side/admin_recipe_adding/recipe%20add/widget%20refactor%20recipe/adminfoodphoto.dart';
// import 'package:projectweek1/screens/admin_side/admin_recipe_adding/recipe%20add/widget%20refactor%20recipe/numberpicker.dart';
// import 'package:projectweek1/screens/admin_side/admin_recipe_adding/recipe%20add/widget%20refactor%20recipe/page1ref.dart';

class Userownrecipe extends StatefulWidget {
  String? id;
  bool usereditrecipe;
  String? name;
  List<String>? image;
  List<String>? ing;
  List<String>? dir;
  String? des;
  int? hour;
  int? min;
  Userownrecipe(
      {super.key,
      this.usereditrecipe = false,
      this.id,
      this.name,
      this.image,
      this.ing,
      this.des,
      this.dir,
      this.hour,
      this.min});

  @override
  State<Userownrecipe> createState() => _UserownrecipeState();
}

class _UserownrecipeState extends State<Userownrecipe> {
  TextEditingController foodnamecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  List<XFile> file = [];
  int selectedindex = 0;
  ValueNotifier<List<String>> ingredients = ValueNotifier([]);
  var formkey = GlobalKey<FormState>();
  ValueNotifier<List<String>> direction = ValueNotifier([]);
  TextEditingController ingredientscontroll = TextEditingController();
  TextEditingController directioncontroll = TextEditingController();
  TextEditingController editingController1 = TextEditingController();
  int hour = 0;
  int min = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.image != null) {
      file = widget.image!.map((e) => XFile(e)).toList();
    }
    if (widget.ing != null) {
      ingredients.value = widget.ing!;
    }
    if (widget.dir != null) {
      direction.value = widget.dir!;
    }
    hour = widget.hour ?? 0;
    min = widget.min ?? 0;
    descriptioncontroller.text = widget.des ?? "";
    foodnamecontroller.text = widget.name ?? "";
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            SizedBox(
              height: 5,
            ),
            widget.usereditrecipe
                ? Container(
                    child: text(name: 'Edit recipe'),
                  )
                : SizedBox(),
            widget.usereditrecipe
                ? SizedBox(
                    height: 10,
                  )
                : SizedBox(),
            TextFormField(
              controller: foodnamecontroller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  labelText: 'food name'),
            ),
            SizedBox(
              height: 10,
            ),
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
                  controller: descriptioncontroller,
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
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  // fixedSize: Size(double.infinity, 50)
                ),
                onPressed: () async {
                  List<String> paths = file.map((xFile) => xFile.path).toList();
                  if (foodnamecontroller.text.isEmpty) {
                    snakbar(context: context, txt: 'Please add the foodname');
                  } else {
                    if (paths.isEmpty ||
                        descriptioncontroller.text.isEmpty ||
                        ingredients.value.isEmpty ||
                        direction.value.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return userrecipeshowdialog(
                              context: context,
                              path: paths,
                              description: descriptioncontroller.text,
                              ingredients: ingredients.value,
                              direction: direction.value,
                              fun: () async {
                                Ownrecipe own = Ownrecipe(
                                    id: widget.usereditrecipe
                                        ? widget.id!
                                        : DateTime.now().toString(),
                                    description: descriptioncontroller.text,
                                    foodname: foodnamecontroller.text,
                                    file: paths.isEmpty
                                        ? ['assets/images/11861789_7575.jpg']
                                        : paths,
                                    ingredients: ingredients.value,
                                    direction: direction.value,
                                    min: min,
                                    hour: hour,
                                    uid: useremail,
                                    datetime: DateTime.now());
                                await addrecipe(own: own);
                                await getrecipe();
                              });
                        },
                      );
                    } else {
                      Ownrecipe own = Ownrecipe(
                          id: widget.usereditrecipe
                              ? widget.id!
                              : DateTime.now().toString(),
                          description: descriptioncontroller.text,
                          foodname: foodnamecontroller.text,
                          file: paths,
                          ingredients: ingredients.value,
                          direction: direction.value,
                          min: min,
                          hour: hour,
                          uid: useremail,
                          datetime: DateTime.now());
                      await addrecipe(own: own);
                      await getrecipe();
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => Userbottomnav(
                              index: 4,
                            ),
                          ),
                          (route) => false);
                    }
                  }
                },
                child: text(
                    name: widget.usereditrecipe ? "Edit" : 'Add',
                    colour: Colors.white))
          ],
        ),
      ),
    ));
  }
}

Widget userrecipeshowdialog(
    {required BuildContext context,
    required List<String> path,
    required String description,
    required List<String> ingredients,
    required List<String> direction,
    required Function fun}) {
  // String p=path.isEmpty?'photos':"";
  // String des=description.isEmpty?'description':"";
  // String ing=ingredients.isEmpty?"ingredients":"";
  // String dir=direction.isEmpty?"ingredients":"";
  String a = userrecipeaddbutton(
      path: path,
      description: description,
      ingredients: ingredients,
      direction: direction);
  return AlertDialog(
    title:
        text(name: "You have not added$a? Are you sure you want to continue?"),
    actions: [
      TextButton(
          onPressed: () async {
            await fun();
            // navigatorpop(context);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => Userbottomnav(
                    index: 4,
                  ),
                ),
                (route) => false);
          },
          child: text(name: 'Yes')),
      TextButton(
          onPressed: () {
            navigatorpop(context);
          },
          child: text(name: 'NO'))
    ],
  );
}

String userrecipeaddbutton(
    {required List<String> path,
    required String description,
    required List<String> ingredients,
    required List<String> direction}) {
  // String p = path.isEmpty ? 'photos' : "";
  // String des = description.isEmpty ? 'description' : "";
  // String ing = ingredients.isEmpty ? "ingredients" : "";
  // String dir = direction.isEmpty ? "direction" : "";
  String newstring = "";
  List<String> abc = [];
  if (path.isEmpty) {
    abc.add('photos');
  }
  if (description.isEmpty) {
    abc.add('description');
  }
  if (ingredients.isEmpty) {
    abc.add('ingredients');
  }
  if (direction.isEmpty) {
    abc.add('direction');
  }
  for (int i = 0; i < abc.length; i++) {
    newstring = newstring + " " + abc[i];
    if (abc.length - 2 == i && abc.length != 1) {
      newstring = newstring + " and";
    }
  }
  return newstring;
  // if(p=='photos'&&des=='description'&&ing=='ingredients'&&dir=='direction'){
  //   return 'You have not added $p, $des, $ing and $dir.';
  // }
  // if (path.isEmpty&&description.isEmpty&&ingredients.isEmpty&&direction.isEmpty) {
  //   return "You have not added any photos, description, ingredients or direction";
  // }else if(path.isEmpty){

  // }
}
