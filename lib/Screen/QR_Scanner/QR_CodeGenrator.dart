import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upi_payment_qrcode_generator/upi_payment_qrcode_generator.dart';

class QrPaymentScreen extends StatelessWidget {
  QrPaymentScreen({super.key});

  final upiDetails = UPIDetails(
    upiID: "9167877725@axl",
    payeeName: "Agnel Selvan",
    amount: 1,
    transactionNote: "Hello World",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            // Top Bar
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 10,
                left: 8,
                right: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.download,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.more_vert,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // QR Card
            Center(
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Profile Row (Image + Name)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircleAvatar(
                            radius: 23,
                            backgroundImage: AssetImage('assets/profile.jpg'),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            upiDetails.payeeName, // yahan variable use hoga
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // QR Code + center logo in circle
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          UPIPaymentQRCode(
                            upiDetails: upiDetails,
                            size: 210,
                            upiQRErrorCorrectLevel: UPIQRErrorCorrectLevel.high,
                          ),
                          // Image.asset(
                          //   'lib/assets/images/logo.png',
                          //   height: 70,width: 70,
                          //   fit: BoxFit.contain,
                          // ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // UPI ID
                      Text(
                        'UPI ID: ${upiDetails.upiID}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Instruction
                      const Text(
                        'Scan to pay with any UPI app',
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 60),
            // Bottom buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton.icon(
                  icon: const Icon(Icons.qr_code, color: Colors.blue),
                  label: const Text(
                    " Open scanner ",
                    style: TextStyle(color: Colors.blue),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.blue),
                  ),
                  onPressed: () => Get.toNamed('/qr_scanner'),
                ),
                OutlinedButton.icon(
                  icon: const Icon(Icons.share, color: Colors.blue),
                  label: const Text(
                    "Share QR code",
                    style: TextStyle(color: Colors.blue),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.blue),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
