import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:projectweek1/Screens/Login%20pages/New%20user/Introduction%20Screens/onboard1.dart';
import 'package:projectweek1/Screens/Login%20pages/New%20user/Introduction%20Screens/onboard2.dart';
import 'package:projectweek1/Screens/Login%20pages/New%20user/Introduction%20Screens/onboard3.dart';
import 'package:projectweek1/Screens/User%20side/user_bottomnav.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

var control = LiquidController();

class Liquidswipeonboarding extends StatefulWidget {
  Liquidswipeonboarding({super.key});

  @override
  State<Liquidswipeonboarding> createState() => _LiquidswipeonboardingState();
}

class _LiquidswipeonboardingState extends State<Liquidswipeonboarding> {
  int currentpage = 0;
  // onpagechange(){
  //   setState(() {
  //     currentpage=control.currentPage;
  //   });
  // }

  var page = [Onboarding1(), Onboarding2(), Onboarding3()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          LiquidSwipe(
            pages: page,
            
            slideIconWidget: control.currentPage>1? SizedBox():Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            positionSlideIcon: 0.5,
            enableSideReveal: true,
            fullTransitionValue: 1000,
            enableLoop: false,
            liquidController: control,
            onPageChangeCallback: (activePageIndex) {
              setState(() {
                currentpage = activePageIndex;
              });
            },
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height*0.1,
            // left: MediaQuery.of(context).size.width*0.35,
            child:  OutlinedButton(
              onPressed: () {
                int nextpage=control.currentPage+1;
                if(nextpage==3){
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Userbottomnav(),), (route) => false);
                }
                control.animateToPage(page: nextpage);
              },
              style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  // onPrimary: Colors.white,
                  padding: EdgeInsets.all(20),
                  side: BorderSide(color: Colors.black26)),
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: CupertinoColors.darkBackgroundGray,
                    shape: BoxShape.circle),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          // SmoothPageIndicator(controller: control.currentPage, count: 3)
          Positioned(
              // left: MediaQuery.of(context).size.width * 0.4,
              bottom: 10,
              child: AnimatedSmoothIndicator(
                  effect: WormEffect(
                      activeDotColor: Colors.white70,
                      dotColor: Colors.black.withOpacity(0.5)
                      // radius: 10,
                      ),
                  activeIndex: currentpage,
                  count: 3))
        ],
      ),

      // PageView(controller: control,children: [
      //   // page[control];
      //   Onboarding1(),
      //   Onboarding2(),
      // ],),
    );
  }
}
