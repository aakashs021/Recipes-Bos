import 'package:flutter/material.dart';
import 'package:projectweek1/Screens/Login%20pages/New%20user/Introduction%20Screens/onboard2.dart';
import 'package:projectweek1/Screens/Login%20pages/New%20user/new_user_login.dart';

class Onboarding3 extends StatelessWidget {
  const Onboarding3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      body: SafeArea(
          child: Container(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  Image.asset(
                      'assets/images/WhatsApp Image 2024-02-02 at 1.46.15 PM.png'),
                  onboardtext(
                      colour: Colors.red,
                      fsize: 18,
                      text:
                          "Cooking is about passion, so it may look slightly temperamental in a way that it's too assertive to the naked eye."),
                          Align(alignment: Alignment.centerRight, child: text(name: '-Gordon Ramsay',colour: Colors.red))
                ],
              ),
            ),
            Positioned(
                bottom: MediaQuery.of(context).size.height * 0.25,
                child: text(name: 'Click here to continue'))
          ],
        ),
      )),
    );
  }
}
