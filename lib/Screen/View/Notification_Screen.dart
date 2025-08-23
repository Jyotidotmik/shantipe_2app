import 'package:flutter/material.dart';
import 'package:shantipe_2app/Utils/Custom_AppBar.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool pushEnabled = true;
  bool voiceEnabled = true;
  bool whatsappEnabled = false;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(titleText: 'Notification',
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
              // Info Banner
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(w * 0.04),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3E0),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(Icons.notifications_active,
                        color: Colors.orange, size: w * 0.08),
                    SizedBox(width: w * 0.04),
                    Expanded(
                      child: Text(
                        "Turn on other notifications too to never miss a update",
                        style: TextStyle(
                          fontSize: w * 0.035,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: h * 0.02),
              // Push Notification
              _buildNotificationTile(
                context,
                icon: Icons.message_rounded,
                iconBg: Colors.blue.shade100,
                title: "Push Notification",
                subtitle: "Play preview",
                enabled: pushEnabled,
                onChanged: (value) {
                  setState(() => pushEnabled = value);
                },
              ),
              SizedBox(height: h * 0.015),
              // Voice Notification
              _buildNotificationTile(
                context,
                icon: Icons.volume_up_rounded,
                iconBg: Colors.purple.shade100,
                title: "Voice Notification",
                subtitle: "Play preview",
                enabled: voiceEnabled,
                onChanged: (value) {
                  setState(() => voiceEnabled = value);
                },
              ),
              SizedBox(height: h * 0.03),
              // Others Title
              const Text(
                "Others",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: h * 0.015),
              // WhatsApp Notification
              _buildNotificationTile(
                context,
                icon: Icons.wallpaper,
                iconBg: Colors.green.shade100,
                title: "Whatsapp Notification",
                subtitle: "You will be charged ₹19/month",
                enabled: whatsappEnabled,
                onChanged: (value) {
                  setState(() => whatsappEnabled = value);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationTile(
    BuildContext context, {
    required IconData icon,
    required Color iconBg,
    required String title,
    required String subtitle,
    required bool enabled,
    required ValueChanged<bool> onChanged,
  }) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: w * 0.04, vertical: h * 0.015),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: iconBg,
            radius: w * 0.07,
            child: Icon(icon, color: Colors.black87, size: w * 0.07),
          ),
          SizedBox(width: w * 0.04),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: w * 0.04,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: w * 0.035,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: enabled,
            activeColor: Colors.white,
            activeTrackColor: Colors.blue,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
