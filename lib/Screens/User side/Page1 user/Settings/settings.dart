import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projectweek1/Screens/User%20side/Page1%20user/Settings/aboutus.dart';
import 'package:projectweek1/screens/Login%20pages/New%20user/new_user_login.dart';
import 'package:projectweek1/screens/Login%20pages/Normal%20login/main_login.dart';
import 'package:projectweek1/screens/User%20side/Page1%20user/Settings/privacy_policy.dart';

class Settingspage extends StatelessWidget {
  const Settingspage({super.key});

  @override
  Widget build(BuildContext context) {
    Image.asset('assets/images/Aboutus1.jpg');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // ImageCache()
            ListTile(
              leading: const Icon(Icons.policy_outlined),
              title: const Text('Privacy policy'),
              trailing: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const Policyandprivacy(),
                    ),
                  );
                },
                child: const Icon(Icons.arrow_forward_ios_outlined),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('About us'),
              trailing: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const Aboutus(),
                    ),
                  );
                },
                child: const Icon(Icons.arrow_forward_ios_outlined),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.verified_user_outlined),
              title: const Text('Version'),
              trailing: text(name: '1.0', colour: Colors.grey),
            ),
            ListTile(
              leading: const Icon(Icons.logout_sharp),
              title: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: const Text('Are you sure you want to logout?'),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              FirebaseAuth.instance.signOut().then(
                                    (value) => Navigator.of(context)
                                        .pushAndRemoveUntil(
                                      MaterialPageRoute(
                                        builder: (context) => const Mainlogin(),
                                      ),
                                      (route) => false,
                                    ),
                                  );
                            },
                            child: const Text('Yes'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('No'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
