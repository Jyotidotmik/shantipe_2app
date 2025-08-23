import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shantipe_2app/Screen/Profiles/My_Account/Widget.dart';
import 'package:shantipe_2app/Utils/Custom_AppBar.dart';

class ManageAccountScreen extends StatelessWidget {
  const ManageAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // ignore: unused_local_variable
    final screenHeight = MediaQuery.of(context).size.height;
    final isTablet = screenWidth > 600;
    final isLargeScreen = screenWidth > 900;
    
    // Responsive padding and spacing
    final horizontalPadding = isLargeScreen ? 32.0 : isTablet ? 24.0 : 16.0;

    return Scaffold(
     backgroundColor: Colors.white,
      appBar: CustomAppBar(
        titleText: "Manage Account",
        onBackPress: () {
          print("Custom back pressed");
          Navigator.pop(context);
        },
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 15,right: 15),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                  maxWidth: isLargeScreen ? 800 : double.infinity,
                ),
                child: Container(
                  width: double.infinity,
                  alignment: isLargeScreen ? Alignment.center : null,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      //-----------------BASIC Section------------------------------------
                      _buildSectionHeader('BASIC', horizontalPadding, isTablet),
                      SizedBox(height: 10),
                      SettingsItem(icon: Icons.business, title: "Business Details", onTap: () => Get.toNamed('/Business'),),
                      SizedBox(height: 10),
                      SettingsItem(icon: Icons.location_on, title: "My Addresss", onTap: () => Get.toNamed('/my_address'),),
                      SizedBox(height: 10),
                      SettingsItem(icon: Icons.phone, title: "Phone Number", onTap: () => Get.toNamed('/phone_number'),),
                      SizedBox(height: 10),
                      //------------------KYC Section-------------------------------------
                      _buildSectionHeader('KYC', horizontalPadding, isTablet),
                      SizedBox(height: 10),
                      SettingsItem(icon: Icons.account_balance, title: "Bank Accounts", onTap: () => Get.toNamed('/bank_account'),),
                      SizedBox(height: 10),
                      SettingsItem(icon: Icons.credit_card, title: "PAN Number", onTap: () => Get.toNamed('/pan_details'),),
                      SizedBox(height: 10),
                      SettingsItem(icon: Icons.fingerprint, title: "Aadhaar Number'", onTap: () => Get.toNamed('/aadhar_details'),),
                      SizedBox(height: 10),
                      SettingsItem(icon: Icons.photo_camera,title: 'Shop Photos',onTap: ()  =>Get.toNamed('/shop_details')),
                      SizedBox(height: 10),
                      //----------------------------OTHERS Section-------------------------
                      _buildSectionHeader('OTHERS', horizontalPadding, isTablet),
                      SizedBox(height: 10),
                      SettingsItem(
                        icon: Icons.description,
                        title: 'Business Documents',
                        onTap: () =>Get.toNamed('/upload_document')
                      ),
                      SizedBox(height: 10),
                      SettingsItem(
                        icon: Icons.local_activity,
                        title: 'GST Details',
                        onTap: () =>Get.toNamed('/gst_details'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  
  Widget _buildSectionHeader(String title, double horizontalPadding, bool isTablet) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Text(
        title,
        style: TextStyle(
          fontSize: isTablet ? 14 : 16,
          fontWeight: FontWeight.w500,
          color: Colors.black,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}



