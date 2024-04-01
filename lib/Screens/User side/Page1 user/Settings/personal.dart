// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:projectweek1/Screens/Admin%20side/Admin%20recipe%20adding/recipe%20add/widget%20refactor%20recipe/page1ref.dart';
import 'package:projectweek1/screens/Login%20pages/New%20user/new_user_login.dart';

TextEditingController useercontroller = TextEditingController();
TextEditingController emailcontroller = TextEditingController();
TextEditingController phonrcontroller = TextEditingController();

class Personalinfo extends StatefulWidget {
  const Personalinfo({super.key});

  @override
  State<Personalinfo> createState() => _PersonalinfoState();
}

class _PersonalinfoState extends State<Personalinfo> {
  var formkey = GlobalKey<FormState>();
  int val = 0;
  bool tabchanger = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: text(name: 'My profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(60)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: InkWell(
                      splashColor: Colors.transparent,
                      onTap: () {
                        setState(() {
                          tabchanger = true;
                        });
                      },
                      child: Container(
                        // width: double.infinity,
                        height: 45,
                        decoration: BoxDecoration(
                            color: tabchanger ? Colors.white : Colors.grey[100],
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(child: text(name: 'Personal info')),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      splashColor: Colors.transparent,
                      onTap: () {
                        setState(() {
                          tabchanger = false;
                        });
                      },
                      child: Container(
                        // width: double.infinity,
                        height: 45,
                        decoration: BoxDecoration(
                            color: tabchanger ? Colors.grey[100] : Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(child: text(name: 'Edit')),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            tabchanger
                ? Column(
                    children: [
                      ListTile(
                        leading: const Icon(
                          Icons.person_pin_circle_outlined,
                          color: Colors.grey,
                        ),
                        title: text(name: 'Username', colour: Colors.grey),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            personaldetails(detail2: 'user'),
                            const Divider(
                              color: Colors.grey,
                            )
                          ],
                        ),
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.email_outlined,
                          color: Colors.grey,
                        ),
                        title: text(name: 'Email id', colour: Colors.grey),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            personaldetails(detail2: 'email'),
                            // text(name: 'Aakash'),
                            const Divider(
                              color: Colors.grey,
                            )
                          ],
                        ),
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.phone_outlined,
                          color: Colors.grey,
                        ),
                        title: text(name: 'Phone number', colour: Colors.grey),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            personaldetails(detail2: 'phone'),
                            // text(name: 'Aakash'),
                            const Divider(
                              color: Colors.grey,
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                : Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: text(name: 'username'),
                          subtitle: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value == " ") {
                                return 'Username cannot be empty';
                              }
                              return null;
                            },
                            controller: useercontroller,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40))),
                          ),
                        ),
                        ListTile(
                          title: text(name: 'email'),
                          subtitle: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email cannot be empty';
                              } else if (!value.contains('@gmail.com')) {
                                return 'Enter valid email id';
                              }
                              return null;
                            },
                            controller: emailcontroller,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40))),
                          ),
                        ),
                        ListTile(
                          title: text(name: 'phone number'),
                          subtitle: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Phone number is empty';
                              } else if (value.length != 10 ||
                                  value.contains(' ')) {
                                return 'Enter valid phone number';
                              }
                              return null;
                            },
                            controller: phonrcontroller,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40))),
                          ),
                        ),
                        ListTile(
                          subtitle: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green[200]),
                              onPressed: () async {
                                try{

                                
                                if (formkey.currentState!.validate()) {
                                  await getdetailsfromuserinmainpage();
                                  await FirebaseFirestore.instance
                                      .collection('user')
                                      .doc(personalid)
                                      .update({
                                    'first name': useercontroller.text.trim(),
                                    'email': emailcontroller.text.trim(),
                                    'phone': phonrcontroller.text.trim()
                                  });
                                  tabchanger = true;
                                  setState(() {});
                                  snakbar(
                                      context: context,
                                      txt: 'Updated successfully');
                                }
                              }on FirebaseException catch(e){
                                snakbar(context: context, txt: e.message.toString());
                              }
                              },
                              child: text(
                                  name: 'Save',
                                  colour: Colors.white,
                                  fsize: 20)),
                        ),
                      ],
                    ),
                  )
          ],
        ),
      ),
    );
  }
}

// String useercontrollertext = '';
// String emailcontrollertext = '';
// String phonecontrollertext = '';

Widget personaldetails({required String detail2}) {
  return FutureBuilder(
    future: getdetailsfromuserinmainpage(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Text('Loading...');
      } else if (snapshot.hasError) {
        return const Text('snapshot error');
      } else {
        String a = snapshot.data![detail2] ?? "";
        if (detail2 == 'user') {
          useercontroller.text = a;
        } else if (detail2 == 'email') {
          emailcontroller.text = a;
        } else {
          phonrcontroller.text = a;
        }
        return Text(
          a == "" ? "" : snapshot.data![detail2],
          style: const TextStyle(color: Colors.black, fontSize: 17),
        );
      }
    },
  );
}