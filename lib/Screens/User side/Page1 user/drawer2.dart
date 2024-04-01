import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projectweek1/Screens/Login%20pages/New%20user/new_user_login.dart';
import 'package:projectweek1/Screens/User%20side/Page1%20user/Settings/personal.dart';
import 'package:projectweek1/Screens/User%20side/Page1%20user/Settings/settings.dart';

Widget drawer2({required BuildContext context}) {
  return Drawer(
    // backgroundColor: gra,
    elevation: 70,
    shadowColor: Colors.blue,
    child: Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFFE4EfE9), // Start color
          Color(0xFF93A5CF) // End color
        ],
      )),
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          const CircleAvatar(
            radius: 100,
            backgroundImage: AssetImage('assets/images/Designer.png'),
          ),
          const SizedBox(
            height: 20,
          ),
          ListTile(
            leading: const Icon(Icons.person_pin),
            title: text(name: 'Personal Info'),
            subtitle: const Text(
              'User name, email and phone number',
              overflow: TextOverflow.ellipsis,
            ),
            trailing: IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const Personalinfo(),
                  ));
                },
                icon: const Icon(Icons.keyboard_arrow_right_sharp)),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: text(name: 'Settings'),
            subtitle: const Text(
              'Privacy and policy, about and version',
              overflow: TextOverflow.ellipsis,
            ),
            trailing: IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const Settingspage(),
                  ));
                },
                icon: const Icon(Icons.keyboard_arrow_right_sharp)),
          ),
        ],
      ),
    ),
  );
}
