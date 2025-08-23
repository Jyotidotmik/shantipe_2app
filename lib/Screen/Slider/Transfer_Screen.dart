import 'package:flutter/material.dart';

import '../../Utils/Custom_AppBar.dart';
import 'CarouselSlider_Screen.dart';


class TransferScreen extends StatelessWidget {
  const TransferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor:  Colors.white,
       appBar: CustomAppBar(
        titleText: "Transfer Details",
        onBackPress: () {
          print("Custom back pressed");
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(size.width * 0.04),
        child: Column(
          children: [
            CarouselSliderWidget(images: ['lib/assets/images/banner.png', 'lib/assets/images/banner2.png', 'lib/assets/images/banner3.png']),
            SizedBox(height: size.height * 0.03),
            // Grid Menu
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: size.width * 0.03,
              mainAxisSpacing: size.height * 0.02,
              childAspectRatio: 1.2,
              children: [
                _buildMenuCard(Icons.send, "APeS Transfer", Colors.purple),
                _buildMenuCard(Icons.swap_horiz, "DMT Transfer", Colors.pink),
                _buildMenuCard(Icons.group, "Fund Transfer", Colors.orange),
                _buildMenuCard(Icons.history, "UPI Transfer", Colors.blueGrey),
                _buildMenuCard(Icons.bar_chart, "Credit Card Bill Payment", Colors.green),
                _buildMenuCard(Icons.account_balance_wallet, "Wallet To Wallet", Colors.blue),
              ],
            ),
          ],
        ),
      ),

    );
  }

  Widget _buildMenuCard(IconData icon, String title, Color color) {
    return Container(
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.2),
            child: Icon(icon, color: color),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
