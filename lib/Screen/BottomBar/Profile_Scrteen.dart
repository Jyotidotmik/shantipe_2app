import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../Slider/CDM/CDM_Card_Screen.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              children: [
                _buildQRSection(context),
                _buildRewardsCard(),
                _buildStatsSection(),
                _buildMenuItems(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildQRSection(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
      // ignore: unused_local_variable
      final String upiId = 'jyotiprajapati4852@okaxis';
      final String upiLink = 'upi://pay?pa=jyotiprajapati4852@okaxis&pn=jyoti%20prajapati';

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            'Chandan Recharge Centre',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 24),
        Container(
  width: screenWidth * 0.6,
  height: screenWidth * 0.6,
  decoration: BoxDecoration(
    gradient: const LinearGradient(
      colors: [Colors.red, Colors.black],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(16),
  ),
  child: Container(
    margin: const EdgeInsets.all(3), //  Border thickness
    decoration: BoxDecoration(
      color: Colors.white, // Inner container color
      borderRadius: BorderRadius.circular(13),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(13),
      child: QrImageView(
        data: upiLink,
        version: QrVersions.auto,
        size: screenWidth * 0.6 - 6, // account for margin
        embeddedImage: const AssetImage('lib/assets/images/logo.png'),
        embeddedImageStyle: const QrEmbeddedImageStyle(
          size: Size(30, 30),
        ),
      ),
    ),
      ),
        ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.play_arrow, color: Colors.orange, size: 16),
              SizedBox(width: 4),
              Text(
                'DOTMIKPE09895614351@yesbankltd',
                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 16,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: [
              _buildActionButton(icon: Icons.visibility, label: 'View QR',callback: ()=> Get.toNamed('/qr_scanner'),),
              _buildCircleButton(icon: Icons.download, color: Colors.grey.shade300),
              _buildCircleButton(icon: Icons.share, color: Colors.grey.shade300),
              _buildCircleButton(icon: Icons.chat, color: Colors.green),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRewardsCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
            child: const Center(
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 12,
                child: Icon(Icons.star, color: Colors.orange, size: 14),
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ShantiPe Rewards Level', style: TextStyle(color: Colors.white, fontSize: 12)),
                Text('HERO', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          _buildStatCard('₹0', Icons.account_balance_wallet, 'Cashback'),
          _buildStatCard('₹0', Icons.card_giftcard, 'Coupons'),
        ],
      ),
    );
  }

  Widget _buildStatCard(String value, IconData icon, String label) {
    return Expanded(
      child: Column(
        children: [
          Text(value,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87)),
          //const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.blue, size: 18),
              const SizedBox(width: 6),
              Text(label, style: TextStyle(color: Colors.grey.shade600, fontSize: 16)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItems() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          SettingsItem(icon: Icons.person, title: "My Account", onTap: () => Get.toNamed('/my_account'),),
          const SizedBox(height: 10),
          SettingsItem(icon: Icons.image, title: "Digital Verification", onTap: () => Get.toNamed('/digital_verification'),),
          const SizedBox(height: 10),
           SettingsItem(icon: Icons.currency_rupee, title: "Payment Limits & Preferences", onTap: () {},),
          const SizedBox(height: 10),
           SettingsItem(icon: Icons.group_add, title: "Manage Staff", onTap: () {},),
          const SizedBox(height: 10),
           SettingsItem(icon: Icons.refresh_sharp, title: "Refer and Earn", onTap: () =>Get.toNamed('/refer&earn'),),
          // const SizedBox(height: 10),
          //  SettingsItem(icon: Icons.delivery_dining_outlined, title: "Orders", onTap: () {},),
          const SizedBox(height: 10),
           SettingsItem(icon: Icons.inventory_2_outlined, title: "Invoices", onTap: () => Get.toNamed('/invoice_screen')),
          const SizedBox(height: 10),
           SettingsItem(icon: Icons.settings, title: "Setting", onTap: () =>Get.toNamed('/setting'),),
          const SizedBox(height: 10),
           SettingsItem(icon: Icons.support, title: "Support -24x7 Help", onTap: () =>Get.toNamed('/supports')),
          const SizedBox(height: 10),
           SettingsItem(icon: Icons.question_answer_rounded, title: "Frequently Asked Question", onTap: () =>Get.toNamed('/faqs')),
            const SizedBox(height: 10),
          //  SettingsItem(icon: Icons.history, title: "Visit History", onTap: () {},),
          //   const SizedBox(height: 10),
           SettingsItem(icon: Icons.policy_sharp, title: "Policy Documents", onTap: () => Get.toNamed('/policy_documents')),
        ],
      ),
    );
  }

  static Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback callback,
  }) {
    return InkWell(
    onTap: callback,
    borderRadius: BorderRadius.circular(8),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.blue, size: 16),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ),
  );
  }

  static Widget _buildCircleButton({
    required IconData icon,
    required Color color,
  }) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Icon(
        icon,
        color: color == Colors.green ? Colors.white : Colors.grey.shade600,
        size: 20,
      ),
    );
  }
}
