import 'package:flutter/material.dart';

class Aboutus extends StatelessWidget {
  const Aboutus({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('About Us'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(17.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'About Recipes Bos',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: const Text(
                          "Welcome to Recipes Bos, your go-to destination for exploring, organizing, and sharing mouthwatering recipes. At Recipes Bos, we're passionate about cooking and bringing people together through the love of food.",
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Image.asset(
                        'assets/images/aboutus2.jpg',
                        width: 180,
                        height: 250, // Adjust image width as needed
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                const Divider(),
                const SizedBox(height: 20),
                const Text(
                  'Our Mission',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Our mission is to empower home cooks and culinary enthusiasts of all levels to discover new flavors, hone their cooking skills, and create memorable meals. We believe that cooking should be enjoyable, accessible, and rewarding for everyone.',
                  textAlign: TextAlign.justify,
                ),
                const Divider(),
                const SizedBox(height: 20),
                const Text(
                  'What We Offer',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 10),
                ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildListItem(
                      context,
                      'Discover a World of Recipes',
                      'Dive into a diverse collection of recipes spanning different cuisines, dietary preferences, and cooking expertise.',
                    ),
                    const Divider(),
                    _buildListItem(
                      context,
                      'Organize Your Recipe Collection',
                      'Save your favorite recipes to your personal recipe box for quick and easy access whenever you need them.',
                    ),
                    const Divider(),
                    _buildListItem(
                      context,
                      'Create Custom Recipe Collections',
                      'Build personalized recipe collections to streamline your meal planning and cooking routines.',
                    ),
                    const Divider(),
                    _buildListItem(
                      context,
                      'Share Your Culinary Creations',
                      'Share your favorite recipes, cooking hacks, and culinary adventures with our vibrant community of fellow food enthusiasts.',
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Our Team',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Recipes Bos was developed by a dedicated team of food enthusiasts committed to inspiring and supporting culinary creativity. From seasoned chefs to passionate home cooks, our team strives to provide you with the tools and inspiration to unleash your inner chef.',
                  textAlign: TextAlign.justify,
                ),
                const Divider(),
                const SizedBox(height: 20),
                const Text(
                  'Get in Touch',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'We value your feedback and welcome any questions or suggestions you may have. Feel free to reach out to us at aakashs2021sa@gmail.com.',
                  textAlign: TextAlign.justify,
                ),
                const Divider(),
                const SizedBox(height: 10),
                const Text('Thank you for choosing Recipes Bos. Happy cooking!'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListItem(
    BuildContext context,
    String title,
    String description,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            description,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
