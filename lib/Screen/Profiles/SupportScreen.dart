import 'package:flutter/material.dart';
import 'package:shantipe_2app/Utils/Custom_AppBar.dart';

import '../Slider/CarouselSlider_Screen.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'label': 'LOAN', 'icon': Icons.account_balance_wallet},
      {'label': 'PAYMENTS', 'icon': Icons.currency_rupee},
      {'label': 'FUND TRANSFER', 'icon': Icons.data_thresholding},
      {'label': 'SWIPE', 'icon': Icons.point_of_sale},
      {'label': 'INVESTMENT', 'icon': Icons.trending_up},
      {'label': 'QR', 'icon': Icons.qr_code_2},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
     appBar: CustomAppBar(titleText: 'Support & Help',
     onBackPress: () {
       print(' Custom back press');
       Navigator.pop(context);
     },
     ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionHeader("Select a product", onViewAll: () {}),
                const SizedBox(height: 12),
                GridView.count(
                physics: const NeverScrollableScrollPhysics(), 
                  shrinkWrap: true, 
                    crossAxisCount: 3,
                      crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                          children: categories.map((cat) {
                            return _buildCategoryTile(cat['icon'] as IconData, cat['label'] as String);
                            }).toList(),
                             ),
                const SizedBox(height: 24),
                _buildSectionHeader("FAQ'S", onViewAll: () {}),
                const SizedBox(height: 16),
               _buildSectionHeader("General Queries", onViewAll: () {}),
               const SizedBox(height: 16),
                CarouselSliderWidget(images: ['lib/assets/images/banner.png', 'lib/assets/images/banner2.png', 'lib/assets/images/banner3.png']),
                const SizedBox(height: 16),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(String title, {VoidCallback? onViewAll}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        if (onViewAll != null)
          GestureDetector(
            onTap: onViewAll,
            child: const Text("VIEW ALL", style: TextStyle(color: Colors.blue)),
          ),
      ],
    );
  }

  Widget _buildCategoryTile(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.blue, size: 30),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  // Widget _buildVideoCard({required String title, required String subtitle}) {
  //   return Container(
  //     margin: const EdgeInsets.only(right: 12),
  //     padding: const EdgeInsets.all(12),
  //     decoration: BoxDecoration(
  //       color: const Color.fromARGB(255, 230, 224, 224),
  //       borderRadius: BorderRadius.circular(12),
  //     ),
  //     child: Row(
  //       children: [
  //         const SizedBox(width: 12),
  //         Expanded(
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Text(title,
  //                   style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
  //                   maxLines: 2,
  //                   overflow: TextOverflow.ellipsis),
  //                   const SizedBox(height: 6),
  //                     Text(subtitle,
  //                   style: const TextStyle(fontSize: 14, color: Colors.black87),
  //                   maxLines: 2,
  //                   overflow: TextOverflow.ellipsis),
  //                  ],
  //                ),
  //             ),
  //          ],
  //        ),
  //   );
  // }
}
