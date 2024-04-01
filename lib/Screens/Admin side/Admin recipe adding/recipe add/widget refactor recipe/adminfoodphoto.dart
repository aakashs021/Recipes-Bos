// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projectweek1/Screens/Admin%20side/Admin%20recipe%20adding/recipe%20add/widget%20refactor%20recipe/page1ref.dart';
import 'package:projectweek1/Screens/Login%20pages/New%20user/new_user_login.dart';

class Addfoodphoto extends StatefulWidget {
  List<XFile> file;
  double width,height;
  int selectedindex;
   Addfoodphoto({super.key,required this.file,required this.width,required this.height,required this.selectedindex});

  @override
  State<Addfoodphoto> createState() => _AddfoodphotoState();
}

class _AddfoodphotoState extends State<Addfoodphoto> {
  late List<XFile> file;
  late double width,height;
  late int selectedindex;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    file=widget.file;
    width=widget.width;
    height=widget.height;
    selectedindex=widget.selectedindex;
  }
  @override
  Widget build(BuildContext context) {
    return  file.isEmpty
                  ? InkWell(
                      onTap: () async {
                        await multiplefoodphoto(
                            file: file,
                            onselectedfile: () {
                              setState(() {
                                file = file;
                              });
                            });
                      },
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(20),
                        child: SizedBox(
                          width: width,
                          height: height * 0.3,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 50,
                              ),
                              const Stack(
                                children: [
                                  Icon(
                                    Icons.crop_free_sharp,
                                    size: 125,
                                    color: Colors.black45,
                                  ),
                                  Positioned(
                                      top: 25,
                                      left: 25,
                                      child: Icon(
                                        Icons.camera_alt_outlined,
                                        size: 75,
                                        color: Colors.black45,
                                      )),
                                ],
                              ),
                              Center(
                                  child: text(
                                      name: 'Add the images of food',
                                      colour: Colors.black45)),
                            ],
                          ),
                        ),
                      ))
                  : Column(
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                              width: width,
                              height: height * 0.3,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.file(
                                  File(file[selectedindex].path),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            positioned(
                                file: file,
                                bottom: 0,
                                addbutton: (file) {
                                  setState(() {
                                    file = file;
                                  });
                                }),
                            positioned(
                                file: file,
                                selectedindex: selectedindex,
                                right: width * 0.15,
                                onedit: (f, selectedindex) {
                                  setState(() {
                                    file[selectedindex] = f;
                                  });
                                }),
                            Positioned(
                                right: 0,
                                top: 0,
                                child: IconButton(
                                    onPressed: () {
                                      int index = selectedindex;
                                      XFile temp = file[index];
                                      file.removeAt(selectedindex);
                                      if (selectedindex >= file.length) {
                                        if (file.isNotEmpty) {
                                          selectedindex--;
                                        }
                                      }
                                      setState(() {
                                        file = file;
                                      });
                                      snakbar(txt: '',
                                          context: context,
                                          index: index,
                                          temp: temp,
                                          width: width,
                                          issnack: true,
                                          onundo: () {
                                            setState(() {
                                              if (file.isNotEmpty) {
                                                file.insert(index, temp);
                                              } else {
                                                file.add(temp);
                                              }
                                            });
                                            ScaffoldMessenger.of(context)
                                                .hideCurrentSnackBar();
                                          });
                                    },
                                    icon: const CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: Icon(
                                          Icons.delete,
                                          size: 30,
                                          color: Colors.red,
                                        ))))
                          ],
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        SizedBox(
                          height: height * 0.07,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: file.length,
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
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                                color: Colors.blue, width: 2))
                                        : null,
                                    margin: const EdgeInsets.only(left: 10),
                                    width: 150,
                                    height: 10,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(18),
                                      child: Image.file(
                                        File(file[index].path),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ));
                            },
                          ),
                        ),
                      ],
                    );
  }
}