import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shantipe_2app/Screen/BBPS/view_more.dart';

import '../Slider/CarouselSlider_Screen.dart';

class HomeScreen extends StatefulWidget {
  //  final Map<dynamic, dynamic> data;
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final Map<dynamic, dynamic> safeData;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: [_buildFirstPage(), _buildSecondPage()],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(2, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPage == index ? 12 : 8,
                  height: 8,
                  decoration: BoxDecoration(color: _currentPage == index ? Colors.blue : Colors.grey, borderRadius: BorderRadius.circular(4)),
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Money Transfer', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
                  const SizedBox(height: 10),
                  Container(
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
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: GridView.count(
                        crossAxisCount: 4,
                        shrinkWrap: true,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          _buildQuickLink(context, Icons.phone, 'Aeps', ()  => Get.toNamed('/AePS_screen'),),
                          _buildQuickLink(context, Icons.campaign, 'DMT Transfer', () {}),
                          _buildQuickLink(context, Icons.speaker, 'Fund Transfer', () => Get.toNamed('/Fund_Login')),
                          _buildQuickLink(context, Icons.transform_rounded, 'UPI Transfer', () {}),
                          _buildQuickLink(context, Icons.card_membership, 'Credit Card Bill Payment', () {}),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Utility', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
                      
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
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
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: GridView.count(
                        crossAxisCount: 4,
                        shrinkWrap: true,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          _buildQuickLink(context, Icons.phone, 'Mobile Recharge', () {}),
                          _buildQuickLink(context, Icons.campaign, 'DTH Recharge', () {}),
                          _buildQuickLink(context, Icons.speaker, 'Broadband postp..', () {}),
                          _buildQuickLink(context, Icons.electric_bolt, 'Electricit', (){}),
                          _buildQuickLink(context, Icons.speaker, 'Water', (){}),
                          _buildQuickLink(context, Icons.campaign, 'Gas', () {}),
                          _buildQuickLink(context, Icons.speaker, 'LPG Gas', () {}),
                          _buildQuickLink(context, Icons.add, ' View more', () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => ViewMore()));
                          }),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text('Insurance', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
                  const SizedBox(height: 10),
                  Container(
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
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: GridView.count(
                        crossAxisCount: 4,
                        shrinkWrap: true,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          _buildQuickLink(context, Icons.healing, 'Health', () {}),
                          _buildQuickLink(context, Icons.car_repair, 'Cars', () {}),
                          _buildQuickLink(context, Icons.bike_scooter, 'Bikes', () {}),
                          _buildQuickLink(context, Icons.line_axis, 'Life', () {}),
                          _buildQuickLink(context, Icons.car_crash, 'GCV', () {}),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text('Top Picks', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
                  const SizedBox(height: 10),
                  Container(
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
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: GridView.count(
                        crossAxisCount: 4,
                        shrinkWrap: true,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          _buildQuickLink(context, Icons.comment_bank_sharp, 'Account Opening', () => {}),
                          _buildQuickLink(context, Icons.bakery_dining, 'Demat Account', (){}),
                          _buildQuickLink(context, Icons.speaker, 'Credit Card', () {}),
                          _buildQuickLink(context, Icons.speaker, 'Credit Line', () {}),
                          _buildQuickLink(context, Icons.electric_bolt, 'Investment', () {}),
                          _buildQuickLink(context, Icons.campaign, 'Personal Loan', () {}),
                          _buildQuickLink(context, Icons.speaker, 'Business Loan', () {}),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CarouselSliderWidget(images: ['lib/assets/images/banner.png', 'lib/assets/images/banner2.png', 'lib/assets/images/banner3.png']),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //-----------------Waalet to wallet widget-----------------
  Widget _buildFirstPage() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xffFFFFFF), Color(0xFF3B82F6)]),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 10),
            // ignore: deprecated_member_use
            Text('Total Wallet Balance', style: TextStyle(color: Colors.black.withOpacity(0.8), fontSize: 20, fontWeight: FontWeight.bold)),
            Text('₹25,000.00', style: const TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(Icons.arrow_upward,"Send", ()  => Get.toNamed('/send_screen'),),
                _buildActionButton(Icons.arrow_downward, "Receive", ()  => Get.toNamed('/Receive')),
                _buildActionButton(Icons.card_membership, "Apply Crad", () => Get.toNamed('/card_screen')),
                _buildActionButton(Icons.account_balance, "Fund Request", () => Get.toNamed('/fund_request')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  //----------------------second AePS Wallet widget---------------------
  Widget _buildSecondPage() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xffFFFFFF), Color(0xFF3B82F6)]),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
                child: Column(
          children: [
            const SizedBox(height: 10),
            Text('AePS Wallet Balance', style: TextStyle(color: Colors.black.withOpacity(0.8), fontSize: 20, fontWeight: FontWeight.bold)),
            const Text('₹18,500.00', style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(Icons.savings, "Save", ()  {}),
                 _buildActionButton(Icons.history, "History", () => Get.toNamed('/history'),),
                _buildActionButton(Icons.report, "Reports", () => Get.toNamed('/reports')),
                _buildActionButton(Icons.account_balance, "Transfer", () => Get.toNamed('/transfer'),),
              ],
            ),
          ],
        ),
      ),
    );
  }

Widget _buildActionButton(IconData icon, String label, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.blue, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

  //-------------Service Widget---------------------------
  Widget _buildQuickLink(BuildContext context, IconData icon, String label,  VoidCallback onTap) {
    return GestureDetector(
     onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 30, height: 40, child: Icon(icon, color: Colors.blue, size: 25)),
          //SizedBox(height: 5),
          Text(label, textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: Colors.black)),
        ],
      ),
    );
  }
}

