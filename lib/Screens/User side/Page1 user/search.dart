// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:projectweek1/Hive%20helper/Hive%20favourites/favfunctions.dart';
// import 'package:projectweek1/Hive%20helper/Hive%20favourites/favourite_model.dart';
// import 'package:projectweek1/Screens/Login%20pages/New%20user/new_user_login.dart';
// import 'package:projectweek1/Screens/User%20side/Page2%20user/cate3ind.dart';
// import 'package:projectweek1/Screens/User%20side/Page2%20user/cate3trial.dart';

// class Usersearch extends StatefulWidget {
//   const Usersearch({super.key});

//   @override
//   State<Usersearch> createState() => _UsersearchState();
// }

// class _UsersearchState extends State<Usersearch> {
//   TextEditingController searchfood = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     // print(sub.length);
//     return Scaffold(
//       appBar: AppBar(
//         title: TextFormField(
//           controller: searchfood,
//           decoration: const InputDecoration(hintText: 'Search'),
//           // onChanged: ,
//         ),
//       ),
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance.collection('category').snapshots(),
//         builder: (BuildContext context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const CircularProgressIndicator();
//           } else if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           } else {
//             List<Map<String, dynamic>> sublist = [];
//             List<String> foodid = [];
//             List<String> subfoodid = [];
//             List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
//             for (int i = 0; i < documents.length; i++) {
//               Map<String, dynamic> a = {};
//               a = documents[i].data() as Map<String, dynamic>;
//               for (var d in a.keys) {
//                 if (d != 'categoryimg') {
//                   subfoodid.add(d);
//                 }
//               }
//               for (var d in a.values) {
//                 if (d is Map<String, dynamic>) {
//                   if (!foodid.contains(d)) {
//                     sublist.add(d);
//                   }
//                 }
//               }
//             }
//             bool areListsEqual<T>(List<T> list1, List<T> list2) {
//               bool r = true;
//               if (list1.length != list2.length) {
//                 r = false;
//               } else {
//                 for (int i = 0; i < list1.length; i++) {
//                   if (list1[i] != list2[i]) {
//                     r = false;
//                   }
//                 }
//               }
//               r = true;
//               return r;
//             }

//             for (int i = 0; i < sublist.length; i++) {
//               for (int j = 0; j < sublist.length; j++) {
//                 if (i != j &&
//                     sublist[i]['foodname'] == sublist[j]['foodname'] &&
//                     sublist[i]['description'] == sublist[j]['description'] &&
//                     sublist[i]['hour'] == sublist[j]['hour'] &&
//                     sublist[i]['min'] == sublist[j]['min'] &&
//                     areListsEqual(sublist[i]['file'], sublist[j]['file']) &&
//                     areListsEqual(
//                         sublist[i]['ingredients'], sublist[j]['ingredients']) &&
//                     areListsEqual(
//                         sublist[i]['direction'], sublist[j]['direction'])) {
//                   subfoodid.removeAt(j);
//                   sublist.removeAt(j);
//                 } else {
//                   // print('nothing');
//                 }
//               }
//             }
//             List<Map<String, dynamic>> sub = sublist.toList();
//             foodid = subfoodid;
//             List<Map<String, dynamic>> searchfilterlist = [];

//             searchfilterfunction() {
//               if (searchfood.text.isEmpty) {
//                 searchfilterlist = [];
//               } else {
//                 final suggestion = sub.where((res) {
//                   final foodname = res['foodname'].toString().toLowerCase();
//                   final searchtxt = searchfood.text.toLowerCase();
//                   return foodname.contains(searchtxt);
//                 }).toList();
//                 setState(() {
//                   searchfilterlist = suggestion;
//                 });
//               }
//             }

//             return ValueListenableBuilder(
//               valueListenable: favlist,
//               builder: (context, value, child) {
//                 return ListView.builder(
//                   itemCount: searchfilterlist.length,
//                   itemBuilder: (context, index) {
//                     bool isfav = false;

//                     for (int i = 0; i < favlist.value.length; i++) {
//                       if (favlist.value[i].id == foodid[index]) {
//                         isfav = true;
//                       }
//                     }
//                     return InkWell(
//                       onTap: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) {
//                             return Userfullreciptrial(
//                                 foodid: foodid[index],
//                                 category: 'category',
//                                 description: sub[index]['description'],
//                                 min: sub[index]['min'],
//                                 hour: sub[index]['hour'],
//                                 ingredients: sub[index]['ingredients'],
//                                 foodname: sub[index]['foodname'],
//                                 foodphotolist: List.from(sub[index]['file']),
//                                 direction: sub[index]['direction']);
//                           },
//                         ));
//                       },
//                       child: Container(
//                         margin: const EdgeInsets.all(10),
//                         child: Stack(
//                           children: [
//                             ClipRRect(
//                               borderRadius: BorderRadius.circular(20),
//                               child: CachedNetworkImage(
//                                 fit: BoxFit.cover,
//                                 width: double.infinity,
//                                 height: 225,
//                                 imageUrl: searchfilterlist[index]['file'][0],
//                                 placeholder: (context, url) {
//                                   return Image.asset(
//                                     'assets/images/11861789_7575.jpg',
//                                     width: double.infinity,
//                                     fit: BoxFit.cover,
//                                   );
//                                 },
//                               ),
//                             ),
//                             Positioned(
//                               top: 10,
//                               left: 10,
//                               child: text(
//                                   name: searchfilterlist[index]['foodname'],
//                                   colour: Colors.white),
//                             ),
//                             Positioned(
//                                 right: 0,
//                                 child: IconButton(
//                                     onPressed: () async {
//                                       Favourite favor = Favourite(
//                                           id: foodid[index],
//                                           foodname: sub[index]['foodname'],
//                                           file: List.from(sub[index]['file']),
//                                           description: sub[index]
//                                               ['description'],
//                                           ingredients: List.from(
//                                               sub[index]['ingredients']),
//                                           direction: List.from(
//                                               sub[index]['direction']),
//                                           hour: sub[index]['hour'],
//                                           date: DateTime.now(),
//                                           min: sub[index]['min']);
//                                       isfav
//                                           ? await deletefavorite(
//                                               favourite: favor)
//                                           : await addfavourite(favor: favor);
//                                       await getfavourite();

