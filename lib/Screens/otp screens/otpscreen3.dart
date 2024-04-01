import 'package:flutter/material.dart';
import 'package:projectweek1/Screens/Login%20pages/New%20user/Introduction%20Screens/onboard2.dart';
import 'package:projectweek1/Screens/Login%20pages/New%20user/new_user_login.dart';
import 'package:projectweek1/Screens/Login%20pages/Normal%20login/main_login.dart';

class Otpscreen3 extends StatelessWidget {
  const Otpscreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
                    children: [
            const SizedBox(
              height: 80,
            ),
            Image.asset('assets/images/img5-otpscrenn3_11zon.jpg'),
            const SizedBox(
              height: 50,
            ),
            text(name: 'An email has been sent',fsize: 18),
            onboardtext(text: 'Please click continue to go back to login page',colour: Colors.black),
           
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const Mainlogin(),
                    ),
                    (route) => false);
              },
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size.fromWidth(200),
                  backgroundColor: Colors.indigo[500]),
              child: text(name: 'Continue', colour: Colors.white),
            )
                    ],
                  ),
          )),
    );
  }
}
