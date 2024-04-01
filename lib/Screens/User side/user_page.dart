import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projectweek1/Screens/Login%20pages/New%20user/new_user_login.dart';
import 'package:projectweek1/Screens/Login%20pages/Normal%20login/main_login.dart';
import 'package:projectweek1/Screens/splash_screen.dart';

class Usersidehome extends StatefulWidget {
  

   const Usersidehome({super.key,
 
   });

  @override
  State<Usersidehome> createState() => _UsersidehomeState();
}

class _UsersidehomeState extends State<Usersidehome> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
     
      appBar: AppBar(title: 
      FutureBuilder<Map<String , dynamic>>(future: getdetailsfromuserinmainpage(),
      builder: (context, snapshot) {
        if(snapshot.connectionState==ConnectionState.waiting){
          return const Text('some error');
        }else if(snapshot.hasError){
          return const Text('snapshot error');
        }else{
            return text(name: snapshot.data!['user'],fsize: 20);        }
      },
      )
     
       ),
      body: SafeArea(
        child: Column(
          children: [
          
            FutureBuilder<Map<String , dynamic>>(future: getdetailsfromuserinmainpage(),
      builder: (context, snapshot) {
        if(snapshot.connectionState==ConnectionState.waiting){
          return const Text('some error');
        }else if(snapshot.hasError){
          return const Text('snapshot error');
        }else{
            return text(name: snapshot.data!['email'],fsize: 20);        }
      },
      ),
           
            Center(child: ElevatedButton(onPressed: (){
            FirebaseAuth.instance.signOut().then((value) => 
            
            navigation(context, navigationpage: const Mainlogin())
            );
            }, child: const Text('Logout'))),
          ],
        ),
      ),);
  }
}