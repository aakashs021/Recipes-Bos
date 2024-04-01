import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projectweek1/Hive%20helper/Hive%20favourites/favfunctions.dart';
import 'package:projectweek1/Screens/Admin%20side/Admin%20recipe%20adding/recipe%20add/widget%20refactor%20recipe/page1ref.dart';
import 'package:projectweek1/Screens/Login%20pages/New%20user/Introduction%20Screens/onboardswipe.dart';
import 'package:projectweek1/Screens/Login%20pages/Normal%20login/main_login.dart';

class Newuser extends StatefulWidget {
  const Newuser({super.key});

  @override
  State<Newuser> createState() => _NewuserState();
}

class _NewuserState extends State<Newuser> {
  final TextEditingController phonenumber = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController firstnamecontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();

  final formkey = GlobalKey<FormState>();
 bool loading=false;

  @override
  Widget build(BuildContext context) {

    bool keyboard = MediaQuery.of(context).viewInsets.bottom > 40;
    createAccount(context) async {
      String email = emailcontroller.text.trim();
      String password = passwordcontroller.text.trim();
      String firstname = firstnamecontroller.text.trim();
      String phone=phonenumber.text.trim();

      try {
        setState(() {
          loading=true;
        });
         await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        await addinguserlogindatatofirebase(context,
            firstname: firstname,
            email: email,
            phone: phone
            );
            await getdetailsfromuserinmainpage();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) =>  Liquidswipeonboarding(),
            ),
            (route) => false);
      } on FirebaseAuthException catch (e) {
        setState(() {
          loading=false;
        });
        snakbar(context: context, txt: e.message.toString());
      }
    }

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
          child: Stack(
            children: [
              Image.asset(
                'assets/images/img2-newuserlogin_11zon.jpg',
                width: width,
                height: height,
                fit: BoxFit.cover,
              ),
              Form(
                key: formkey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: keyboard ? height * 0.21 : height * 0.4,
                        left: width * 0.075),
                    child: SizedBox(
                      width: width - 50,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          text(name: 'Username'),
                          TextFormField(
                            controller: firstnamecontroller,
                            validator: (value) {
                              return validation(
                                  value: value,
                                  emptytext: 'name is empty',
                                  emptydetails: 'name empty');
                            },
                          ),
                          text(name: 'Phone number'),
                          TextFormField(keyboardType: TextInputType.phone,
                            controller: phonenumber,
                            validator: (value) => validation(value: value, emptytext: 'phone no empty', emptydetails: 'emptydetails',phone: true),
                          ),
                          text(name: 'Email id'),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: emailcontroller,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              return validation(
                                  value: emailcontroller.text,
                                  emptytext: "email is empty",
                                  emptydetails: "email is not correct",
                                  email: true);
                            },
                          ),
                          text(name: 'Password'),
                          TextFormField(
                            controller: passwordcontroller,
                            validator: (value) {
                              return validation(
                                  value: value,
                                  emptytext: 'password is empty',
                                  emptydetails: 'password empty');
                            },
                          ),
                          SizedBox(
                            height: height * 0.05,
                          ),
                          ElevatedButton(
                            onPressed: () async{
                              if (formkey.currentState!.validate()) {
                                createAccount(context);
                              }
                              useremail=emailcontroller.text;
                              await getfavourite();
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                fixedSize: Size.fromWidth(width)),
                            child: loading? const CircularProgressIndicator(color: Colors.black,):const Text(
                              'Sign up',
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )               ,
              )
            ],
          )),
    );
  }

  addinguserlogindatatofirebase(context,
      {required String firstname,
    required  String phone ,
      required String email}) async {
        try{
CollectionReference colrefs = FirebaseFirestore.instance.collection('user');
    DocumentReference userdoc=colrefs.doc(phonenumber.text);
    var doc=await userdoc.get();
    if(!doc.exists){  
    await colrefs
        .add({'first name': firstname, 'phone number': phone, 'email': email,
        'signupdate':DateTime.now()
        });
    }else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Phone number alredy exists')));
    }
        }on FirebaseException catch(e){
snakbar(context: context, txt: e.message.toString());
        }
    

  }
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

String? validation(
    {required String? value,
    required String emptytext,
    required String emptydetails,
    bool phone=false,
    bool email = false}) {
  if (value == null || value.isEmpty) {
    return emptytext;
  } else if (email) {
    if (!value.contains('@gmail.com')) {
      return 'email is incorrect';
    }
  }else if(phone){
    if(value.length!=10){
      return 'phone number does not contains 10 digits';
    }
  }

  return null;
}
String personalid='';
 Future<Map<String,dynamic>>
  getdetailsfromuserinmainpage()async{

  try{
    QuerySnapshot qs=await FirebaseFirestore.instance.collection('user').get();
    for(QueryDocumentSnapshot doc in qs.docs){
      if(FirebaseAuth.instance.currentUser!.email==doc['email']){
        personalid=doc.id;
      Map<String,dynamic> a={'user':doc['first name'],'email':doc['email'],'phone':doc['phone number']};
      return a;
      }
    }
  }catch(e){ 
    Map<String, dynamic> a={'user':"some error",'email':"some error"} ;
    return a;
  }
  Map<String, dynamic> a={'user':"some error",'email':"some error"} ;
    return a;
}
