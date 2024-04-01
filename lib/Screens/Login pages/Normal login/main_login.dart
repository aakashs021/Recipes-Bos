import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projectweek1/Hive%20helper/Hive%20favourites/favfunctions.dart';
import 'package:projectweek1/Screens/Admin%20side/Admin%20recipe%20adding/recipe%20add/widget%20refactor%20recipe/page1ref.dart';
import 'package:projectweek1/Screens/Admin%20side/admin_bottomnavbar.dart';
import 'package:projectweek1/Screens/Login%20pages/New%20user/new_user_login.dart';
import 'package:projectweek1/Screens/User%20side/user_bottomnav.dart';
import 'package:projectweek1/Screens/otp%20screens/otpscreen1.dart';
import 'package:projectweek1/Screens/splash_screen.dart';

String useremail = "";

class Mainlogin extends StatefulWidget {
  const Mainlogin({super.key});

  @override
  State<Mainlogin> createState() => _MainloginState();
}

class _MainloginState extends State<Mainlogin> {
  bool loading = false;
  final formkey = GlobalKey<FormState>();
  bool hiddeneye = false;
  var pass = TextEditingController();
  var email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    precacheImage(
        const AssetImage('assets/images/img2-newuserlogin_11zon.jpg'), context);
    precacheImage(
        const AssetImage('assets/images/img3-email continue_11zon.jpg'),
        context);

    double mediaQueryheigth = MediaQuery.of(context).size.height;
    double mediaQuerywidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset(
              'assets/images/img1-Mainloginimage23.jpg',
              height: mediaQueryheigth,
              width: mediaQuerywidth,
              fit: BoxFit.cover,
            ),
            Positioned(
              top: mediaQueryheigth * 0.37,
              left: mediaQuerywidth * 0.055,
              child: SizedBox(
                width: mediaQuerywidth - 50,
                child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      text(name: 'email id'),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: email,
                        validator: (value) => validation(
                            value: value,
                            emptytext: 'email is empty',
                            emptydetails: 'emptydetails',
                            email: true),
                      ),
                      SizedBox(
                        height: mediaQueryheigth * 0.01,
                      ),
                      text(name: 'Password'),
                      Stack(
                        children: [
                          TextFormField(
                            validator: (value) => validation(
                              value: value,
                              emptytext: 'password is empty',
                              emptydetails: 'password is invalid',
                            ),
                            controller: pass,
                            obscureText: !hiddeneye,
                          ),
                          Positioned(
                              right: 0,
                              child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      hiddeneye = !hiddeneye;
                                    });
                                  },
                                  alignment: Alignment.topRight,
                                  icon: eye()))
                        ],
                      ),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const Otpscreen1(),
                                ));
                              },
                              child: text(
                                  name: 'Forgot password?',
                                  colour: Colors.blue))),
                      SizedBox(
                        height: mediaQueryheigth * 0.06,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (formkey.currentState!.validate()) {
                            mainloginbuttonfetchingdata(context);
                          }
                          useremail = email.text;
                          await getfavourite();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            fixedSize:
                                Size(mediaQuerywidth, mediaQueryheigth * 0.05)),
                        child: loading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : text(
                                name: 'Sign in',
                                colour: Colors.white,
                                fsize: 20,
                                fweigth: FontWeight.w900),
                      ),
                      SizedBox(
                        height: mediaQueryheigth * 0.01,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Newuser(),
                          ));
                        },
                        style: ElevatedButton.styleFrom(
                            fixedSize:
                                Size(mediaQuerywidth, mediaQueryheigth * 0.001),
                            backgroundColor: Colors.yellow),
                        child: const Text(
                          "Don't have an account? Register?",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 19,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }

  Widget text(
      {required String name,
      Color colour = Colors.black,
      double fsize = 15,
      FontWeight fweigth = FontWeight.bold}) {
    return Text(
      name,
      style: TextStyle(
          fontFamily: 'robotomonovariable',
          fontWeight: FontWeight.bold,
          fontSize: fsize,
          color: colour),
    );
  }

  Widget eye() {
    if (hiddeneye) {
      return const Icon(Icons.visibility_outlined);
    } else {
      return const Icon(Icons.visibility_off_outlined);
    }
  }

  mainloginbuttonfetchingdata(context) async {
    try {
      setState(() {
        loading = true;
      });
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email.text, password: pass.text);

      await getdetailsfromuserinmainpage();
      if (email.text == 'aakash@gmail.com') {
        navigation(context, navigationpage: Adminbottomnav());
      } else {
        navigation(context, navigationpage: Userbottomnav());
      }
    } on FirebaseAuthException catch (e) {
      print(e.email);
      setState(() {
        loading = false;
      });
      if (e.code == 'invalid-credential') {
        snakbar(
            context: context,
            txt:
                'Please make sure you have entered corret email id and password');

        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //   dismissDirection: DismissDirection.horizontal,
        //   duration: const Duration(milliseconds: 1500),
        //   content: Text('Please make sure you have entered corret email id and password')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            dismissDirection: DismissDirection.horizontal,
            duration: const Duration(milliseconds: 1500),
            content: Text(e.message.toString())));
      }
    }
  }

//   authentificationbetuserandadmin() async {
//     await FirebaseFirestore.instance
//         .collection('admin')
//         .doc('admindetails')
//         .snapshots()
//         .forEach((element) {
//       if (element.data()?['email'] == email.text.trim() &&
//           element.data()?['password'] == pass.text.trim()) {
//         navigation(context, navigationpage: Admin());
//       } else {
// mainloginbuttonfetchingdata(context);
//       }
//     });
//   }
}
