import 'package:flutter/material.dart';

import '../../../Utils/Custom_AppBar.dart';
import 'Business_Button.dart';
import 'Widget._card.dart';

class BusinessDetailsScreen extends StatelessWidget {
  const BusinessDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: "Business Details",
        onBackPress: () {
          print("Custom back pressed");
          Navigator.pop(context);
        },
      ),
      backgroundColor: const Color(0xFFF9F9F9),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            /// Business Name
            InfoCard(
              title: 'BUSINESS NAME',
              value: 'Moksh Recharge Centre',
              showEdit: true,
              onEdit: () {
                print("Edit Business Name");
              },
            ),
            const SizedBox(height: 10),

            /// Monthly Turnover
            const InfoCard(
              title: 'MONTHLY TURNOVER',
              value: 'Greater than ₹1,50,000',
            ),
            const SizedBox(height: 10),

            /// Business Category
            const InfoCard(
              title: 'BUSINESS CATEGORY',
              value: 'Grocery/General Store',
            ),
            const SizedBox(height: 10),

            /// Sub Category
            const InfoCard(
              title: 'SUB-CATEGORY',
              value: 'Grocery store',
            ),
            const SizedBox(height: 25),

            const Text(
              'Are you currently not using any other QR code to accept payments?',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: OptionButton(
                    label: 'Yes',
                    onTap: () {
                      print("Yes tapped");
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OptionButton(
                    label: 'No',
                    onTap: () {
                      print("No tapped");
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
