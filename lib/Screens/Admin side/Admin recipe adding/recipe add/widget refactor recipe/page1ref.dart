import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projectweek1/Firebase%20helper/firebase_adminrec3.dart';
import 'package:projectweek1/Screens/Admin%20side/Admin%20recipe%20adding/firebasestoragefunctions.dart';
import 'package:projectweek1/Screens/Admin%20side/Admin%20recipe%20adding/recipe%20add/recipe%20main/rec_page_1.dart';
import 'package:projectweek1/Screens/Admin%20side/admin_bottomnavbar.dart';
import 'package:projectweek1/Screens/Login%20pages/New%20user/new_user_login.dart';

Widget textformfeild({required TextEditingController foodname}) {
  return TextFormField(
    controller: foodname,
    decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        hintText: 'Name of the food'),
  );
}

Widget positioned({
  double right = 0,
  double? bottom,
  required List<XFile> file,
  int selectedindex = 0,
  double? top = 0,
  Function(List<XFile>)? addbutton,
  Function(XFile, int)? onedit,
}) {
  return bottom != null
      ? Positioned(
          right: right,
          bottom: 0,
          child: ElevatedButton(
              onPressed: () async {
                file.addAll(await ImagePicker().pickMultiImage());
                addbutton!(file);
              },
              child: const Icon(Icons.add)),
        )
      : Positioned(
          right: right,
          bottom: bottom,
          top: top,
          child: IconButton(
              onPressed: () async {
                XFile? f =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                if (f != null) {
                  onedit!(f, selectedindex);
                }
              },
              icon: const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.edit,
                    size: 30,
                    color: Colors.blue,
                  ))));
}

multiplefoodphoto(
    {required List<XFile> file, required Function onselectedfile}) async {
  file.addAll(await ImagePicker().pickMultiImage());
  onselectedfile();
}

snakbar({
  required context,
  double width = 0,
  int index = 0,
  var temp,
  bool issnack = false,
  required String txt,
  Function? onundo,
}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      padding: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      duration: const Duration(seconds: 3),
      dismissDirection: DismissDirection.horizontal,
      backgroundColor: Colors.red,
      content: issnack
          ? SizedBox(
              height: 40,
              width: width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  text(name: '  Deleted', colour: Colors.white),
                  TextButton.icon(
                      onPressed: () {
                        onundo!();
                      },
                      icon: Icon(
                        Icons.undo,
                        color: Colors.blue[900],
                      ),
                      label: text(name: 'Undo', colour: Colors.blue.shade900)),
                ],
              ))
          : Padding(
              padding: const EdgeInsets.only(left: 10),
              child: text(name: '$txt', colour: Colors.white),
            )));
}

adminnextbutton({
  required context,
  required TextEditingController foodname,
  required List<XFile> file,
  required TextEditingController description,
  required ValueNotifier<List<String>> ingredients,
  required ValueNotifier<List<String>> direction,
  required int hour,
  required int min,
  required Function isload,
}) async {
  if (foodname.text.isNotEmpty &&
      file.isNotEmpty &&
      description.text.isNotEmpty &&
      ingredients.value.isNotEmpty &&
      direction.value.isNotEmpty &&
      (hour != 0 || min != 0 && drop != null)) {
    isload();

    List<String> urls = await uploadimagetostorage(file);
    Map<String, dynamic> m = {
      'foodname': foodname.text,
      'file': urls,
      'direction': direction.value,
      'description': description.text,
      'ingredients': ingredients.value,
      'hour': hour,
      'min': min
    };

    await uploadeverythingtofirebase(
        category: drop!, foodlist: m, checkbox: checkbox ?? false);
    await firebasegetinglist();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => Adminbottomnav(
            index: 2,
          ),
        ),
        (route) => false);
  } else if (foodname.text.isEmpty) {
    snakbar(context: context, txt: 'Please enter the food name');
  } else if (file.isEmpty) {
    snakbar(context: context, txt: 'Please add photos of food');
  } else if (description.text.isEmpty) {
    snakbar(context: context, txt: 'Please add the description');
  } else if (ingredients.value.isEmpty) {
    snakbar(context: context, txt: 'Please add ingredients');
  } else if (direction.value.isEmpty) {
    snakbar(context: context, txt: 'Please add directions');
  } else if (hour != 0 || min != 0) {
    snakbar(context: context, txt: 'Please add preparation time');
  } else {
    snakbar(context: context, txt: 'Category is not selected');
  }
}
