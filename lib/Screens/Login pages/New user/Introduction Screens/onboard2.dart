import 'package:flutter/material.dart';

class Onboarding2 extends StatelessWidget {
  const Onboarding2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: Container(padding: EdgeInsets.all(25), width: double.infinity,height: double.infinity,child: Column(children: [
      Image.asset('assets/images/img7-intro screen2_11zon.jpg',width: double.infinity,),
      // text(name: 'Different varieties of food',fsize: 23),
      onboardtext(text: 'Different varieties of food',fsize: 23,colour: Colors.black),
      // text(name: 'Now, you can make different varieties food that you want in an instance.')
      onboardtext(text: 'Now, you can make different varieties food that you want in an instance.',colour: Colors.black)
    ],),)),);
  }
}
Widget onboardtext({required String text,double fsize=15,FontWeight fweight=FontWeight.bold,Color colour=Colors.white}){
  return Text( text,style: TextStyle(fontFamily: 'robotomonovariable',fontSize: fsize,fontWeight: fweight,color: colour),textAlign: TextAlign.center,);
}