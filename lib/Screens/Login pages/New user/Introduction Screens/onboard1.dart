import 'package:flutter/material.dart';
import 'package:projectweek1/Screens/Login%20pages/New%20user/Introduction%20Screens/onboard2.dart';
import 'package:projectweek1/Screens/Login%20pages/New%20user/Introduction%20Screens/onboardswipe.dart';
import 'package:projectweek1/Screens/Login%20pages/New%20user/new_user_login.dart';

class Onboarding1 extends StatelessWidget {
  const Onboarding1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      // appBar: AppBar(backgroundColor: colorsblu, actions: [text(name: 'Skip')],),
      body: SafeArea(
          child: Container(
        width: double.infinity,
        height: double.infinity,
        // color: Colors.blue,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: TextButton(
                          onPressed: () {
                            control.jumpToPage(page: 2);
                          },
                          child: text(
                              name: 'Skip>>', colour: Colors.white, fsize: 17)),
                    )),
                Image.asset(
                    'assets/images/img6-intro_screen1_11zon-removebg-preview.png'),
                onboardtext(
                    text: 'Cooking experience like a professional chef.',
                    fsize: 23),
                onboardtext(
                    text:
                        'Lets start making delicious dish with the best recipe for our family.')
                // text(
                //     name: 'Cooking experience like',
                //     fsize: 23,
                //     colour: Colors.white,),
                // text(
                //     name: 'a professional chef.',
                //     fsize: 23,
                //     colour: Colors.white),
                // SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                // text(
                //     name:
                //         'Lets start making delicious dish with',
                //     colour: Colors.white,
                //     ),
                //     text(name: 'the best recipe for our family',colour: Colors.white)
              ],
            ),
          ),
        ),
      )),
    );
  }
}
