import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
Map<String,dynamic> fetchingcategoryphotoandname={};

Future<List<String>> uploadimagetostorage(List<XFile> images) async {
  Reference refdir = FirebaseStorage.instance.ref().child('Category');
  List<String> urls = [];
  for (int i = 0; i < images.length; i++) {
    // String a=i as String;
    Reference refupload = refdir.child(images[i].name);
    try {
      await refupload.putFile(File(images[i].path));
      urls.add(await refupload.getDownloadURL());
      // print("$i ----------------------------------- $urls");
    } catch (e) {
      print('fksddfjklds  $e');
    }
  }
  return urls;
}


Future<Map<String,dynamic>> firebasegetinglist({bool istrend=true})async{
  
  List<String> a=[];
  List<String> photolist=[];
try{
 QuerySnapshot doc=await FirebaseFirestore.instance.collection('category').get();
 for(QueryDocumentSnapshot docs in doc.docs){
 String b= docs.id;
 Map<String,dynamic> docdata= docs.data() as Map<String,dynamic>;
 String photo=docdata['categoryimg'];
 print('new $b');
if(istrend){

if(b!="Trending"){

a.add(b);
photolist.add(photo);
}
}
 }
fetchingcategoryphotoandname={'categoryname':a,
                              'categoryphoto':photolist};
 return fetchingcategoryphotoandname;

}catch(e){
return fetchingcategoryphotoandname;
}
}




















//   Future<String> uploadimagetostorage({required String foodname, required var file})async{
//  UploadTask uploadTask= FirebaseStorage.instance.ref().child('foodname').putData(file);  
//  TaskSnapshot snapshot=await uploadTask;
//  String downurl=await snapshot.ref.getDownloadURL();
//  return downurl;
//   // UploadTask uploadTask=ref
// }
// savedata({required String foodname, required String file})async{
// String url=await uploadimagetostorage(foodname: foodname, file: file);
// try{
// if(foodname.isNotEmpty||file.isNotEmpty){

// await FirebaseFirestore.instance.collection('Category').add({
//   'foodname':foodname,
//   'imageurl':url,
// });
// }

// }catch(e){
//   print(e);
// }
// }
// saveprofile()async{
//   // String resp= await StoreData
// }