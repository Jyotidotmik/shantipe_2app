import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shantipe_2app/Screen/View/Onboarding_widget.dart';


class OnboardingScreen extends StatefulWidget {
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  final List<Map<String, String>> pages = [
    {
     "image": "lib/assets/images/b2b.png",
      "title": "B2B",
      "description": "B2B company can grow B2B sales with a smaller number of high-value deals compared to a B2C company, which might require thousands or even millions of individual sales to stay profitable."
    },
    {
      "image": "lib/assets/images/b2c.png",
      "title": "B2C",
      "description": "B2C refers to the type of relationship that the seller (business) has with its buyer (consumer). Unlike a business to business (B2B) company, B2C companies sell directly to their consumers rather than to large groups (typically other companies or businesses)."
    },
    {
      "image": "lib/assets/images/c2c.png",
      "title": "C2C",
      "description": "C2C is a customer-to-customer business model that facilitates transactions between private consumers.Benefits of C2C businesses include increased affordability, convenience and increased customer bases.A C2C business can operate via online auctions, e-commerce sites, money-transfer platforms and social media sites.."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: pages.length,
              onPageChanged: (index) {
                setState(() => currentIndex = index);
              },
              itemBuilder: (_, index) {
                final page = pages[index];
                return OnboardingPage(
                  image: page['image']!,
                  title: page['title']!,
                  description: page['description']!,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("SKIP",  style: TextStyle(color: Colors.black,fontSize: 18, fontWeight: FontWeight.w500)),
                Row(
                  children: List.generate(
                    pages.length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: currentIndex == index ? Colors.red : Colors.grey.shade300,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.toNamed('/login'),
                  child: const Text("NEXT", style: TextStyle(color: Color.fromARGB(255, 63, 34, 192),fontSize: 18, fontWeight: FontWeight.w500))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
