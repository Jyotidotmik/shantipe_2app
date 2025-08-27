import 'package:flutter/material.dart';

class BeneficiaryCard extends StatelessWidget {
  final String name;
  final String bankName;
  final String ifscCode;
  final String account;
  final String logo;
  final VoidCallback onDelete;
  final VoidCallback onSend;

  const BeneficiaryCard({
    super.key,
    required this.name,
    required this.bankName,
    required this.ifscCode,
    required this.account,
    required this.logo,
    required this.onDelete,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(logo),
        ),
        title: Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Bank: $bankName"),
            Text("A/c: $account"),
            Text("IFSC: $ifscCode"), // ✅ अब IFSC भी दिखेगा
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
        onTap: onSend, // ✅ Card पर tap → सीधे payment पर जाएगा
      ),
    );
  }
}
