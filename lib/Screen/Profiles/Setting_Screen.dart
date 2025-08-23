import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shantipe_2app/Utils/Custom_AppBar.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(titleText: 'Setting',
      onBackPress: () {
        print('Custom back press');
        Navigator.pop(context);
      },
      ),
      body:Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Text('Setting',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),
          const SizedBox(height: 30),
          SettingsItem(icon: Icons.notifications, title: "Notifications", onTap: () => Get.toNamed('/notification'),),
          const SizedBox(height: 10),
           SettingsItem(icon: Icons.outlet, title: "Misc", onTap: () => Get.toNamed('/misc'),),
          const SizedBox(height: 10),
       ])) );
      }
    }

class SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const SettingsItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
        child: Row(
          children: [
            Icon(icon, color: Colors.indigo, size: 26),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.indigo, size: 18),
          ],
        ),
      ),
    );
  }
}