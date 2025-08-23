import 'package:flutter/material.dart';
import 'package:shantipe_2app/Utils/Custom_AppBar.dart';

class GstDetailsscreen extends StatefulWidget {
  const GstDetailsscreen({super.key});

  @override
  State<GstDetailsscreen> createState() => _GstDetailsscreenState();
}

class _GstDetailsscreenState extends State<GstDetailsscreen> {
  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppBar(titleText: 'GST Details',
      onBackPress: () {
        print('Custom back press');
        Navigator.pop(context);
      },),
      backgroundColor: const Color(0xFFF9F9F9),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              color: const Color(0xFFD1FADF), // Light green
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle, color: Color(0xFF12B76A)),
                  SizedBox(width: 8,),
                  Text('Verified',style: TextStyle(
                        color: Color(0xFF12B76A),
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPanTile(title: "GST NUMBER", value: "06ANSPY6878R1Z9", size: size),
                  ],
                ),
              ),
            ),
            SizedBox(height: 160),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF1F5),
                borderRadius: BorderRadius.circular(8)
              ),
              child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.lock_outline, size: 18,),
                  SizedBox(width: 8),
                  Text(
                      "GST details can't be changed",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                ],
              ),
            )
          ],
        ),
      )
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
          // SizedBox(height: size.height * 0.003),
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