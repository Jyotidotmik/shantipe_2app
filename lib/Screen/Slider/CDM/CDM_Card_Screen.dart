// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../../Utils/Custom_AppBar.dart';
import 'cdm_pending.dart';

class AddNewCardScreen extends StatefulWidget {
  const AddNewCardScreen({super.key});

  @override
  State<AddNewCardScreen> createState() => _AddNewCardScreenState();
}

class _AddNewCardScreenState extends State<AddNewCardScreen> {
  bool _termsAccepted = false;
  bool _cardGenerated = false; // नया flag card generate होने के बाद दिखाने के लिए

  void _showTermsAndConditions() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.8,
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Terms and Conditions',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF000000),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(Icons.close),
                    ),
                  ],
                ),
                Divider(),
                Expanded(
                  child: SingleChildScrollView(
                    child:Text(
                      '''Terms and Conditions for Axis CDM Card
1. Introduction
1.1 Dotmik Software Private Limited (hereinafter referred to as "the Company") offers distributor retailers the opportunity to apply for the Axis CDM Card for the purpose of cash deposit into the Company's account, facilitating various financial transactions.
1.2 By applying for and using the Axis CDM Card, distributor retailers agree to adhere to these Terms and Conditions governing its use.

2. Eligibility Criteria
2.1 The Axis CDM Card is available to distributor retailers who meet the following eligibility criteria: - Must be a registered distributor or retailer with Dotmik Software Private Limited. - Must possess a valid business license or registration certificate. - Must comply with all applicable laws and regulations.

3. Card Usage
3.1 The Axis CDM Card is strictly designated for depositing cash into the account of Dotmik Software Private Limited on behalf of the distributor retailer.
3.2 Cash deposited via the Axis CDM Card shall be considered the property of the distributor retailer and not the Company.
3.3 The distributor retailer acknowledges and agrees that any compliance inquiries or requirements from government authorities regarding deposited cash shall be the sole responsibility of the distributor retailer.
3.4 The distributor retailer further agrees that any cash deposited into Dotmik Software Private Limited's account using the Axis CDM Card is solely for the purpose of utilizing Dotmik Software Private Limited's services, and that Dotmik Software Private Limited bears no ownership or liability over the deposited cash.
3.5 By proceeding with the use of the Axis CDM Card, the distributor retailer confirms their strict acceptance of these conditions, validated through an OTP sent to their registered email address.

4. Client Information
4.1 As part of the application process for the Axis CDM Card, Dotmik Software Private Limited will collect the following client information: - Client Name - PAN Card Number - Mobile Number - Aadhaar Card Number - Address - Shop Name
4.2 The collection and storage of client information will comply with applicable data protection laws and regulations.

5. Government Compliance
5.1 The distributor retailer acknowledges and agrees to comply with all relevant government regulations and compliance requirements applicable to cash deposits and financial transactions, including but not limited to: - Anti-Money Laundering (AML) laws and regulations. - Know Your Customer (KYC) norms. - Reporting requirements under the Prevention of Money Laundering Act (PMLA).
5.2 The distributor retailer agrees to provide Dotmik Software Private Limited with accurate and up-to-date information as required for compliance purposes.
5.3 The distributor retailer further agrees to cooperate with Dotmik Software Private Limited in any inquiries or audits conducted by regulatory authorities.

6. Fees
6.1 The Company charges a fee of INR 100 + GST for each Axis CDM Card issued to distributor retailers.

7. Responsibilities
7.1 By accepting the Axis CDM Card, distributor retailers agree to: - Safeguard the Axis CDM Card and refrain from disclosing the PIN or other security information to unauthorized persons. - Utilize the Axis CDM Card solely for authorized transactions as outlined in these Terms and Conditions. - Assume full responsibility for any compliance inquiries or requirements from government authorities regarding deposited cash. - Immediately report any loss or theft of the Axis CDM Card to the Company.

8. Withdrawal of Services
8.1 The Company reserves the right to suspend or withdraw the Axis CDM Card from any distributor retailer found to violate these Terms and Conditions, engage in fraudulent activities, or misuse the card for illegal purposes.

9. Liability
9.1 The Company holds no liability for losses arising from unauthorized use of the Axis CDM Card, provided the distributor retailer has complied with their responsibilities as outlined in these Terms and Conditions.

10. Amendments
10.1 The Company reserves the right to modify these Terms and Conditions at its discretion. Amendments will become effective immediately upon posting on the Company's official website or notification to distributor retailers through other appropriate means.

11. Governing Law and Jurisdiction
11.1 These Terms and Conditions are governed by and construed in accordance with the laws of India.
11.2 Any dispute arising from or in connection with these Terms and Conditions shall be subject to the exclusive jurisdiction of the courts in Delhi, specifically the Delhi High Court.

12. Contact Information
12.1 For inquiries regarding the Axis CDM Card or these Terms and Conditions, please contact: - Email: help@dotmik.com''',
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Close'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Loader dialog
  void showCreditCardLoader(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, 
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(
                  color: Colors.blue,
                  strokeWidth: 3,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Wait... Generating your credit card",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        titleText: "Apply CDM Card",
        onBackPress: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(size.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card or Image
            Container(
              height: size.height * 0.25,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.blue.shade700,
              ),
              child: _cardGenerated
                  ? _buildCreditCardUI() // custom card widget
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        'lib/assets/images/credit.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
            SizedBox(height: size.height * 0.03),
            // Inputs
            SettingsItem(icon: Icons.person, title: "Card Holder Name", onTap: () {}),
            SizedBox(height: size.height * 0.01),
            SettingsItem(icon: Icons.phone, title: "Number", onTap: () {}),
            SizedBox(height: size.height * 0.01),
            SettingsItem(icon: Icons.email, title: "Email", onTap: () {}),
            SizedBox(height: size.height * 0.01),
            SettingsItem(icon: Icons.location_on, title: 'Address', onTap: () {}),
            SizedBox(height: size.height * 0.015),
            // Terms
            Row(
              children: [
                Checkbox(
                  value: _termsAccepted,
                  onChanged: (bool? value) async {
                    if (value == true) {
                      _showTermsAndConditions();
                      setState(() {
                        _termsAccepted = true;
                      });
                    } else {
                      setState(() {
                        _termsAccepted = false;
                      });
                    }
                  },
                  activeColor: Colors.blue,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      _showTermsAndConditions();
                      setState(() {
                        _termsAccepted = true;
                      });
                    },
                    child: Text(
                      "Terms & Conditions",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.05),

            // Apply Button
            SizedBox(
              width: double.infinity,
              height: size.height * 0.06,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CdmPending()));
                  // showCreditCardLoader(context);
                  // Future.delayed(const Duration(seconds: 3), () {
                  //   Navigator.pop(context); // loader बंद
                  //   setState(() {
                  //     _cardGenerated = true; // card दिखाओ
                  //   });
                  // });
                },
                child: const Text(
                  "Apply Now",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // custom credit card UI
  Widget _buildCreditCardUI() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.indigo, Colors.blueAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
              Row(
                    children: [
                      Image.asset('lib/assets/images/hdfc.png', height: 30,width: 30),
                      // const SizedBox(width: 80),
                      Spacer(flex: 3),
                      Expanded(
                        child: Text(
                         // toBank,
                         'HDFC BANK',
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
          // Text("Dotmik Bank",
          //    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          Spacer(),
          Text("**** **** **** 2456",
              style: TextStyle(color: Colors.white, fontSize: 22, letterSpacing: 2)),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Card Holder",
                  style: TextStyle(color: Colors.white70, fontSize: 12)),
              Text("Valid Thru",
                  style: TextStyle(color: Colors.white70, fontSize: 12)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Rahul Sharma",
                  style: TextStyle(color: Colors.white, fontSize: 16)),
              Text("12/27", style: TextStyle(color: Colors.white, fontSize: 16)),
            ],
          ),
        ],
      ),
    );
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
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 8,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.blue, size: 26),
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
          ],
        ),
      ),
    );
  }
}
