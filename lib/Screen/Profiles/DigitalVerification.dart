import 'package:flutter/material.dart';
import 'package:shantipe_2app/Utils/Custom_AppBar.dart';

class DigitalVerificationScreen extends StatelessWidget {
  const DigitalVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(titleText: 'Digital Verifications',
      onBackPress: () {
        print('Custom back press');
        Navigator.pop(context);
      },),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.06),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Complete your digital verification",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: h * 0.01),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green.shade400,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Free',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: h * 0.02),
                Center(
                  child: Column(
                    children: [
                      const Text(
                        "CLICK\nSHOP PHOTO",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF0023F9),
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1,
                        ),
                      ),
                      SizedBox(height: h * 0.02),
                      Image.asset(
                        'lib/assets/images/store.png',
                        height: h * 0.20,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: h * 0.03),
                _buildStepTile(
                  context,
                  icon: Icons.photo_camera_outlined,
                  step: "STEP 1",
                  title: "Click shop photos",
                ),
                SizedBox(height: h * 0.015),
                _buildStepTile(
                  context,
                  icon: Icons.location_on_outlined,
                  step: "STEP 2",
                  title: "Verify business address",
                ),
                SizedBox(height: h * 0.015),
                _buildStepTile(
                  context,
                  icon: Icons.person_outline,
                  step: "STEP 3 (OPTIONAL)",
                  title: "Selfie with shop",
                ),
                const Spacer(),
                const Center(
                  child: Text(
                    "It’d take 2–3 mins only",
                    style: TextStyle(
                      color: Color(0xFF5F6B80),
                      fontSize: 14,
                    ),
                  ),
                ),
                SizedBox(height: h * 0.015),
                SizedBox(
                  width: double.infinity,
                  height: h * 0.055,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      "Start Verification",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                    ),
                  ),
                ),
                SizedBox(height: h * 0.02),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStepTile(BuildContext context,
      {required IconData icon,
      required String step,
      required String title}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
                      color: Color(0xffFFFFFF),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1), // Shadow color
                          spreadRadius: 2, // Kitna area cover kare shadow
                          blurRadius: 8, // Shadow ka smoothness
                          offset: Offset(0, 0), // 0,0 means har side se equal shadow
                        ),
                      ],
                    ),
      child: Row(
        children: [
          Icon(icon, size: 24, color: Colors.blue),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                step,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF5F6B80),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
