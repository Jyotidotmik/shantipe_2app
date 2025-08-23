import 'package:flutter/material.dart';

class AddBeneficiary extends StatefulWidget {
  const AddBeneficiary({Key? key}) : super(key: key);

  @override
  _AddBeneficiaryState createState() => _AddBeneficiaryState();
}

class _AddBeneficiaryState extends State<AddBeneficiary> {
  final TextEditingController _searchController = TextEditingController();

  // Dummy bank list
  final List<Map<String, String>> _banks = [
    {"name": "UNITY BANK", "logo": "https://img.icons8.com/color/48/bank-building.png"},
    {"name": "STATE BANK OF INDIA", "logo": "https://img.icons8.com/color/48/state-bank-of-india.png"},
    {"name": "BANK OF BARODA", "logo": "https://img.icons8.com/color/48/bank.png"},
    {"name": "BANK OF INDIA", "logo": "https://img.icons8.com/color/48/bank-building.png"},
    {"name": "ICICI BANK", "logo": "https://img.icons8.com/color/48/bank-cards.png"},
    {"name": "HDFC BANK", "logo": "https://img.icons8.com/color/48/bank-building.png"},
    {"name": "KOTAK MAHINDRA BANK", "logo": "https://img.icons8.com/color/48/bank-building.png"},
    {"name": "PUNJAB NATIONAL BANK", "logo": "https://img.icons8.com/color/48/bank.png"},
    {"name": "UNION BANK OF INDIA", "logo": "https://img.icons8.com/color/48/bank-building.png"},
    {"name": "AXIS BANK", "logo": "https://img.icons8.com/color/48/bank-building.png"},
    {"name": "CENTRAL BANK OF INDIA", "logo": "https://img.icons8.com/color/48/bank-building.png"},
  ];

  List<Map<String, String>> _filteredBanks = [];

  @override
  void initState() {
    super.initState();
    _filteredBanks = _banks;
  }

  void _filterBanks(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredBanks = _banks;
      } else {
        _filteredBanks = _banks
            .where((bank) => bank["name"]!
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Select Bank",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              onChanged: _filterBanks,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: "Search Bank",
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // Bank List
          Expanded(
            child: ListView.separated(
              itemCount: _filteredBanks.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final bank = _filteredBanks[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey.shade100,
                    backgroundImage: NetworkImage(bank["logo"]!),
                  ),
                  title: Text(
                    bank["name"]!,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios,
                      size: 16, color: Colors.blue),
                  onTap: () {
                    // Select bank action
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Selected: ${bank["name"]}")),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
