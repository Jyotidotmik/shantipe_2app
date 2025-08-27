import 'package:flutter/material.dart';
import 'package:shantipe_2app/Utils/Custom_AppBar.dart';

import 'MPIN_Screen.dart';
import 'Widget/Bank_CardWidgwet.dart';

class TransferToBankScreen extends StatefulWidget {
  final Map<String, dynamic> beneficiary; // 👉 Beneficiary details receive करेंगे

  const TransferToBankScreen({super.key, required this.beneficiary});

  @override
  State<TransferToBankScreen> createState() => _TransferToBankScreenState();
}

class _TransferToBankScreenState extends State<TransferToBankScreen> {
  String _transferMethod = "IMPS"; // Default selected method

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final beneficiary = widget.beneficiary; // 👉 Beneficiary details यहाँ मिलेंगी

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(titleText: "Transfer to Bank"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Wallet Section
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Radio(
                          value: "wallet",
                          groupValue: "wallet",
                          onChanged: (_) {},
                        ),
                        const Text(
                          "Virtual Balance ",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        const Text(
                          "Available Balance: ₹56",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      initialValue: "56",
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.currency_rupee),
                        labelText: "Enter Amount",
                        filled: true,
                        fillColor: Colors.blue.withOpacity(0.05),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Transfer Method Selection
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Radio<String>(
                      value: "IMPS",
                      groupValue: _transferMethod,
                      onChanged: (value) {
                        setState(() {
                          _transferMethod = value!;
                        });
                      },
                    ),
                    const Text("IMPS",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    const Spacer(),
                    Radio<String>(
                      value: "NEFT",
                      groupValue: _transferMethod,
                      onChanged: (value) {
                        setState(() {
                          _transferMethod = value!;
                        });
                      },
                    ),
                    const Text("NEFT",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 15),
            // Bank Account Section
            const Text(
              "Bank Account Details",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            /// ✅ Beneficiary Card (selected beneficiary details दिखेगा)
            BeneficiaryCard(
              name: beneficiary['name'] as String,
              bankName: beneficiary['bank'] as String,
              ifscCode: beneficiary['ifsc'] as String,
              account: beneficiary['account'] as String,
              logo: beneficiary['logo'] as String,
              onDelete: () {
                // delete logic डालना है तो यहाँ लिखो
              },
              onSend: () {
                // यहां से next process screen पर भेज सकते हो
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MpinScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),

      // Transfer Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: size.width,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>  MpinScreen()));

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Selected Method: $_transferMethod")),
              );
            },
            child: Text(
              "TRANSFER ($_transferMethod)",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
