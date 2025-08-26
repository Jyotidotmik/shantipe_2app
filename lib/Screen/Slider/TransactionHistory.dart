import 'package:flutter/material.dart';
import 'package:shantipe_2app/Utils/Custom_AppBar.dart';

class PaymentHistoryScreen extends StatefulWidget {
  const PaymentHistoryScreen({Key? key}) : super(key: key);

  @override
  State<PaymentHistoryScreen> createState() => _PaymentHistoryScreenState();
}

class _PaymentHistoryScreenState extends State<PaymentHistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> history = [
    {
      "month": "October",
      "date": "30/10/2019",
      "status": "Unsuccessfully",
      "success": false,
      "amount": "\$480"
    },
    {
      "month": "September",
      "date": "30/09/2019",
      "status": "Successfully",
      "success": true,
      "amount": "\$480"
    },
    {
      "month": "August",
      "date": "30/08/2019",
      "status": "Successfully",
      "success": true,
      "amount": "\$480"
    },
    {
      "month": "July",
      "date": "30/07/2019",
      "status": "Successfully",
      "success": true,
      "amount": "\$480"
    },
    {
      "month": "June",
      "date": "30/06/2019",
      "status": "Successfully",
      "success": true,
      "amount": "\$480"
    },
    {
      "month": "May",
      "date": "30/05/2019",
      "status": "Successfully",
      "success": true,
      "amount": "\$480"
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(titleText: 'Payment History'),
      body: Column(
        children: [
          // TabBar section
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: const Color(0xFF3D2EFF), // Purple selected bg
                borderRadius: BorderRadius.circular(30),
              ),
              // labelColor: Colors.white, // selected text
              unselectedLabelColor: Colors.black87,
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              tabs: [
                _buildTab("Electric"),
                _buildTab("Water"),
                _buildTab("Mobile"),
              ],
            ),
          ),

          //  Expanded TabBarView
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildHistoryList(size),
                _buildHistoryList(size),
                _buildHistoryList(size),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Custom Tab style
  Widget _buildTab(String text) {
    return Container(
      height: 36,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
       border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // History List UI
  Widget _buildHistoryList(Size size) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: history.length,
      itemBuilder: (context, index) {
        final item = history[index];
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left side: month + status
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item["month"],
                    style: TextStyle(
                      fontSize: size.width * 0.045,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Status: ${item["status"]}",
                    style: TextStyle(
                      color: item["success"] ? Colors.green : Colors.red,
                      fontSize: size.width * 0.035,
                    ),
                  ),
                ],
              ),

              // Right side: date + amount
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    item["date"],
                    style: TextStyle(
                      fontSize: size.width * 0.033,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Amount ${item["amount"]}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: size.width * 0.038,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
