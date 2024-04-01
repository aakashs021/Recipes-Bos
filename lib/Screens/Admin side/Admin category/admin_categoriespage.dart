import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projectweek1/Firebase%20helper/firebase_adminrec3.dart';
import 'package:projectweek1/Screens/Admin%20side/Admin%20category/foodlisting.dart';
import 'package:projectweek1/Screens/Admin%20side/Admin%20recipe%20adding/firebasestoragefunctions.dart';
import 'package:projectweek1/Screens/Admin%20side/admin_bottomnavbar.dart';
import 'package:projectweek1/Screens/Login%20pages/New%20user/new_user_login.dart';

Map<String, dynamic> everymap = {};
List<String> firebasedocumentname = [];
List<String> firebasedocumentphoto = [];
bool isloading = true;
late String img;

class Admincatgory extends StatefulWidget {
  const Admincatgory({super.key});

  @override
  State<Admincatgory> createState() => _AdmincatgoryState();
}

class _AdmincatgoryState extends State<Admincatgory> {
  String? trendingimg;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (img != "") {
      trendingimg = img;
    }
    firebasefetchingdetailsforcategorypage();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: text(name: 'Catgory'),
        ),
        body: SingleChildScrollView(
          child: isloading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    InkWell(
                        onTap: () async {
                          Map<String, dynamic> a = await categoryalldetails();
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Foodlist(
                              foodname: a['foodname'],
                              category: 'Trending',
                              foodid: a['foodid'],
                              foodphotolist: a['singlephoto'],
                              b: a['all'],
                            ),
                          ));
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                              top: 15, left: 15, right: 15),
                          width: double.infinity,
                          height: height * 0.2,
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: CachedNetworkImage(
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  imageUrl: trendingimg!,
                                  placeholder: (context, url) {
                                    return SizedBox(
                                        width: double.infinity,
                                        height: double.infinity,
                                        child: Stack(
                                          children: [
                                            const Center(
                                                child:
                                                    CircularProgressIndicator(
                                              color: Colors.blue,
                                            )),
                                            Image.asset(
                                              'assets/images/11861789_7575.jpg',
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                          ],
                                        ));
                                  },
                                ),
                              ),
                              ListTile(
                                title: SizedBox(
                                    width: width * 0.01,
                                    child: text(
                                        name: 'Trending',
                                        colour: Colors.white)),
                              ),
                            ],
                          ),
                        )),
                    firebasedocumentname.isNotEmpty
                        ? SizedBox(
                            width: double.infinity,
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: firebasedocumentname.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                    onTap: () async {
                                      await categoryalldetails(
                                        document: firebasedocumentname[index],
                                      );
                                      Map<String, dynamic> a = everymap;
                                      // ignore: use_build_context_synchronously
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => Foodlist(
                                          foodname: a['foodname'],
                                          category: firebasedocumentname[index],
                                          foodid: a['foodid'],
                                          foodphotolist: a['singlephoto'],
                                          b: a['all'],
                                        ),
                                      ));
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            top: 15, left: 15, right: 15),
                                        width: double.infinity,
                                        height: height * 0.2,
                                        child: Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                                imageUrl: firebasedocumentphoto[
                                                    index],
                                                placeholder: (context, url) {
                                                  return SizedBox(
                                                      width: double.infinity,
                                                      height: double.infinity,
                                                      child: Stack(
                                                        children: [
                                                          const Center(
                                                              child:
                                                                  CircularProgressIndicator(
                                                            color: Colors.blue,
                                                          )),
                                                          Image.asset(
                                                            'assets/images/11861789_7575.jpg',
                                                            width:
                                                                double.infinity,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ],
                                                      ));
                                                },
                                              ),
                                            ),
                                            ListTile(
                                              trailing: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  IconButton(
                                                      onPressed: () async {
                                                        showDialog(context: context, builder: (context) {
                                                          TextEditingController categorycont=TextEditingController();
                                                          categorycont.text=firebasedocumentname[index];
                                                          return AlertDialog(title: text(name: 'Are you sure you want to rename it?'),
                                                          content: TextFormField(controller: categorycont,
                                                          validator: (value) {
                                                            if(value==null){
                                                              return 'Please give the new name';
                                                            }return null;
                                                          },
                                                          ),
                                                          actions: [
                                                            TextButton(onPressed: ()async{
                                                            if(categorycont.text.trim().isNotEmpty){
                                                               await editingcategoryname(category:firebasedocumentname[index],categoryedit:categorycont.text.trim());
                                                                 await firebasefetchingdetailsforcategorypage();
                                                                 navigatorpop(context);
                                                                 setState(() {
                                                                   firebasedocumentname=firebasedocumentname;
                                                                 });

                                                            }
                                                            }, child: text(name: 'Yes')),
                                                            TextButton(onPressed: (){
                                                              Navigator.pop(context);
                                                            }, child: text(name: 'no')),
                                                          ],
                                                          );
                                                        },);
                                                       
                                                      },
                                                      icon: const Icon(
                                                        Icons.edit,
                                                        color: Colors.white,
                                                      )),
                                                  IconButton(
                                                      onPressed: () async {
                                                        await deletefunctioncategory(
                                                          context: context,
                                                          firebasedocumentname:firebasedocumentname[index],);
                                                        },
                                                      icon: const Icon(
                                                        Icons.delete,
                                                        color: Colors.white,
                                                      )),
                                                ],
                                              ),
                                              title: text(
                                                  name: firebasedocumentname[index],
                                                  colour: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ));
                              },
                            ),
                          )
                        : Center(
                            child: text(name: 'Category is not added'),
                          )
                  ],
                ),
        ));
  }

  firebasefetchingdetailsforcategorypage() async {
    try {
      firebasedocumentname =await fetchingcategoryphotoandname['categoryname'] ?? [];
      firebasedocumentphoto =await fetchingcategoryphotoandname['categoryphoto'] ?? [];
      isloading = false;

      setState(() {
        firebasedocumentname = firebasedocumentname;
        isloading = false;
      });
    } catch (e) {
      print('e');
    }
  }
}

