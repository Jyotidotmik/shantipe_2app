import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String bankName;
  final String logo;
  final String name;
  final String account;
  final String ifscCode;
  final String amount;
  final String mode;

  const CardWidget({
    super.key,
    required this.bankName,
    required this.logo,
    required this.name,
    required this.account,
    required this.ifscCode,
    required this.amount,
    required this.mode,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Bank Logo + Bank Name
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: logo.isNotEmpty ? NetworkImage(logo) : null,
                  child: logo.isEmpty
                      ? const Icon(Icons.account_balance, size: 28)
                      : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    bankName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Account Holder Name
            Row(
              children: [
                const Icon(Icons.person, size: 18, color: Colors.blueGrey),
                const SizedBox(width: 12),
                Text(
                  "Name: $name",
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 6),
            // Account Number
            Row(
              children: [
                const Icon(Icons.credit_card, size: 18, color: Colors.blueGrey),
                const SizedBox(width: 12),
                Text(
                  "A/C No: $account",
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 6),
            // Amount
            Row(
              children: [
                const Icon(Icons.currency_rupee,
                    size: 18, color: Colors.green),
                const SizedBox(width: 12),
                Text(
                  "Amount: ₹$amount",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    // color: Colors.green,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 6),

            // Mode
            Row(
              children: [
                const Icon(Icons.swap_horiz, size: 18, color: Colors.blue),
                const SizedBox(width: 12),
                Text(
                  "Mode: $mode",
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
