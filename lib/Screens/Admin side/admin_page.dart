import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projectweek1/Firebase%20helper/firebase_adminrec3.dart';
import 'package:projectweek1/Screens/Login%20pages/New%20user/new_user_login.dart';
import 'package:projectweek1/Screens/Login%20pages/Normal%20login/main_login.dart';

class Adminhomepage extends StatefulWidget {
  const Adminhomepage({super.key});

  @override
  State<Adminhomepage> createState() => _AdminhomepageState();
}

class _AdminhomepageState extends State<Adminhomepage> {
  bool isloading = false;
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Row(
            children: [
              PopupMenuButton(
                color: Colors.blue[50],
                icon: Icon(Icons.more_vert),
                itemBuilder: (context) {
                  return [
                    custompopupmenubuttonitem(
                        selected: selected,
                        selectedday: 'Last day',
                        index: 0,
                        val: 0),
                    custompopupmenubuttonitem(
                        selected: selected,
                        selectedday: 'Last week',
                        index: 1,
                        val: 1),
                    custompopupmenubuttonitem(
                        selected: selected,
                        selectedday: 'Last month',
                        index: 2,
                        val: 2),
                    custompopupmenubuttonitem(
                        selected: selected,
                        selectedday: 'Last year',
                        index: 3,
                        val: 3),
                  ];
                },
                onSelected: (value) {
                  setState(() {
                    selected = value;
                  });
                },
              ),
            ],
          )
        ],
      ),
      drawer: adminsidedrawer(
          context: context,
          isloading: isloading,
          changeisloading: () {
            setState(() {
              isloading = true;
            });
          }),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('user').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData && snapshot.data != null) {
              List<Map<String, dynamic>> sorted = [];
              for (int i = 0; i < snapshot.data!.docs.length; i++) {
                Map<String, dynamic> user =
                    snapshot.data!.docs[i].data() as Map<String, dynamic>;
                DateTime userlogin = (user['signupdate'] as Timestamp).toDate();
                DateTime now = DateTime.now();

                print(now.difference(userlogin).inDays);
                switch (selected) {
                  case 0:
                    if (now.difference(userlogin).inDays <= 1) {
                      sorted.add(user);
                    }
                    break;
                  case 1:
                    if (now.difference(userlogin).inDays <= 7) {
                      sorted.add(user);
                    }
                    break;
                  case 2:
                    if (now.difference(userlogin).inDays <= 30) {
                      sorted.add(user);
                    }
                    break;
                  case 3:
                    if (now.difference(userlogin).inDays <= 365) {
                      sorted.add(user);
                    }
                    break;
                }
              }
              // if(selected==0){
              //   if(now.difference(userlogin).inDays<=1){
              //     sorted.add(user);
              //   }
              // }else if(selected==1){

              // }

              return sorted.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: sorted.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                              color: Colors.green[200],
                              borderRadius: BorderRadius.circular(20)),
                          margin: EdgeInsets.all(5),
                          child: ListTile(
                            leading: CircleAvatar(
                              child: text(
                                  name: sorted[index]['first name'][0]
                                      .toString()
                                      .toUpperCase()),
                            ),
                            title: text(name: sorted[index]['first name']),
                            subtitle: text(name: sorted[index]['email']),
                          ),
                        );
                      },
                    )
                  : Center(
                      child: text(
                          name:
                              'No one has signed up in last ${adminsortedlistempty(selected: selected)}'),
                    );
            } else {
              return text(name: 'No user found');
            }
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

Widget adminsidedrawer(
    {required context,
    required bool isloading,
    required Function changeisloading}) {
  return Drawer(
    child: Column(
      children: [
        const SizedBox(
          height: 50,
        ),
        SizedBox(
          height: 150,
          width: double.infinity,
          child: CircleAvatar(
            radius: 80,
            backgroundColor: Colors.green[100],
            child: text(name: 'A', fsize: 60),
          ),
        ),
        ListTile(
          title: TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: text(name: 'Are you sure you want to delete'),
                      actions: [
                        TextButton(
                            onPressed: () async {
                              changeisloading();

                              FirebaseAuth.instance.signOut().then(
                                    (value) => Navigator.of(context)
                                        .pushAndRemoveUntil(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const Mainlogin(),
                                            ),
                                            (route) => false),
                                  );
                            },
                            child: isloading
                                ? const CircularProgressIndicator(
                                    color: Colors.red,
                                  )
                                : text(name: 'yes')),
                        TextButton(
                            onPressed: () {
                              navigatorpop(context);
                            },
                            child: text(name: 'no')),
                      ],
                    );
                  },
                );
              },
              child: isloading
                  ? const CircularProgressIndicator(
                      color: Colors.red,
                    )
                  : text(name: 'Logout', colour: Colors.red)),
        ),
      ],
    ),
  );
}

PopupMenuItem<int> custompopupmenubuttonitem(
    {required int selected,
    required String selectedday,
    required int index,
    required int val}) {
  return PopupMenuItem(
    value: val,
    child:
        text(name: selectedday, colour: col(selected: selected, index: index)),
  );
}

Color col({required int selected, required int index}) {
  return selected != index ? Colors.black : Colors.blue;
}

String adminsortedlistempty({required int selected}) {
  if (selected == 0) {
    return 'day';
  } else if (selected == 1) {
    return 'week';
  } else if (selected == 2) {
    return 'month';
  } else {
    return 'year';
  }
}

// recentuserslist() async {
//   try {
//     QuerySnapshot qs =
//         await FirebaseFirestore.instance.collection('user').get();
//     for (var doc in qs.docs) {
//       print(doc['email']);
//     }
//   } catch (e) {
//     print('erroe: $e');
//   }
// }
