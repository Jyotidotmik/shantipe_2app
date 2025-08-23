import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const OnboardingPage({
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 70),
      child: Column(
        children: [
          Image.asset(image, height: 300),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          if (title == "C2C") ...[
            const SizedBox(height: 10),
            // ElevatedButton(
            //   onPressed: () {},
            //   child: const Text("Learn more"),
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: Colors.blue.shade50,
            //     foregroundColor: Colors.blue,
            //   ),
            // )
          ]
        ],
      ),
    );
  }
}
