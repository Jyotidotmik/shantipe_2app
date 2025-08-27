import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../Utils/Custom_AppBar.dart';
import 'Widget/Bank_CardWidgwet.dart';
import 'Widget/Card_Widget.dart';

class MpinScreen extends StatefulWidget {
  @override
  _MpinScreenState createState() => _MpinScreenState();
}

class _MpinScreenState extends State<MpinScreen> {
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 360;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        titleText: "",
        onBackPress: () {
          Navigator.pop(context);
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 25, right: 25),
          child: Column(
            children: [
              SizedBox(height: 40),
              // PIN Entry Section
              Text(
                'ENTER 4-DIGIT PAYMENT MPIN',
                style: TextStyle(
                  fontSize: isSmallScreen ? 15 : 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                  letterSpacing: 0.3,
                ),
              ),
              SizedBox(height: 30),
              // PIN Input Field
              PinCodeTextField(
                controller: _otpController,
                cursorColor: Colors.black,
                appContext: context,
                length: 4,
                keyboardType: TextInputType.number,
                animationDuration: const Duration(milliseconds: 200),
              ),

              SizedBox(height: 30),
              // Warning message
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xFFFFF3CD),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Color(0xFFFFB020),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.info, color: Colors.white, size: 12),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'You are transferring money from your account to this merchant. SUPERPAYMENT.in',
                        style: TextStyle(
                          fontSize: isSmallScreen ? 11 : 12,
                          color: Color(0xFF8B5A00),
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              //eneficiaryCard(name: 'KOMAL KUMARI', bankName: 'HDFC Bank', ifscCode: 'HDFC0087687', account: '876589435627', logo: '',  onSend: () {  },),
              CardWidget(bankName: 'State Bank Of India', logo: '', name: 'KOMAL KUMARI', account: '987654325678', ifscCode: 'SBI00006781', amount: '234', mode: 'IMPS',),
               Spacer(),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff0080FF),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 100,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {},
                  // onPressed: () => Get.toNamed('/'),
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
