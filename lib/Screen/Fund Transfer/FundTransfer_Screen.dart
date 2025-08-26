import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Utils/Custom_AppBar.dart';
import 'Add_Beneficiary.dart';
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

  // Alternative method using direct navigation
  void _addNewBeneficiary() async {
    print("Opening AddBeneficiary screen...");
    final prefs = await SharedPreferences.getInstance();
    // Try direct navigation first
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AddBeneficiary(),
      ),
    );
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
 Future<void> _saveBeneficiaries() async {
    final prefs = await SharedPreferences.getInstance();
    final data = _beneficiaries.map((e) => json.encode(e)).toList();
    await prefs.setStringList("beneficiaries", data);
  }
  @override
  Widget build(BuildContext context) {
    final progress = (FundtransferScreen.score - FundtransferScreen.minLimit) / (FundtransferScreen.maxLimit - FundtransferScreen.minLimit);
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
                    mainAxisSize: MainAxisSize.min, //  Compact card
                    children: [
                      // Top row
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                _showSenderPopup(context);
                                debugPrint("Sender Details tapped");
                              },
                              child: const Text(
                                "Sender Details",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ),
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
                                (FundtransferScreen.minLimit + (FundtransferScreen.maxLimit - FundtransferScreen.minLimit) * value)
                                    .round(),
                            progress: value,
                            min: FundtransferScreen.minLimit,
                            max: FundtransferScreen.maxLimit,
                          );
                        },
                      ),
                      // Bottom info
                      Row(
                        children: const [
                          Expanded(
                            child: _InfoBlock(
                              label: "Name",
                              value: "Rohit Sharma",
                              alignEnd: false,
                            ),
                          ),
                          Expanded(
                            child: _InfoBlock(
                              label: "Mobile Number",
                              value: "8398966868",
                              alignEnd: true,
                            ),
                          ),
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
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                // Beneficiaries List
                GestureDetector(
                  onTap: () => Get.toNamed('/pin_screen'),
                  child: ListView.builder(
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
                          _sendMoneyToBeneficiary(beneficiary);
                        },
                      );
                    },
                  ),
                ),
              ],
              const SizedBox(height: 300),
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
          content: Text('Are you sure you want to delete ${_beneficiaries[index]['name']}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _beneficiaries.removeAt(index);
                });
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

  //--------------------------------Money Transfer Beneficiary--------------------------
  void _sendMoneyToBeneficiary(Map<String, dynamic> beneficiary) {
    final TextEditingController amountController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        // title: const Text('Send Money'),
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
          // TextButton(
          //   onPressed: () => Navigator.pop(context),
          //   child: const Text('Cancel'),
          // ),
          ElevatedButton(
           onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          SizedBox(width: 80,),
          ElevatedButton(
            onPressed: () {
              if (amountController.text.isNotEmpty) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('₹${amountController.text} sent to ${beneficiary['name']}'),
                    backgroundColor: Colors.blue,
                    duration: const Duration(seconds: 2),
                  ),
                );
              }
            },
            child: const Text('Sends.  '),
          ),
        ],
      ),
    );
  }

  //-------------------------Sender Details popup---------------------------------
  void _showSenderPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(20),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 6,
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
                                Icon(
                                  Icons.phone,
                                  size: 16,
                                  color: Colors.green,
                                ),
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
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context); // close popup
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => const fundTransferRegister(
                                    mobile: '',
                                    contactKeyEncoded: '',
                                    fromScreen: '',
                                  ),
                            ),
                          );
                        },
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.grey,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(
                                Icons.arrow_right,
                                size: 25,
                                color: Colors.black,
                              ),
                            ],
                          ),
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
                ],
              ),
            ),
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

class _InfoBlock extends StatelessWidget {
  final String label;
  final String value;
  final bool alignEnd;

  const _InfoBlock({
    required this.label,
    required this.value,
    required this.alignEnd,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          alignEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Colors.black54),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}