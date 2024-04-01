import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:projectweek1/Screens/Admin%20side/admin_bottomnavbar.dart';
import 'package:projectweek1/Screens/Login%20pages/Normal%20login/main_login.dart';
import 'package:projectweek1/Screens/User%20side/user_bottomnav.dart';


class Splashscreen extends StatefulWidget {
   const Splashscreen({super.key});
   

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

  void checkLoginStatus() {
    Future.delayed(const Duration(milliseconds: 3500), () {
      if (FirebaseAuth.instance.currentUser != null) {
        determineUserRoleAndNavigate();
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Mainlogin()),
        );
      }
    });
  }
 
  void determineUserRoleAndNavigate() {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      bool isAdmin = currentUser.email == 'aakash@gmail.com';

      if (isAdmin) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Adminbottomnav()),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Userbottomnav()),
        );
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLoginStatus();
  }
 

  @override
  Widget build(BuildContext context) {
    Size mediaquery = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.amber,
          ),
          Positioned(
              top: mediaquery.height * 0.35,
              left: mediaquery.width * 0.35,
              child: Container(
                  child: Lottie.asset(
                      'assets/splash/Animation - 1706285952248.json',
                      height: 150)))
        ],
      )),
    );
  }
}

navigation(context, {required dynamic navigationpage}) {
  Future.delayed(
    const Duration(milliseconds: 3500),
    () => Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => navigationpage,
    )),
  );
}