// ignore: non_constant_identifier_names
Future<String> Trending() async {
  String categoryphoto = "";
  DocumentSnapshot snap = await FirebaseFirestore.instance
      .collection('category')
      .doc('Trending')
      .get();
  if (snap.exists) {
    Map<String, dynamic> category = snap.data() as Map<String, dynamic>;
    categoryphoto = category['categoryimg'];
  }
  return categoryphoto;
}

Future<Map<String, dynamic>> categoryalldetails({
  String document = 'Trending',
  // required int index,
}) async {
  dynamic b = [];
  List<List<String>> namesphoto = [];
  List<String> convertedList = [];
  List<String> id = [];
  List<String> names = [];
  Map<String, dynamic> cat ={};
  DocumentSnapshot snap = await FirebaseFirestore.instance
      .collection('category')
      .doc(document)
      .get();
  if (snap.exists) {
    cat = snap.data() as Map<String, dynamic>;
    for (String name in cat.keys) {
      if (name != 'categoryimg') {
        id.add(name);
      }
    }
    // print(names);
    for (int i = 0; i < id.length; i++) {
      dynamic a = cat[id[i]];
      String n = a['foodname'];
      names.add(n);
      // print(a);
      b.add(a);

      if (a is Map<String, dynamic>) {
        if (a.containsKey('file')) {
          List<dynamic> filevalue = a['file'];
          for (dynamic element in filevalue) {
            convertedList.add(element.toString());
          }
          namesphoto.add(convertedList);
        }
      }
    }
  }

  everymap = {
    'foodid': id,
    'singlephoto': convertedList,
    'all': b,
    'foodname': names,
    'every':cat
  };
  return {
    'foodid': id,
    'singlephoto': convertedList,
    'all': b,
    'foodname': names
  };
}

deletefunctioncategory(
    {required context, required String firebasedocumentname}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title:
            text(name: 'Are you sure you want to delete $firebasedocumentname'),
        actions: [
          TextButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('category')
                    .doc(firebasedocumentname)
                    .delete();
                await firebasegetinglist();
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                  builder: (context) {
                    return Adminbottomnav(
                      index: 2,
                    );
                  },
                ), (route) => false);
              },
              child: text(name: 'Yes')),
          TextButton(
              onPressed: () {
                navigatorpop(context);
              },
              child: text(name: 'No'))
        ],
      );
    },
  );
}

editingcategoryname(
    {required String category, required String categoryedit}) async {
  await categoryalldetails(document: category);
  await FirebaseFirestore.instance
      .collection('category')
      .doc(categoryedit)
      .set(everymap['every']);
      await FirebaseFirestore.instance
                    .collection('category')
                    .doc(category)
                    .delete();
                await firebasegetinglist();
}
