import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projectweek1/Screens/Login%20pages/New%20user/new_user_login.dart';
import 'package:projectweek1/Screens/otp%20screens/otpscreen3.dart';

class Otpscreen2 extends StatelessWidget {

  Otpscreen2({super.key});


  final emailController = TextEditingController();

  Future<void> sendOtp( context) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
         
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password reset email sent')));
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Otpscreen3(),));
    } on FirebaseAuthException catch (e) {
       
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
                precacheImage(const AssetImage('assets/images/img5-otpscrenn3_11zon.jpg'), context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 35),
                SizedBox(child: Image.asset('assets/images/img4-email authentication_11zon.jpg'),),
                const SizedBox(height: 30,),
                text(name: 'Enter Your Email id ',fsize: 20,),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(hintText: 'Email'),
                ),
                const SizedBox(height: 40),
                ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.purple[200]),
                  onPressed: () {
                    sendOtp(context);
                 
                  },
                  child: text(name: 'Send password reset email',colour: Colors.black),
                ),
               
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// // import 'package:email_auth/email_auth.dart';
// import 'package:email_otp/email_otp.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';

// class Optpage extends StatelessWidget {
//    Optpage({super.key});
//   var email=TextEditingController();
//   var otp=TextEditingController();
//   EmailOTP myauth=EmailOTP();

//   sentotp(context)async{
// try{
  // await FirebaseAuth.instance
  //         .sendPasswordResetEmail(email: emailController.text.trim());
//    await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text.trim());
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('sented')));

// }on FirebaseAuthException catch(e){
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message.toString())));

// }
//     // FirebaseAuth.instance.verifyPhoneNumber(verificationCompleted: verificationCompleted, verificationFailed: verificationFailed, codeSent: codeSent, codeAutoRetrievalTimeout: codeAutoRetrievalTimeout)
//     // EmailAuth.sessionname="test session";
//     // EmailAuth(sessionName: 'sessionName');
//     // var res=EmailAuth.sentotp
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body: SafeArea(child: Padding(
//       padding: const EdgeInsets.all(15.0),
//       child: Column(children: [
//         SizedBox(height: 150,),
//         Stack(
//           children: [
//             TextFormField(decoration: InputDecoration(hintText: 'Email'),controller: email,),
//             Positioned(right: 0, child: TextButton(onPressed: (){


//                 sentotp(context);
// //               myauth.setConfig(
// //   appEmail: 'aakash2020.2030@gmail.com',
// //   appName: 'Recipe boss',
// //   userEmail: email.text,
// //   otpLength: 4,
// //   otpType: OTPType.digitsOnly,
// // );
// //               if(await myauth.sendOTP()==true){
// //                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('otp sent')));
// //               }else{

// //                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('failed')));
// //               }
//             }, child: Text('Sent otp'))),
//           ],
//         ),
//         SizedBox(height: 20,),
//         TextFormField(decoration: InputDecoration(hintText: 'otp'),),
//         SizedBox(height: 20,),
//         ElevatedButton(onPressed: (){}, child: Text('Verify'))
//       ],),
//     )),);
//   }
// }