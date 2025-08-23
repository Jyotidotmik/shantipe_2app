import 'package:flutter/material.dart';
import 'package:shantipe_2app/Utils/Custom_AppBar.dart';

class RewardsHubScreen extends StatelessWidget {
  const RewardsHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
       appBar: CustomAppBar(titleText: 'Refer & Earn',
     onBackPress: () {
       print(' Custom back press');
       Navigator.pop(context);
     },
     ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(w * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Banner
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(w * 0.04),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF007BFF), Color(0xFF4FC3F7)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "REWARDS",
                          style: TextStyle(
                            fontSize: w * 0.06,
                            fontWeight: FontWeight.bold,
                            // ignore: deprecated_member_use
                            color: Colors.red.shade100.withOpacity(0.9),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: h * 0.005),
                    const Text(
                      "Prizes, cashback and much more!",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ),
              SizedBox(height: h * 0.02),

              // Progress Levels
              Container(
                padding: EdgeInsets.symmetric(vertical: h * 0.02),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildLevelItem(
                          context,
                          icon: Icons.star,
                          label: "Hero",
                          active: true,
                        ),
                        Container(
                          width: w * 0.15,
                          height: 4,
                          color: Colors.blue.shade300,
                        ),
                        _buildLevelItem(
                          context,
                          icon: Icons.star_border,
                          label: "Star",
                          active: false,
                          locked: true,
                        ),
                        Container(
                          width: w * 0.15,
                          height: 4,
                          color: Colors.grey.shade300,
                        ),
                        _buildLevelItem(
                          context,
                          icon: Icons.emoji_events_outlined,
                          label: "Legend",
                          active: false,
                          locked: true,
                        ),
                      ],
                    ),
                    SizedBox(height: h * 0.01),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: Colors.blue),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "SEE MY BENEFITS",
                        style: TextStyle(color: Colors.blue),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: h * 0.02),

              // Cashback & Coupons
              Row(
                children: [
                  Expanded(
                    child: _infoCard(
                      context,
                      title: "₹0",
                      subtitle: "Cashback",
                      icon: Icons.currency_rupee,
                    ),
                  ),
                  SizedBox(width: w * 0.04),
                  Expanded(
                    child: _infoCard(
                      context,
                      title: "0",
                      subtitle: "Coupons",
                      icon: Icons.card_giftcard,
                    ),
                  ),
                ],
              ),
              SizedBox(height: h * 0.02),

              // Tab buttons
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: h * 0.015),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Text(
                          "MY PROGRAMS",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: w * 0.02),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: h * 0.015),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Text(
                          "SPECIAL OFFERS",
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: h * 0.02),

              // Empty Programs
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(w * 0.06),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  children: [
                    // Icon(Icons.inventory_2_outlined,
                    //     size: h * 0.06, color: Colors.grey),
                    Image.asset('lib/assets/images/open-box.png', height: h * 0.07, ),
                    SizedBox(height: h * 0.01),
                    const Text(
                      "Programs Upcoming",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: h * 0.005),
                    const Text(
                      "There are no programs for you right now. Stay tuned to know about the upcoming programs!",
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLevelItem(BuildContext context,
      {required IconData icon,
      required String label,
      bool active = false,
      bool locked = false}) {
    final w = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: w * 0.07,
              backgroundColor:
                  active ? Colors.blue.shade50 : Colors.grey.shade200,
              child: Icon(icon,
                  size: w * 0.08, color: active ? Colors.blue : Colors.grey),
            ),
            if (locked)
              Positioned(
                right: 0,
                top: 0,
                child: Icon(Icons.lock, size: w * 0.04, color: Colors.grey),
              ),
          ],
        ),
        SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
              color: active ? Colors.blue : Colors.grey,
              fontWeight: active ? FontWeight.bold : FontWeight.normal),
        )
      ],
    );
  }

  Widget _infoCard(BuildContext context,
      {required String title,
      required String subtitle,
      required IconData icon}) {
    final w = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(vertical: w * 0.01),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: w * 0.06),
          ),
         Divider(
          color: Colors.grey,
          thickness: 1,
          indent : 10,
          endIndent : 10,       
       ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: w * 0.045, color: Colors.blue),
              const SizedBox(width: 4),
              Text(
                subtitle,
                style: TextStyle(color: Colors.grey, fontSize: w * 0.035),
              ),
            ],
          )
        ],
      ),
    );
  }
}
