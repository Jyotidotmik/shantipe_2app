import 'package:flutter/material.dart';
import 'package:shantipe_2app/Utils/Custom_AppBar.dart';

class PanVerificationScreen extends StatelessWidget {
  const PanVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // ignore: unused_local_variable
    final double padding = size.width * 0.05;

    return Scaffold(
      appBar: CustomAppBar(
        titleText: "PAN Verifications",
        onBackPress: () {
          print("Custom back pressed");
          Navigator.pop(context);
        },
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        //padding: EdgeInsets.symmetric(horizontal: padding, vertical: size.height * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height * 0.02),
            // Verified banner
             Container(
              width: double.infinity,
              color: const Color(0xFFD1FADF), // Light green
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle, color: Color(0xFF12B76A)),
                  SizedBox(width: 8),
                  Text(
                    'Verified',
                    style: TextStyle(
                      color: Color(0xFF12B76A),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            //  PAN Details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPanTile(title: "PAN NUMBER", value: "ANSPY6878R", size: size),
                    _buildPanTile(title: "DATE OF BIRTH", value: "23-02-1996", size: size),
                    _buildPanTile(title: "NAME", value: "LALIT YADAV", size: size),
                    _buildPanTile(title: "ENTITY", value: "INDIVIDUAL", size: size),
                  ],
                ),
              ),
            ),
            SizedBox(height: size.height * 0.04),
            // Lock Message
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFE5EAF1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.lock_outline, size: 18),
                  SizedBox(width: 8),
                  Text(
                    "PAN number can't be changed",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPanTile({
    required String title,
    required String value,
    required Size size,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: size.height * 0.02),
      padding: EdgeInsets.all(size.width * 0.04),
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
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.grey,
              fontSize: size.width * 0.035,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: size.height * 0.005),
          Text(
            value,
            style: TextStyle(
              fontSize: size.width * 0.045,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
