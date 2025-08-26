import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For input formatters
import 'package:get/get.dart';
import 'package:shantipe_2app/Utils/Custom_AppBar.dart'; // Add GetX import

class AddBeneficiary extends StatefulWidget {
  const AddBeneficiary({Key? key}) : super(key: key);

  @override
  _AddBeneficiaryState createState() => _AddBeneficiaryState();
}

class _AddBeneficiaryState extends State<AddBeneficiary> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool _isVerified = false;

  // Dummy bank list
  final List<Map<String, String>> _banks = [
    {
      "name": "UNITY BANK",
      "logo": "https://img.icons8.com/color/48/bank-building.png",
    },
    {
      "name": "STATE BANK OF INDIA",
      "logo": "https://img.icons8.com/color/48/state-bank-of-india.png",
    },
    {
      "name": "BANK OF BARODA",
      "logo": "https://img.icons8.com/color/48/bank.png",
    },
    {
      "name": "BANK OF INDIA",
      "logo": "https://img.icons8.com/color/48/bank-building.png",
    },
    {
      "name": "ICICI BANK",
      "logo": "https://img.icons8.com/color/48/bank-cards.png",
    },
    {
      "name": "HDFC BANK",
      "logo": "https://img.icons8.com/color/48/bank-building.png",
    },
    {
      "name": "KOTAK MAHINDRA BANK",
      "logo": "https://img.icons8.com/color/48/bank-building.png",
    },
    {
      "name": "PUNJAB NATIONAL BANK",
      "logo": "https://img.icons8.com/color/48/bank.png",
    },
    {
      "name": "UNION BANK OF INDIA",
      "logo": "https://img.icons8.com/color/48/bank-building.png",
    },
    {
      "name": "AXIS BANK",
      "logo": "https://img.icons8.com/color/48/bank-building.png",
    },
    {
      "name": "CENTRAL BANK OF INDIA",
      "logo": "https://img.icons8.com/color/48/bank-building.png",
    },
  ];

  List<Map<String, String>> _filteredBanks = [];

  @override
  void initState() {
    super.initState();
    _filteredBanks = _banks;
    _nameController.addListener(_verifyName);
  }

  void _verifyName() {
    String name = _nameController.text.trim();
    setState(() {
      _isVerified = name.length >= 3 && RegExp(r"^[a-zA-Z\s]+$").hasMatch(name);
    });
  }

  void _filterBanks(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredBanks = _banks;
      } else {
        _filteredBanks =
            _banks
                .where(
                  (bank) =>
                      bank["name"]!.toLowerCase().contains(query.toLowerCase()),
                )
                .toList();
      }
    });
  }

  void _showBankDetails(BuildContext context, Map<String, String> bank) {
    final TextEditingController _ifscController = TextEditingController(
      text: "SBIN0000123",
    );
    final TextEditingController _accountController = TextEditingController();
    final TextEditingController _confirmController = TextEditingController();
    final TextEditingController _nameController = TextEditingController();

    // Form key for validation
    final _formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false, // Prevent dismissing by tapping outside
      enableDrag: false, // Prevent dismissing by dragging
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          expand: false,
          builder:
              (_, controller) => Container(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    controller: controller,
                    children: [
                      Center(
                        child: Container(
                          width: 50,
                          height: 4,
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(bank["logo"]!),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Text(
                              bank["name"]!,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          // Close button
                          IconButton(
                            onPressed:
                                () => Navigator.pop(
                                  context,
                                ), // Keep Navigator for bottom sheet
                            icon: const Icon(Icons.close),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Enter Bank Details",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Bank Name Field (read-only)
                      // TextFormField(
                      //   initialValue: bank["name"],
                      //   decoration: InputDecoration(
                      //     labelText: "Bank Name",
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //   ),
                      //   readOnly: true,
                      // ),
                      const SizedBox(height: 15),

                      // IFSC Code Field
                      TextFormField(
                        controller: _ifscController,
                        decoration: InputDecoration(
                          labelText: "IFSC Code",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z0-9]'),
                          ),
                          LengthLimitingTextInputFormatter(11),
                        ],
                        textCapitalization: TextCapitalization.characters,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter IFSC code';
                          }
                          if (value.length != 11) {
                            return 'IFSC code must be 11 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),

                      // Account Number Field
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _accountController,
                        decoration: InputDecoration(
                          labelText: "Account Number",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter account number';
                          }
                          if (value.length < 9 || value.length > 14) {
                            return 'Account number must be between 9-14 digits';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      // Account Number Field
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _confirmController,
                        decoration: InputDecoration(
                          labelText: " Confirm Account Number",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter account number';
                          }
                          if (value.length < 9 || value.length > 14) {
                            return 'Account number must be between 9-14 digits';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      // Beneficiary Name Field
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: "Beneficiary Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffixIcon:
                              _nameController.text.isEmpty
                                  ? null
                                  : (_isVerified
                                      ? const Icon(
                                        Icons.verified,
                                        color: Colors.green,
                                      )
                                      : const Icon(
                                        Icons.error_outline,
                                        color: Colors.red,
                                      )),
                        ),
                        textCapitalization: TextCapitalization.words,
                        onChanged: (value) {
                          // Real-time verification logic
                          setState(() {
                            if (value.trim().length >= 3 &&
                                RegExp(r"^[a-zA-Z\s]+$").hasMatch(value)) {
                              _isVerified = true; // valid name
                            } else {
                              _isVerified = false; // invalid name
                            }
                          });
                        },
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter beneficiary name';
                          }

                          if (!RegExp(
                            r"^[a-zA-Z\s]+$",
                          ).hasMatch(value.trim())) {
                            return 'Name can only contain letters';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 40),
                      // Submit Button
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff0080FF),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 90,
                              vertical: 14,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () {
                            // Validate form
                            if (_formKey.currentState!.validate()) {
                              // Create beneficiary object
                              final newBeneficiary = {
                                "name": _nameController.text.trim(),
                                "bank": bank["name"]!,
                                "account": _accountController.text.trim(),
                                "logo": bank["logo"]!,
                                "ifsc": _ifscController.text.trim(),
                              };
                              // Debug print to check data
                              print(
                                "Returning beneficiary data: $newBeneficiary",
                              );
                              Navigator.pop(context);
                              Get.back(result: newBeneficiary);
                            }
                          },
                          child: const Text(
                            'Submit',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(titleText: ""),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: _searchController,
              onChanged: _filterBanks,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: "Search Bank",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
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
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.blue,
                  ),
                  onTap: () {
                    _showBankDetails(context, bank);
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
