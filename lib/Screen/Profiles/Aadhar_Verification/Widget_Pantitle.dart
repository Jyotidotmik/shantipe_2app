import 'package:flutter/material.dart';

class PanTile extends StatelessWidget {
  final String title;
  final String value;

  const PanTile({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(bottom: size.height * 0.015),
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
              fontSize: size.width * 0.032,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: size.height * 0.004),
          Text(
            value,
            style: TextStyle(
              fontSize: size.width * 0.043,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}