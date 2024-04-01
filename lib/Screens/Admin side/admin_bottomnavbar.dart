import 'package:flutter/material.dart';
import 'package:projectweek1/Screens/Admin%20side/Admin%20category/admin_categoriespage.dart';
import 'package:projectweek1/Screens/Admin%20side/Admin%20recipe%20adding/recipe%20add/recipe%20main/rec_page_1.dart';
import 'package:projectweek1/Screens/Admin%20side/admin_page.dart';

// ignore: must_be_immutable
class Adminbottomnav extends StatefulWidget {
   Adminbottomnav( {super.key,  this.index=0,this.category});
  int index;
  String? category;

  @override
  State<Adminbottomnav> createState() => _AdminbottomnavState();
}

class _AdminbottomnavState extends State<Adminbottomnav> {
  late int selectedindex;
 var screens=[const Adminhomepage(),  Adminrecipeaddpage1(),const Admincatgory()];
@override
  void initState() {
    // TODO: implement initState
    super.initState();
   selectedindex=widget.index ;
  }

  @override
  Widget build(BuildContext context) {
    // var screens=widget.s;
    return Scaffold(
      body: screens[selectedindex],


      bottomNavigationBar: BottomNavigationBar(
        currentIndex:selectedindex,
        onTap: (value) {
          setState(() {
           selectedindex=value;
          });
        },
        items: const [
        BottomNavigationBarItem(icon: Icon(Icons.list_alt_sharp),
        label: 'users'
        ),
        BottomNavigationBarItem(icon: Icon(Icons.soup_kitchen_outlined),label: 'Add recipe'),
         BottomNavigationBarItem(icon: 
          Icon(Icons.category_outlined),label: 'Categories')
      ]),
    );
  }
}