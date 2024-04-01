import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

uploadeverythingtofirebase({required String category,required Map<String,dynamic> foodlist,required bool checkbox})async{
  try{
    String datetime=DateTime.now().microsecondsSinceEpoch.toString();
    if(checkbox){
await FirebaseFirestore.instance.collection('category').doc('Trending').set({datetime:foodlist},SetOptions(merge: true));

    }
await FirebaseFirestore.instance.collection('category').doc(category).set({datetime:foodlist},SetOptions(merge: true));
  }catch(e){
    print(e);
  }
}
Future<bool> firebaseaddingcategory(
    {required String drop, required String urls}) async {
  try {
    await FirebaseFirestore.instance
        .collection('category')
        .doc(drop)
        .set({'categoryimg': urls}, SetOptions(merge: true));
    return true;
  } catch (e) {
    print('some error');
    return false;
  }
}
navigatorpop(context) {
  Navigator.pop(context);
}