// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projectweek1/Firebase%20helper/firebase_adminrec3.dart';
import 'package:projectweek1/Screens/Admin%20side/Admin%20recipe%20adding/firebasestoragefunctions.dart';
import 'package:projectweek1/Screens/Admin%20side/Admin%20recipe%20adding/recipe%20add/recipe%20main/rec_page_1.dart';
import 'package:projectweek1/Screens/Login%20pages/New%20user/Introduction%20Screens/onboard2.dart';
import 'package:projectweek1/Screens/Login%20pages/New%20user/new_user_login.dart';

List<String?> firebasedoclist =
    fetchingcategoryphotoandname['categoryname'] ?? [];

// ignore: must_be_immutable
class Adminrecipeaddpage3 extends StatefulWidget {
  Adminrecipeaddpage3({
    super.key,
  });

  @override
  State<Adminrecipeaddpage3> createState() => _Adminrecipeaddpage3State();
}

class _Adminrecipeaddpage3State extends State<Adminrecipeaddpage3> {
  int index = 0;
  XFile? f;
  List<String> photo = [];
  bool isloading = false;
  bool isbool = false;
  List<XFile> img = [];
  var formkey = GlobalKey<FormState>();
  TextEditingController categorycontroller = TextEditingController();
  List<String?> categorylist =
      fetchingcategoryphotoandname['categoryname'] ?? [];
  List<String> showcategoryphoto =
      fetchingcategoryphotoandname['categoryphoto'] ?? [];
  ValueNotifier<String?> categorypicture = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          text(name: 'Select category'),
          DropdownButtonFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:
                        const BorderSide(color: Colors.black, width: 2))),
            hint: text(name: 'Category is not added'),
            items: categorylist.map((e) {
              return DropdownMenuItem(value: e, child: text(name: e!));
            }).toList(),
            onChanged: (value) {
              setState(() {
                index = categorylist.indexOf(value);
                drop = value ?? drop;
              });
            },
            value: drop,
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
              height: 200,
              child: showcategoryphoto.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        showcategoryphoto[index],
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        (loadingProgress.expectedTotalBytes ??
                                            1)
                                    : null,
                              ),
                            );
                          }
                        },
                        fit: BoxFit.cover,
                      ),
                    )
                  : const SizedBox()),
          TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return ValueListenableBuilder(
                      valueListenable: categorypicture,
                      builder: (context, value, child) {
                        return AlertDialog(
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Form(
                                key: formkey,
                                child: TextFormField(
                                  controller: categorycontroller,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a category';
                                    } else if (categorylist.contains(value)) {
                                      return 'This name alredy exists';
                                    } else if (value.trim() == 'Trending') {
                                      return 'category Trending cannot be added';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              categorypicture.value == null
                                  ? InkWell(
                                      onTap: () async {
                                        f = await ImagePicker().pickImage(
                                            source: ImageSource.gallery);
                                        if (f != null) {
                                          categorypicture.value = f!.path;
                                          categorypicture.notifyListeners();
                                        }
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: isbool
                                                    ? Colors.red
                                                    : Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        height: 100,
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: onboardtext(
                                                text:
                                                    'Click here to pick an image for the category',
                                                colour: Colors.black),
                                          ),
                                        ),
                                      ),
                                    )
                                  : SizedBox(
                                      height: 100,
                                      child: Image.file(
                                        File(categorypicture.value!),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                              isbool
                                  ? Align(
                                      alignment: Alignment.topLeft,
                                      child: text(
                                          name: 'Please select a photo',
                                          colour: Colors.red))
                                  : const SizedBox(),
                            ],
                          ),
                          actions: [
                            TextButton(
                                onPressed: () async {
                                  await categoryalertdialog();
                                },
                                child: isloading
                                    ? const CircularProgressIndicator()
                                    : text(name: 'Add')),
                            TextButton(
                                onPressed: () {
                                  categorycontroller.clear();
                                  categorypicture.value = null;
                                  categorypicture.notifyListeners();
                                },
                                child: text(name: 'Clear'))
                          ],
                        );
                      },
                    );
                  },
                );
              },
              child: text(name: '+Add new category')),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              text(name: 'Trending'),
              Checkbox(
                value: checkbox,
                onChanged: (value) {
                  setState(() {
                    checkbox = value;
                  });
                },
              )
            ],
          ),
        ],
      ),
    );
  }

  categoryalertdialog() async {
    if (formkey.currentState!.validate() &&
        categorypicture.value != null &&
        categorycontroller.text.trim() != 'Trending') {
      isbool = false;
      categorypicture.notifyListeners();
      isloading = true;
      categorypicture.notifyListeners();

      img.add(f!);
      photo = await uploadimagetostorage(img);
      img.clear();
      await firebaseaddingcategory(
          drop: categorycontroller.text, urls: photo[0]);

      photo.clear();
      await firebasegetinglist();
      setState(() {
        showcategoryphoto = fetchingcategoryphotoandname['categoryphoto'];
        categorylist = fetchingcategoryphotoandname['categoryname'];
        drop = categorycontroller.text;
        index = categorylist.indexOf(categorycontroller.text);

        navigatorpop(context);
        categorycontroller.clear();
        categorypicture.value = null;
      });
      isloading = false;
      categorypicture.notifyListeners();
    } else {
      isbool = true;
      categorypicture.notifyListeners();
    }
  }
}
