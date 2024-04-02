import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projectweek1/Firebase%20helper/firebase_adminrec3.dart';
import 'package:projectweek1/Screens/Login%20pages/New%20user/new_user_login.dart';
import 'package:projectweek1/Screens/Login%20pages/Normal%20login/main_login.dart';
import 'package:projectweek1/Screens/User%20side/Page1%20user/trending.dart';
// import 'package:projectweek1/Screens/User%20side/Page1%20user/1trending.dart';

Widget drwer({required context, required Function isuserload}) {
  return Drawer(
    child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
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
                child: FutureBuilder(
                  future: getdetailsfromuserinmainpage(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return const Text(
                        'snapshot error',
                      );
                    } else {
                      return text(
                        name:
                            snapshot.data!['user'][0].toString().toUpperCase(),
                        fsize: 40,
                      );
                    }
                  },
                ),
              ),
            ),
            Table(
              columnWidths: const {
                0: FractionColumnWidth(0.1),
                1: FractionColumnWidth(0.4),
                2: FractionColumnWidth(0.1),
              },
              children: [
                userdetailshowingindrawer(
                    detail2: 'user', detail1: 'user', icondata: Icons.person),
                userdetailshowingindrawer(
                    detail2: 'detail2',
                    detail1: 'detail1',
                    icondata: Icons.abc,
                    issize: true),
                userdetailshowingindrawer(
                    detail2: 'email',
                    detail1: 'email',
                    icondata: Icons.email_outlined),
                userdetailshowingindrawer(
                    detail2: 'detail2',
                    detail1: 'detail1',
                    icondata: Icons.abc,
                    issize: true),
                userdetailshowingindrawer(
                    detail2: 'phone',
                    detail1: 'phone',
                    icondata: Icons.phone_android_outlined),
                userdetailshowingindrawer(
                    detail2: 'detail2',
                    detail1: 'detail1',
                    icondata: Icons.abc,
                    issize: true),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.privacy_tip_outlined),
                    text(name: 'Privacy Policy'),
                  ],
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_forward_ios_outlined))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.info_outline),
                    text(name: 'Contact Info'),
                  ],
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_forward_ios_outlined))
              ],
            ),
            ListTile(
              title: TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content:
                              text(name: 'Are you sure you want to delete'),
                          actions: [
                            TextButton(
                              onPressed: () async {
                                isuserload();
                                // setState(() {
                                //   isloadinguser = true;
                                // });

                                FirebaseAuth.instance.signOut().then(
                                      (value) => Navigator.of(context)
                                          .pushAndRemoveUntil(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const Mainlogin(),
                                              ),
                                              (route) => false),
                                    );
                                isloadinguser = false;
                              },
                              child: isloadinguser
                                  ? const CircularProgressIndicator(
                                      color: Colors.red,
                                    )
                                  : text(name: 'yes'),
                            ),
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
                  child: isloadinguser
                      ? const CircularProgressIndicator(
                          color: Colors.red,
                        )
                      : text(name: 'Logout', colour: Colors.red)),
            ),
          ],
        ),
      ),
    ),
  );
}
