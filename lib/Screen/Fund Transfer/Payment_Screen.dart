import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shantipe_2app/Utils/Custom_AppBar.dart';

class TransferToBankScreen extends StatefulWidget {
  const TransferToBankScreen({super.key});

  @override
  State<TransferToBankScreen> createState() => _TransferToBankScreenState();
}

class _TransferToBankScreenState extends State<TransferToBankScreen> {
  String _transferMethod = "IMPS"; // Default selected method

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(titleText: ""),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Wallet to Wallet
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
                          "Wallet to Wallet ",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "Available Balance: ₹56",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
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

            // Investment Account with IMPS/UPI radio buttons
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
                    const Text("IMPS"),
                    const Spacer(),
                    Radio<String>(
                      value: "UPI",
                      groupValue: _transferMethod,
                      onChanged: (value) {
                        setState(() {
                          _transferMethod = value!;
                        });
                      },
                    ),
                    const Text("UPI"),
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
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Name",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "LALIT YADAV",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Expanded(
                          child: Text(
                            "Bank (IFSC: HDFC0000438)\nHDFC BANK",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Text(
                          "xx113032",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
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
              _showSenderPopup(context);
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

  //-------------------------Sender Details popup---------------------------------
  void _showSenderPopup(BuildContext context) {
    final TextEditingController _otpController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        bool isLoading = false;
        String? statusMessage;
        bool isSuccessMessage = false;
        Timer? messageTimer;
        return Dialog(
          insetPadding: const EdgeInsets.all(20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile + Name + KYC Button Row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Rohit Sharma",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: const [
                              Icon(Icons.phone, size: 16, color: Colors.green),
                              SizedBox(width: 6),
                              Text(
                                "8398966868",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Icon(
                                Icons.location_on,
                                size: 16,
                                color: Colors.red,
                              ),
                              SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  "221B Baker Street, London",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          PinCodeTextField(
                            controller: _otpController,
                            appContext: context,
                            length: 4,
                            keyboardType: TextInputType.number,
                            animationDuration: const Duration(
                              milliseconds: 200,
                            ),
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(12),
                              fieldHeight: 50,
                              fieldWidth: 50,
                              activeColor: Colors.black,
                              inactiveColor: Colors.black26,
                              selectedColor: Colors.black,
                              activeFillColor: Colors.white,
                              inactiveFillColor: Colors.white,
                              selectedFillColor: Colors.white,
                            ),
                            onChanged: (value) {
                              if (statusMessage != null) {
                                setState(() => statusMessage = null);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Close Button
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Submit",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