//                                       isfav = !isfav;
//                                       // print('trending ${foodid[index]}');
//                                     },
//                                     icon: Icon(
//                                       isfav
//                                           ? Icons.favorite
//                                           : Icons.favorite_border,
//                                       color: isfav ? Colors.red : Colors.white,
//                                     ))),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }

// searchlistingpagewidget({required snapshot}) {
//   List<Map<String, dynamic>> sublist = [];
//   List<String> foodid = [];
//   List<String> subfoodid = [];
//   List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
//   for (int i = 0; i < documents.length; i++) {
//     Map<String, dynamic> a = {};
//     a = documents[i].data() as Map<String, dynamic>;
//     for (var d in a.keys) {
//       if (d != 'categoryimg') {
//         subfoodid.add(d);
//       }
//     }
//     for (var d in a.values) {
//       if (d is Map<String, dynamic>) {
//         if (!foodid.contains(d)) {
//           sublist.add(d);
//         }
//       }
//     }
//   }
//   bool areListsEqual<T>(List<T> list1, List<T> list2) {
//     bool r = true;
//     if (list1.length != list2.length) {
//       r = false;
//     } else {
//       for (int i = 0; i < list1.length; i++) {
//         if (list1[i] != list2[i]) {
//           r = false;
//         }
//       }
//     }
//     r = true;
//     return r;
//   }

//   // print(subfoodid);
//   for (int i = 0; i < sublist.length; i++) {
//     for (int j = 0; j < sublist.length; j++) {
//       if (i != j &&
//           sublist[i]['foodname'] == sublist[j]['foodname'] &&
//           sublist[i]['description'] == sublist[j]['description'] &&
//           sublist[i]['hour'] == sublist[j]['hour'] &&
//           sublist[i]['min'] == sublist[j]['min'] &&
//           areListsEqual(sublist[i]['file'], sublist[j]['file']) &&
//           areListsEqual(sublist[i]['ingredients'], sublist[j]['ingredients']) &&
//           areListsEqual(sublist[i]['direction'], sublist[j]['direction'])) {
//         subfoodid.removeAt(j);
//         sublist.removeAt(j);
//       } else {
//         // print('nothing');
//       }
//     }
//   }
//   List<Map<String, dynamic>> sub = sublist.toList();
//   foodid = subfoodid;
//   // print(foodid);
//   return ValueListenableBuilder(
//     valueListenable: favlist,
//     builder: (context, value, child) {
//       return ListView.builder(
//         itemCount: sub.length,
//         itemBuilder: (context, index) {
//           bool isfav = false;

//           for (int i = 0; i < favlist.value.length; i++) {
//             if (favlist.value[i].id == foodid[index]) {
//               isfav = true;
//             }
//           }
//           return InkWell(
//             onTap: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                 builder: (context) {
//                   return Userfullreciptrial(
//                       foodid: foodid[index],
//                       category: 'category',
//                       description: sub[index]['description'],
//                       min: sub[index]['min'],
//                       hour: sub[index]['hour'],
//                       ingredients: sub[index]['ingredients'],
//                       foodname: sub[index]['foodname'],
//                       foodphotolist: List.from(sub[index]['file']),
//                       direction: sub[index]['direction']);
//                 },
//               ));
//             },
//             child: Container(
//               margin: const EdgeInsets.all(10),
//               child: Stack(
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(20),
//                     child: CachedNetworkImage(
//                       fit: BoxFit.cover,
//                       width: double.infinity,
//                       height: 225,
//                       imageUrl: sub[index]['file'][0],
//                       placeholder: (context, url) {
//                         return Image.asset(
//                           'assets/images/11861789_7575.jpg',
//                           width: double.infinity,
//                           fit: BoxFit.cover,
//                         );
//                       },
//                     ),
//                   ),
//                   Positioned(
//                     top: 10,
//                     left: 10,
//                     child: text(
//                         name: sub[index]['foodname'], colour: Colors.white),
//                   ),
//                   Positioned(
//                       right: 0,
//                       child: IconButton(
//                           onPressed: () async {
//                             Favourite favor = Favourite(
//                                 id: foodid[index],
//                                 foodname: sub[index]['foodname'],
//                                 file: List.from(sub[index]['file']),
//                                 description: sub[index]['description'],
//                                 ingredients:
//                                     List.from(sub[index]['ingredients']),
//                                 direction: List.from(sub[index]['direction']),
//                                 hour: sub[index]['hour'],
//                                 date: DateTime.now(),
//                                 min: sub[index]['min']);
//                             isfav
//                                 ? await deletefavorite(favourite: favor)
//                                 : await addfavourite(favor: favor);
//                             await getfavourite();

//                             isfav = !isfav;
//                             // print('trending ${foodid[index]}');
//                           },
//                           icon: Icon(
//                             isfav ? Icons.favorite : Icons.favorite_border,
//                             color: isfav ? Colors.red : Colors.white,
//                           ))),
//                 ],
//               ),
//             ),
//           );
//         },
//       );
//     },
//   );
// }
