import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:projectweek1/Screens/Admin%20side/Admin%20category/admin_categoriespage.dart';
import 'package:projectweek1/Screens/Admin%20side/Admin%20recipe%20adding/firebasestoragefunctions.dart';
import 'package:projectweek1/Screens/Login%20pages/New%20user/new_user_login.dart';
import 'package:projectweek1/Screens/User%20side/Page2%20user/cate2.dart';

class Usercategoryshow extends StatefulWidget {
  const Usercategoryshow({super.key});

  @override
  State<Usercategoryshow> createState() => _UsercategoryshowState();
}

class _UsercategoryshowState extends State<Usercategoryshow> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firebasefetchingdetailsforcategorypage();
  }
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return Scaffold(
        // appBar: AppBar(
        //   title: text(name: 'Category'),
        // ),
        body: firebasedocumentname.isNotEmpty
            ? ListView.builder(
              shrinkWrap: true,
                      itemCount: firebasedocumentname.length,
                      itemBuilder: (context, index) {
              return InkWell(
                onTap: () async{
                   await categoryalldetails(
                                        document: firebasedocumentname[index],
                                      );
                                      Map<String, dynamic> a = everymap;
                                     
                                     await Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => Userfoodlist(
                                          foodname: a['foodname'],
                                          category: firebasedocumentname[index],
                                          foodid: a['foodid'],
                                          foodphotolist: a['singlephoto'],
                                          b: a['all'],
                                        ),
                                      ));
                },
                child: Container(height: height*0.25,
                padding: const EdgeInsets.all(15),
                width: width,
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
                                                      // height: double.infinity,
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
                                        ListTile(title: text(
                                            name: firebasedocumentname[index],
                                            colour: Colors.white),)    
                    ],
                  ),
                ),
              );
            },)
            : Center(
                child: text(name: 'There is no food category'),
              )
              );
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
      // print('e');
    }
  }
}
