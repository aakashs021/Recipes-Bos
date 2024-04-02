// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:projectweek1/Screens/Login%20pages/New%20user/new_user_login.dart';
import 'package:projectweek1/Screens/User%20side/Page1%20user/drawer2.dart';
import 'package:projectweek1/Screens/User%20side/Page1%20user/search2.dart';
import 'package:projectweek1/Screens/User%20side/Page1%20user/trending.dart';
import 'package:projectweek1/Screens/User%20side/Page2%20user/cate1.dart';
import 'package:projectweek1/Screens/User%20side/3shopping.dart';
import 'package:projectweek1/Screens/User%20side/4ownrecipe.dart';
import 'package:projectweek1/Screens/User%20side/Page5.dart/saverecipe.dart';

// ignore: must_be_immutable
class Userbottomnav extends StatefulWidget {
  int index;
  Userbottomnav({super.key, this.index = 0});

  @override
  State<Userbottomnav> createState() => _UserbottomnavState();
}

class _UserbottomnavState extends State<Userbottomnav> {
  var pages = [
    const Usertrending(),
    const Usercategoryshow(),
    const Usershopping(),
    Userownrecipe(),
    const Usersaverecipe()
  ];
  late int selectedindex;
  @override
  void initState() {
    super.initState();
    selectedindex = widget.index;
  }

  @override
  void dispose() {
    super.dispose();
    val = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.red[100],
      drawer: drawer2(context: context),
      appBar: AppBar(
        centerTitle: true,
        title: text(name: appbarheading(index: selectedindex)),
        actions: [
          selectedindex == 0
              ? IconButton(
                  onPressed: () async {
                    List<Map<String, dynamic>> subsearchfilter =
                        await alllistformfirebaseforsearch();
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Usersearchpage2(
                        searchlist: subsearchfilter,
                      ),
                    ));
                  },
                  icon: const Icon(Icons.search))
              : const SizedBox()
        ],
      ),
      body: SafeArea(child: pages[selectedindex]),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          currentIndex: selectedindex,
          onTap: (value) {
            setState(() {
              selectedindex = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.category_outlined), label: 'Category'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined), label: 'Shop'),
            BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Your own'),
            BottomNavigationBarItem(
                icon: Icon(Icons.download_for_offline_outlined),
                label: 'Saved'),
          ]),
    );
  }
}

String appbarheading({required int index}) {
  if (index == 0) {
    return 'Trending';
  } else if (index == 1) {
    return 'Category';
  } else if (index == 2) {
    return 'Shopping list';
  } else if (index == 3) {
    return 'Add your own recipe';
  } else {
    return 'History';
  }
}
