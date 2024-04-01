import 'package:flutter/material.dart';
import 'package:projectweek1/Screens/Admin%20side/Admin%20recipe%20adding/recipe%20add/widget%20refactor%20recipe/page2ref.dart';
import 'package:projectweek1/Screens/Admin%20side/Admin%20recipe%20adding/recipe%20add/widget%20refactor%20recipe/valuenotify.dart';
import 'package:projectweek1/Screens/Login%20pages/New%20user/new_user_login.dart';

// ignore: must_be_immutable
class Adminrecipeaddpage2 extends StatefulWidget {
  ValueNotifier<List<String>> ingredients = ValueNotifier([]);
  ValueNotifier<List<String>> direction = ValueNotifier([]);
  var formkey = GlobalKey<FormState>();
  TextEditingController ingredientscontroll = TextEditingController();
  TextEditingController directioncontroll = TextEditingController();
  TextEditingController editingController1 = TextEditingController();
  Adminrecipeaddpage2({
    super.key,
    required this.direction,
    required this.ingredients,
    required this.directioncontroll,
    required this.editingController1,
    required this.formkey,
    required this.ingredientscontroll,
  });

  @override
  State<Adminrecipeaddpage2> createState() => _Adminrecipeaddpage2State();
}

class _Adminrecipeaddpage2State extends State<Adminrecipeaddpage2> {
  late ValueNotifier<List<String>> ingredients;
  late ValueNotifier<List<String>> direction;
  var formkey = GlobalKey<FormState>();
  late TextEditingController ingredientscontroll;
  late TextEditingController directioncontroll;
  late TextEditingController editingController1;
  late Valnotify notify = Valnotify();
  late int hour;
  late int min;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ingredients = widget.ingredients;
    direction = widget.direction;
    ingredientscontroll = widget.ingredientscontroll;
    directioncontroll = widget.directioncontroll;
    editingController1 = widget.editingController1;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        text(name: 'Add ingredients', fsize: 17),
        SizedBox(
          height: height * 0.015,
        ),
        listenablebuilder(
            formkey: formkey,
            editingController1: editingController1,
            width: width,
            list: ingredients),
        textformfeild(
            txtedit: ingredientscontroll,
            list: ingredients,
            hint: 'ingredients'),
        SizedBox(
          height: height * 0.015,
        ),
        text(name: 'Direction to use the ingredients', fsize: 17),
        SizedBox(
          height: height * 0.015,
        ),
        listenablebuilder(
            editingController1: editingController1,
            formkey: formkey,
            width: width,
            list: direction),
        textformfeild(
            txtedit: directioncontroll, list: direction, hint: 'direction'),
        SizedBox(
          height: height * 0.015,
        ),
        text(name: 'Select duration', fsize: 17),
      ],
    );
  }
}
