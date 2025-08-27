import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Utils/Custom_AppBar.dart';
import 'Add_Beneficiary.dart';
import 'Payment_Screen.dart';
import 'Register_Screen.dart';
import 'Widget/Bank_CardWidgwet.dart';

class FundtransferScreen extends StatefulWidget {
  const FundtransferScreen({super.key});

  static const int minLimit = 300;
  static const int maxLimit = 900;
  static const int score = 573;

  @override
  State<FundtransferScreen> createState() => _FundtransferScreenState();
}

class _FundtransferScreenState extends State<FundtransferScreen> {
  final List<Map<String, dynamic>> _beneficiaries = [];

  @override
  void initState() {
    super.initState();
    _loadBeneficiaries();
  }

  // Load beneficiaries from SharedPreferences
  Future<void> _loadBeneficiaries() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList("beneficiaries") ?? [];
    setState(() {
      _beneficiaries.clear();
      for (final item in data) {
        _beneficiaries.add(json.decode(item));
      }
    });
  }

  // Save beneficiaries to SharedPreferences
  Future<void> _saveBeneficiaries() async {
    final prefs = await SharedPreferences.getInstance();
    final data = _beneficiaries.map((e) => json.encode(e)).toList();
    await prefs.setStringList("beneficiaries", data);
  }

  // Add new beneficiary method
  void _addNewBeneficiary() async {
    print("Opening AddBeneficiary screen...");
    final result = await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const AddBeneficiary()));
    print("Received result: $result");
    if (result != null) {
      print("Adding beneficiary to list...");
      setState(() {
        final beneficiaryMap = Map<String, dynamic>.from(result as Map);
        _beneficiaries.add(beneficiaryMap);
      });
      await _saveBeneficiaries();

      print("Total beneficiaries: ${_beneficiaries.length}");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${result['name']} added successfully!'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  // Show beneficiary details popup from bottom
  void _showBeneficiaryDetails(Map<String, dynamic> beneficiary) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Draggable handle
              Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(height: 15),

              // Header with close button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Beneficiary Details',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Profile section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.blue.shade100,
                      child: Text(
                        beneficiary['name']
                            .toString()
                            .substring(0, 1)
                            .toUpperCase(),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      beneficiary['name'] ?? 'Unknown',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Bank details
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailRow(
                      icon: Icons.account_balance,
                      label: 'Bank Name',
                      value: beneficiary['bank'] ?? 'Not specified',
                    ),
                    const SizedBox(height: 12),
                    _buildDetailRow(
                      icon: Icons.credit_card,
                      label: 'Account Number',
                      value: beneficiary['account'] ?? 'Not specified',
                    ),
                    const SizedBox(height: 12),
                    _buildDetailRow(
                      icon: Icons.code,
                      label: 'IFSC Code',
                      value: beneficiary['ifsc'] ?? 'Not specified',
                    ),
                    const SizedBox(height: 12),
                    _buildDetailRow(
                      icon: Icons.category,
                      label: 'Account Type',
                      value: 'Savings',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        _editBeneficiary(beneficiary);
                      },
                      icon: const Icon(Icons.edit),
                      label: const Text('Edit'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        _sendMoneyToBeneficiary(beneficiary);
                      },
                      icon: const Icon(Icons.send, color: Colors.white),
                      label: const Text(
                        'Send Money',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ), // Bottom padding for better appearance
            ],
          ),
        );
      },
    );
  }

  // Helper method to build detail rows
  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.blue),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Edit beneficiary method
  void _editBeneficiary(Map<String, dynamic> beneficiary) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Edit Beneficiary'),
            content: const Text('Edit functionality will be implemented here'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final progress =
        (FundtransferScreen.score - FundtransferScreen.minLimit) /
        (FundtransferScreen.maxLimit - FundtransferScreen.minLimit);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        titleText: "",
        onBackPress: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Sender Card (Top aligned)
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Top row
                      Row(
                        children: const [
                          Icon(Icons.report, color: Colors.blue,),
                          Spacer(),
                          const Icon(
                            Icons.power_settings_new_outlined,
                            color: Colors.red,
                          ),
                        ],
                      ),
                      // Gauge (smaller)
                      TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0, end: progress),
                        duration: const Duration(milliseconds: 1500),
                        curve: Curves.easeOut,
                        builder: (context, value, _) {
                          return _GaugeWidget(
                            value:
                                (FundtransferScreen.minLimit +
                                        (FundtransferScreen.maxLimit -
                                                FundtransferScreen.minLimit) *
                                            value)
                                    .round(),
                            progress: value,
                            min: FundtransferScreen.minLimit,
                            max: FundtransferScreen.maxLimit,
                          );
                        },
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                _showSenderPopup(
                                  context,
                                ); // This will show the bottom sheet
                                debugPrint("Sender Details tapped");
                              },
                              child: const Text(
                                "Rohit Sharma",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ),
                          const Text("Mobile Number"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10),
              // Show beneficiaries section only if there are beneficiaries
              if (_beneficiaries.isNotEmpty) ...[
                const Text(
                  "Your Beneficiaries",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _beneficiaries.length,
                  itemBuilder: (context, index) {
                    final beneficiary = _beneficiaries[index];
                    return BeneficiaryCard(
                      name: beneficiary['name'] as String,
                      bankName: beneficiary['bank'] as String,
                      ifscCode: beneficiary['ifsc'] as String,
                      account: beneficiary['account'] as String,
                      logo: beneficiary['logo'] as String,
                      onDelete: () {
                        _deleteBeneficiary(index);
                      },
                      onSend: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => TransferToBankScreen(beneficiary: beneficiary),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
              const SizedBox(height: 20),
              // Add Beneficiary Button
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff0080FF),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: _addNewBeneficiary,
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'Add Beneficiary',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10), // Bottom padding
            ],
          ),
        ),
      ),
    );
  }

  //--------------------------- Delete Beneficiary--------------------------------
  void _deleteBeneficiary(int index) {
    // Show confirmation dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Beneficiary'),
          content: Text(
            'Are you sure you want to delete ${_beneficiaries[index]['name']}?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                setState(() {
                  _beneficiaries.removeAt(index);
                });
                await _saveBeneficiaries();
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Beneficiary deleted successfully'),
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  // //--------------------------------Money Transfer Beneficiary--------------------------
  void _sendMoneyToBeneficiary(Map<String, dynamic> beneficiary) {
    final TextEditingController amountController = TextEditingController();

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('To: ${beneficiary['name']}'),
                Text('Bank: ${beneficiary['bank']}'),
                Text("Ifsc code: ${beneficiary['ifsc']}"),
                Text('Account: ${beneficiary['account']}'),
                const SizedBox(height: 15),
                TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Enter Amount',
                    prefixIcon: Icon(Icons.currency_rupee),
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              const SizedBox(width: 80),
              ElevatedButton(
                onPressed: () {
                  if (amountController.text.isNotEmpty) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '₹${amountController.text} sent to ${beneficiary['name']}',
                        ),
                        backgroundColor: Colors.blue,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  }
                },
                child: const Text('Send'),
              ),
            ],
          ),
    );
  }

  //-------------------------Sender Details popup from bottom---------------------------------
  void _showSenderPopup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Draggable handle
              Center(
                child: Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // Header
              const Text(
                'Sender Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Profile + Name + KYC Button
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                      "https://i.pravatar.cc/150?img=3",
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Rohit Sharma",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) =>
                                                const fundTransferRegister(
                                                  mobile: '',
                                                  contactKeyEncoded: '',
                                                  fromScreen: '',
                                                ),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Do KYC?',
                                    style: TextStyle(
                                      color: Color(0xff0080FF),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(thickness: 1),
                        const SizedBox(height: 6),
                        const Text(
                          "8398966868",
                          style: TextStyle(fontSize: 16, color: Colors.black87),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          "221B Baker Street, London",
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: const [
                            Text(
                              "Total Limit: ",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(width: 15),
                            Text(
                              '25000',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: const [
                            Text(
                              "Remaining Limit: ",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(width: 15),
                            Text(
                              '23000',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
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
                    "Close",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}

class _GaugeWidget extends StatelessWidget {
  final int value;
  final double progress;
  final int min;
  final int max;

  const _GaugeWidget({
    required this.value,
    required this.progress,
    required this.min,
    required this.max,
  });

  @override
  Widget build(BuildContext context) {
    final band = value < 600 ? "TOTAL" : "GOOD";
    return SizedBox(
      width: 140,
      height: 140,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size.square(160),
            painter: _GaugePainter(progress),
          ),
          Container(
            width: 90,
            height: 90,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black87,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "$value",
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  band,
                  style: TextStyle(
                    fontSize: 12,
                    color: band == "BAD" ? Colors.red : Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GaugePainter extends CustomPainter {
  final double progress;
  _GaugePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2;

    final rect = Rect.fromCircle(center: center, radius: radius - 10);

    const startAngle = math.pi; // semi-circle
    const sweep = math.pi;

    // Background arc
    final bgPaint =
        Paint()
          ..color = Colors.grey.shade300
          ..style = PaintingStyle.stroke
          ..strokeWidth = 12
          ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, startAngle, sweep, false, bgPaint);

    // Progress arc
    final fgPaint =
        Paint()
          ..color = Colors.red
          ..style = PaintingStyle.stroke
          ..strokeWidth = 12
          ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, startAngle, sweep * progress, false, fgPaint);
  }

  @override
  bool shouldRepaint(covariant _GaugePainter oldDelegate) =>
      oldDelegate.progress != progress;
}
