// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:projectweek1/Firebase%20helper/firebase_adminrec3.dart';
// import 'package:projectweek1/Screens/Admin%20side/Admin%20category/admin_categoriespage.dart';
// import 'package:projectweek1/Screens/Admin%20side/Admin%20category/foodlisting.dart';
// // import 'package:projectweek1/Screens/Admin%20side/Admin%20category/individualedit.dart';
// import 'package:projectweek1/Screens/Login%20pages/New%20user/new_user_login.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';



// // ignore: must_be_immutable
// class Userfullrecipe extends StatefulWidget {
//   String foodname;
//   String foodid;
// int? editindex;
//   int hour;
//   int min;
//   String description;
//   String category;
//   List<String> foodphotolist;
//   List<dynamic> ingredients;
//   List<dynamic> direction;
//   Userfullrecipe({
//     super.key,
//      this.editindex,
//     required this.foodid,
//     required this.category,
//     required this.description,
//     required this.min,
//     required this.hour,
//     required this.ingredients,
//     required this.foodname,
//     required this.foodphotolist,
//     required this.direction,
//   });

//   @override
//   State<Userfullrecipe> createState() => _FullrecipeState();
// }

// class _FullrecipeState extends State<Userfullrecipe> {
//   int selectedindex = 0;

//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         elevation: 0,
//         leading: IconButton(
//             onPressed: () {
//               navigatorpop(context);
//             },
//             icon: const Icon(
//               Icons.arrow_back_ios,
//               color: Colors.white,
//             )),
//         backgroundColor: Colors.transparent,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             SizedBox(
//                 width: double.infinity,
//                 height: height * 0.3,
//                 child: Stack(
//                   children: [
//                     CarouselSlider.builder(
//                         itemCount: widget.foodphotolist.length,
//                         itemBuilder: (context, index, realIndex) {
//                           return ClipRRect(
//                             borderRadius: const BorderRadius.vertical(
//                                 bottom: Radius.circular(20)),
//                             child: CachedNetworkImage(
//                               fit: BoxFit.cover,
//                               width: double.infinity,
//                               height: double.infinity,
//                               imageUrl: widget.foodphotolist[index],
//                               placeholder: (context, url) {
//                                 return Stack(
//                                   children: [
//                                     const CircularProgressIndicator(
//                                       color: Colors.blue,
//                                     ),
//                                     Image.asset(
//                                       'assets/images/11861789_7575.jpg',
//                                       fit: BoxFit.cover,
//                                       width: double.infinity,
//                                     ),
//                                   ],
//                                 );
//                               },
//                             ),
//                           );
//                         },
//                         options: CarouselOptions(
//                           height: height * 0.3,
//                           autoPlayAnimationDuration: const Duration(seconds: 1),
//                           viewportFraction: 1,
//                           autoPlay: true,
//                           onPageChanged: (index, reason) {
//                             setState(() {
//                               selectedindex = index;
//                             });
//                           },
//                         )),
//                     Positioned(
//                         bottom: height*0.017,
//                         left: 20,
//                         child: text(
//                             name: widget.foodname,
//                             colour: Colors.white,
//                             fsize: 20)),
//                     SizedBox(width: double.infinity,
//                     height: double.infinity,
//                       child: Align(
//                         alignment: Alignment.bottomCenter,
//                         child: AnimatedSmoothIndicator(
//                             activeIndex: selectedindex,
//                             effect:
//                                 const JumpingDotEffect(activeDotColor: Colors.blue,dotColor: Colors.white, dotWidth: 15, dotHeight: 15,radius: 10),
//                             count: widget.foodphotolist.length),
//                       ),
//                     )
//                   ],
//                 )),
//             SizedBox(
//               height: height * 0.02,
//             ),
//             text(name: ' Description', fsize: 18),
//             text(name: '  ${widget.description}'),
//             SizedBox(
//               height: height * 0.02,
//             ),
//             text(name: ' Ingredients', fsize: 18),
//             listview(list: widget.ingredients),
//             SizedBox(
//               height: height * 0.02,
//             ),
//             text(name: ' Direction', fsize: 18),
//             listview(list: widget.direction),
//             SizedBox(
//               height: height * 0.02,
//             ),
//             text(
//                 name:
//                     ' Preparation Time: ${time(hour: widget.hour, min: widget.min)}',
//                 fsize: 18),
//           ],
//         ),
//       ),
//     );
//   }

//   String time({required int hour, required int min}) {
//     String minute = min == 1 ? 'minute' : 'minutes';
//     String h = hour == 1 ? 'hour' : 'hours';
//     if (hour == 0) {
//       return '$min $minute';
//     } else if (min == 0) {
//       return '$hour $h';
//     } else {
//       return '$hour $h and $min $minute';
//     }
//   }

//   Widget listview({required var list}) {
//     return ListView.builder(
//       padding: EdgeInsets.zero,
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: list.length,
//       itemBuilder: (context, index) {
//         return Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             text(name: '  ${index + 1})'),
//             text(name: list[index].toString()),
//           ],
//         );
//       },
//     );
//   }
// }

// deletingindividualfood(
//     {required context,
//     required String category,
//     required String foodid}) async {
//   try {
//     await FirebaseFirestore.instance
//         .collection('category')
//         .doc(category)
//         .update({foodid: FieldValue.delete()});
//      await categoryalldetails(document: category);
//      Map<String, dynamic> a =everymap;
//     Navigator.of(context).pushAndRemoveUntil(
//         MaterialPageRoute(
//           builder: (context) => Foodlist(
//             foodname: a['foodname'],
//             category: category,
//             foodid: a['foodid'],
//             foodphotolist: a['singlephoto'],
//             b: a['all'],
//           ),
//         ),
//         (route) => route.isFirst);
//   } catch (e) {
//     print('abc $e');
//   }
// }

// Color imagecolor({required String url}) {
//   if (url.contains('light-backgroud')) {
//     return Colors.black;
//   } else {
//     return Colors.white;
//   }
// }
