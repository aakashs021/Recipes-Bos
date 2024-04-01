import 'package:flutter/material.dart';

class Valnotify extends ChangeNotifier {
  itemsadding(
      {required TextEditingController txtedit,
      required ValueNotifier<List<String>> list}) {
    if (txtedit.text.isNotEmpty) {
      list.value.add(txtedit.text);
      list.notifyListeners();
      txtedit.clear();
    }
  }

  itemeditting(
      {required var formkey,
      required ValueNotifier<List<String>> list,
      required int index,
      required TextEditingController editingController,
      required context}) {
    if (formkey.currentState!.validate()) {
      list.value[index] = editingController.text;
      list.notifyListeners();
      editingController.clear();
      Navigator.pop(context);
    }
  }

  itemdelete(
      {required ValueNotifier<List<String>> list,
      required int index,
      required context}) {
    list.value.removeAt(index);
    list.notifyListeners();
    Navigator.pop(context);
  }
//  Future<XFile> addcategoryimage({required XFile? f,required  ValueNotifier<String?> categorypicture})async{
//     f = await ImagePicker().pickImage(
//            source: ImageSource.gallery);
//        if (f != null) {
//          categorypicture.value = f.path;
//          categorypicture.notifyListeners();
//        }
//        return  f;
//   }
//   addcategoryimageclear({required   ValueNotifier<String?> categorypicture,required TextEditingController categorycontroller}){
//     categorycontroller.clear();
//     categorypicture.value = null;
//     categorypicture.notifyListeners();
//   }
}