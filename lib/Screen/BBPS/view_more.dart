import 'package:flutter/material.dart';
import 'package:shantipe_2app/Utils/Custom_AppBar.dart';

class ViewMore extends StatefulWidget {
  const ViewMore({super.key});

  @override
  State<ViewMore> createState() => _ViewMoreState();
}

class _ViewMoreState extends State<ViewMore> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> services = [
    {'icon': Icons.comment_bank_sharp, 'label': 'B2B'},
    {'icon': Icons.bakery_dining, 'label': 'Broadband Postpaid'},
    {'icon': Icons.speaker, 'label': 'Credit Card'},
    {'icon': Icons.speaker, 'label': 'Cable TV'},
    {'icon': Icons.electric_bolt, 'label': 'Clube and Associations'},
    {'icon': Icons.campaign, 'label': 'DTH'},
    {'icon': Icons.speaker, 'label': 'Electricity'},
    {'icon': Icons.campaign, 'label': 'Education Fees'},
    {'icon': Icons.speaker, 'label': 'FASTag'},
    {'icon': Icons.speaker, 'label': 'Gas'},
    {'icon': Icons.speaker, 'label': 'General Insurance'},
    {'icon': Icons.speaker, 'label': 'Health Insurance'},
    {'icon': Icons.speaker, 'label': 'Hospital and Pathalogy'},
    {'icon': Icons.speaker, 'label': 'Housing Society'},
    {'icon': Icons.speaker, 'label': 'Insurance'},
    {'icon': Icons.speaker, 'label': 'Life Insurance'},
    {'icon': Icons.speaker, 'label': 'Landline PostPaid'},
    {'icon': Icons.speaker, 'label': 'Loan repayment'},
    {'icon': Icons.speaker, 'label': 'LPG GAS'},
    {'icon': Icons.speaker, 'label': 'Mobile Postpaid'},
    {'icon': Icons.speaker, 'label': 'Mobile Prepaid'},
    {'icon': Icons.speaker, 'label': 'Municipal Service'},
    {'icon': Icons.speaker, 'label': 'Municipal Taxes'},
    {'icon': Icons.speaker, 'label': 'Mutual Fund'},
    {'icon': Icons.speaker, 'label': 'Recurring Deposit'},
    {'icon': Icons.speaker, 'label': 'Rental'},
    {'icon': Icons.speaker, 'label': 'Subscription'},
    {'icon': Icons.speaker, 'label': 'Subscription Fees(Digital)'},
    {'icon': Icons.speaker, 'label': 'Subscription Fees(Offline)'},
    {'icon': Icons.speaker, 'label': 'Water'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      appBar: CustomAppBar(
        titleText: "View More",
        onBackPress: () {
          print("Custom back pressed");
          Navigator.pop(context);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
           Row(
  children: [
    Expanded(
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
    ),
    SizedBox(width: 5),
    GestureDetector(
      onTap: () {
        _searchController.clear();
      },
      child: Text(
        "Cancel",
        style: TextStyle(
          fontSize: 18,
          color: Colors.grey,
          fontWeight: FontWeight.w500,
        ),
      ),
        ),
          ],
           ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: services.length,
                itemBuilder: (context, index) {
                  final item = services[index];
                  return _buildQuickLink(
                    context,
                    item['icon'],
                    item['label'],
                    () => _onTap(context, item['label']),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

Widget _buildQuickLink(BuildContext context, IconData icon, String label, VoidCallback callback) {
  return GestureDetector(
    onTap: () {
      _onTap(context, label);
      callback();
    },
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Container(
          //   width: 45,
          //   height: 45,
          //   decoration: const BoxDecoration(
          //     gradient: LinearGradient(
          //       colors: [Color.fromARGB(255, 250, 250, 250), Color.fromARGB(255, 252, 251, 251)],
          //       begin: Alignment.topCenter,
          //       end: Alignment.bottomCenter,
          //     ),
          //     borderRadius: BorderRadius.all(Radius.circular(10)),
          //   ),
          //   child: Icon(icon, color: Colors.blue, size: 25),
          // ),
          Icon(icon, color: Colors.blue, size: 35),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

  void _onTap(BuildContext context, String label) {
    print('Tapped on $label at ${DateTime.now()}');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('You tapped $label')),
    );
  }
}
