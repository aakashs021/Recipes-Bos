import 'package:flutter/material.dart';
import 'package:projectweek1/Screens/Login%20pages/New%20user/new_user_login.dart';
import 'package:projectweek1/Screens/otp%20screens/otpscreen2.dart';

class Otpscreen1 extends StatelessWidget {
  const Otpscreen1({super.key});

  @override
  Widget build(BuildContext context) {
                precacheImage(const AssetImage('assets/images/img4-email authentication_11zon.jpg'), context);

    return Scaffold(body: SafeArea(child: Column( children: [
      const SizedBox(height: 80,),
      Image.asset('assets/images/img3-email continue_11zon.jpg'),
      const Padding(
        padding: EdgeInsets.all(15.0),
        child: Text('An Email will be sent to your account and select on the link provided there to change the password',style: TextStyle(fontSize: 18),),
      ),

      const SizedBox(height: 20,),
      ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.amber[400]), onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Otpscreen2(),));
      }, child: text(name: 'Continue',colour: Colors.white))
    ],)),);
  }
}