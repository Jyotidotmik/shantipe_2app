import 'package:flutter/material.dart';

import '../../../Utils/Custom_AppBar.dart';

class CdmPending extends StatelessWidget {
  const CdmPending({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // screen size
    return Scaffold(
      backgroundColor: Colors.white,
       appBar: CustomAppBar(
        titleText: "CDM Card Pending",
        onBackPress: () {
          Navigator.pop(context);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Top Illustration
              Flexible(
                flex: 4,
                child: Image.asset(
                  "lib/assets/images/pendings.png", 
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 30),
              // Title
              const Text(
                "CDM Card Pending",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              // Description
              const Text(
                "Begin by inserting your debit card into the designated slot on the CDM. "
                "CDMs offer 24/7 access, allowing you to deposit cash anytime, anywhere. "
                "Some CDMs may have transaction limits, and it's important to update your PAN details with the bank if you plan to deposit amounts exceeding certain limits.",
                textAlign: TextAlign.justify, //  This will justify the text
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.5,
                  color: Colors.black54,
                ),
              ),
        
              const SizedBox(height: 80),
              // Learn More Button
              SizedBox(
                width: size.width * 0.6,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    side: const BorderSide(color: Color(0xff3B82F6)),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "CDM Pending",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff3B82F6),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
