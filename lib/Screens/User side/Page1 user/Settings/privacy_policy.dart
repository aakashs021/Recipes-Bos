import 'package:flutter/material.dart';

class Policyandprivacy extends StatelessWidget {
  const Policyandprivacy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.lock,
                        size: 35,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Privacy and Policy',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  policyText(
                    data:
                        "Welcome to Recipes Bos! Your privacy is crucial to us, and this Privacy Policy outlines the types of personal information we collect, how it's used, and the measures we take to protect your information. By using our app, you consent to the data practices described in this policy.",
                    fontSize: 17,
                  ),
                  const SizedBox(height: 20),
                  policyText(
                    data: 'Information Collection',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      policyListItem(
                        icon: Icons.circle,
                        text: 'Email Address:',
                        description:
                            'To contact you for updates, newsletters, and customer service purposes.',
                      ),
                      policyListItem(
                        icon: Icons.circle,
                        text: 'Name of user:',
                        description:
                            'To personalize your experience on our app.',
                      ),
                      policyListItem(
                        icon: Icons.circle,
                        text: 'Phone number:',
                        description:
                            'Used for securing your account. Your password is encrypted and cannot be accessed by Recipes Bos staff.',
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  policyText(
                    data: 'Sharing of Information',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 10),
                  policyText(
                    data:
                        'Recipes Bos does not sell, rent, or lease your personal information to third parties. Your information may be shared with trusted partners to help perform statistical analysis, send you email or postal mail, provide customer support, or arrange for deliveries. All such third parties are prohibited from using your personal information except to provide these services to Recipes Bos, and they are required to maintain the confidentiality of your information.',
                  ),
                  const SizedBox(height: 20),
                  policyText(
                    data: 'Data Security',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 10),
                  policyText(
                    data:
                        'Recipes Box secures your personal information from unauthorized access, use, or disclosure. We implement a variety of security measures when a user enters, submits, or accesses their information to maintain the safety of your personal data.',
                  ),
                  const SizedBox(height: 20),
                  policyText(
                    data: 'Accessing and Updating Your Personal Information',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 10),
                  policyText(
                    data:
                        "You can review, update, or delete your personal information through the app's account settings. If you wish to delete your account, you can do so in the app or contact our support team for assistance.",
                  ),
                  const SizedBox(height: 20),
                  policyText(
                    data: 'Changes to this Privacy Policy',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 10),
                  policyText(
                    data:
                        'Recipes Bos may update this Privacy Policy to reflect company and customer feedback or changes in data protection laws. We encourage you to periodically review this Policy to be informed of how Recipes Bos is protecting your information.',
                  ),
                  const SizedBox(height: 20),
                  policyText(
                    data: 'Contact Information',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      policyText(data: 'Email:'),
                      const SizedBox(width: 5),
                      policyText(data: 'aakashs2021sa@gmail.com'),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      policyText(data: 'Phone:'),
                      const SizedBox(width: 5),
                      policyText(data: '+916282711788'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  policyText(
                    data:
                        'We are committed to ensuring your information is secure and managed with the utmost care.',
                  ),
                  const SizedBox(height: 10),
                  policyText(
                    data: 'Thank you for choosing Recipes Bos!',
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[200],
                          ),
                          child: const Text(
                            'Go back',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget policyText({
    required String data,
    double fontSize = 17,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return Text(
      data,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }

  Widget policyListItem({
    required IconData icon,
    required String text,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              Icon(
                icon,
                color: Colors.grey,
                size: 12,
              ),
            ],
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
