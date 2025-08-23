// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:shantipe_2app/Utils/Custom_AppBar.dart';

class HelpTopicsScreen extends StatelessWidget {
  const HelpTopicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        titleText: 'FAQs Question',
     onBackPress: () {
       print(' Custom back press');
       Navigator.pop(context);
     },
     ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTopicItem(context,
                  "My documents are approved. When will the held amount be released?"),
              _buildTopicItem(
                  context, "Why are my uploaded documents rejected?"),
              _buildTopicItem(context,
                  "What do I do when my documents are rejected?"),

              _buildSectionHeader(context, "Easy Loans"),
              _buildTopicItem(context, "How do I apply for a loan?"),
              _buildTopicItem(context,
                  "What is the interest rate on ShantiPe Easy Loan?"),
              _buildTopicItem(context,
                  "What is the loan tenure of ShantiPe Easy Loan?"),

              _buildSectionHeader(context, "ShantiPeSwipe"),
              _buildTopicItem(
                  context, "How do I order a ShantiPe Swipe machine?"),
              _buildTopicItem(context, "What is ShantiPe One?"),
              _buildTopicItem(context, "What are the charges of ShantiPe One?"),

              _buildSectionHeader(context, "ShantiPe QR"),
              _buildTopicItem(context,
                  "Are there any charges if I accept payments from the ShantiPe QR code?"),
              _buildTopicItem(context,
                  "What is the main purpose of ShantiPeQR code?"),
              _buildTopicItem(context,
                  "What was the original purpose of a ShantiPe QR code?"),
              _buildTopicItem(context,
                  "Choose between static and dynamic QR Codes (What’s the difference?)"),
                  _buildTopicItem(context,
                  "What happens after scanning a QR Code?"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    final w = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: w * 0.03),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: w * 0.04,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            "View All",
            style: TextStyle(
              fontSize: w * 0.035,
              fontWeight: FontWeight.w500,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopicItem(BuildContext context, String text) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: h * 0.012),
        child: Row(
          children: [
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: w * 0.037,
                  color: Colors.black87,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: w * 0.035,
              color: Colors.blueAccent,
            ),
          ],
        ),
      ),
    );
  }
}
