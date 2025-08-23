import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../Utils/Custom_AppBar.dart';

class BankCard extends StatelessWidget {
  final String bankName;
  final String accountNumber;
  final String companyName;
  final String ifsc;
  final Color bgColor;
  final String logoPath; // Bank Logo
  final String? companyLogo; // Company Logo (optional)
  final bool isSelected;
  final VoidCallback onTap;

  const BankCard({
    super.key,
    required this.bankName,
    required this.accountNumber,
    required this.companyName,
    required this.ifsc,
    required this.bgColor,
    required this.logoPath,
    this.companyLogo,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: w * 0.73,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
          border: isSelected
              ? Border.all(color: Colors.yellow, width: 3)
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bank Logo + Name
            Row(
              children: [
                Image.asset(
                  logoPath,
                  height: 35,
                ),
                const Spacer(),
                Text(
                  bankName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Chip Icon + Account Number
            Row(
              children: [
                const Icon(Icons.sim_card, color: Colors.amber, size: 32),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    accountNumber,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text(
              companyName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "IFSC: $ifsc",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              if (companyLogo != null)
            SizedBox(
            height: MediaQuery.of(context).size.width * 0.2,
           width: MediaQuery.of(context).size.width * 0.2,
          child: Image.asset(
      companyLogo!,
      fit: BoxFit.contain,
    ),
  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BankCardDropdownScreen extends StatefulWidget {
  const BankCardDropdownScreen({super.key});

  @override
  State<BankCardDropdownScreen> createState() =>
      _BankCardDropdownScreenState();
}

class _BankCardDropdownScreenState extends State<BankCardDropdownScreen> {
  String? selectedBank;
  final TextEditingController amountController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController modeController = TextEditingController();
  final TextEditingController remarkController = TextEditingController();
  final TextEditingController utrController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  final List<Map<String, dynamic>> bankList = [
    {
      "name": "HDFC BANK",
      "account": "50200098624875",
      "company": "DotMik Software Private Limited",
      "ifsc": "HDFC0000438",
      "color": const Color.fromARGB(255, 103, 129, 124),
      "logo": "lib/assets/images/hdfc.png",
      "companyLogo": "lib/assets/images/dotmik.png"
    },
    {
      "name": "AXIS BANK",
      "account": "924020032231897",
      "company": "DotMik Software Private Limited",
      "ifsc": "UTIB0000360",
      "color": const Color.fromARGB(255, 233, 185, 241),
      "logo": "lib/assets/images/axis.png",
      "companyLogo": "lib/assets/images/dotmik.png"
    }
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }
//   void _showThankYouDialog(BuildContext context) {
//   showDialog(
//     context: context,
//     barrierDismissible: false, //  user background tap karke close na kare
//     builder: (BuildContext context) {
//       return AlertDialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//         ),
//         title: const Text(
//           "Thank You 🎉",
//           textAlign: TextAlign.center,
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         content: const Text(
//           "Your fund transfer request has been submitted successfully.",
//           textAlign: TextAlign.center,
//         ),
//         actions: [
//           Center(
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.blue,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//               ),
//               onPressed: () {
//                 Navigator.pop(context); //  close dialog
//                 Navigator.pop(context); // back to previous screen
//               },
//               child: const Text("OK", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.white),),
//             ),
//           ),
//         ],
//       );
//     },
//   );
// }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(
        titleText: "Fund Request",
        onBackPress: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: Colors.white,
     body: Padding(
  padding: const EdgeInsets.all(16.0),
  child: SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        //  Cards (only selected one remains visible)
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: bankList.length,
          itemBuilder: (context, index) {
            final bank = bankList[index];
            if (selectedBank != null && selectedBank != bank["name"]) {
              return const SizedBox.shrink();
            }
            return BankCard(
              bankName: bank["name"],
              accountNumber: bank["account"],
              companyName: bank["company"],
              ifsc: bank["ifsc"],
              bgColor: bank["color"],
              logoPath: bank["logo"],
              companyLogo: bank["companyLogo"],
              isSelected: selectedBank == bank["name"],
              onTap: () {
                setState(() {
                  selectedBank = bank["name"];
                });
              },
            );
          },
        ),
        const SizedBox(height: 16),
        // Form tabhi dikhe jab ek card select ho
        if (selectedBank != null) ...[
          _buildTextField(
            'Amount',
            amountController,
            keyboardType: TextInputType.number,
            hintText: 'Enter amount',
          ),
          const SizedBox(height: 16),
          _buildDateField(
            'Date',
            dateController,
            () => _selectDate(context),
          ),
          const SizedBox(height: 16),
          _buildModeField('Mode'),
          const SizedBox(height: 16),
          _buildTextField(
            'UTR',
            utrController,
            keyboardType: TextInputType.number,
            hintText: 'Enter UTR number',
          ),
          const SizedBox(height: 16),
          _buildTextField(
            'Remark',
            remarkController,
            maxLength: 40,
            hintText: 'Enter any remarks',
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: size.height * 0.06,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed:() => Get.toNamed('/payment_send'),
               //{
            
                  //_showThankYouDialog(context); //  Popup open karega
                //},
              child: const Text(
                "Submit Request",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ],
    ),
  ),
),
);
}

//-------------------Text Field---------------------
  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    int? maxLines,
    int? maxLength,
    TextInputType? keyboardType,
    String? hintText,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
      ),
      maxLines: maxLines ?? 1,
      maxLength: maxLength,
      keyboardType: keyboardType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

  //----------------- Date Field---------------------
  Widget _buildDateField(
    String label,
    TextEditingController controller,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: AbsorbPointer(
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            hintText: 'Select date',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
          ),
           validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select $label';
            }
            return null;
          },
        ),
      ),
    );
  }

//---------------------Mode Field-----------------------
Widget _buildModeField(String label) {
  return DropdownButtonHideUnderline(
    child: DropdownButton2<String>(
      isExpanded: true,
      hint: const Text(
        "Select",
        style: TextStyle(fontSize: 16),
      ),
      items: ['IMPS', 'NEFT', 'RTGS', 'CASH', 'CDM', 'UPI']
          .map((mode) => DropdownMenuItem<String>(
                value: mode,
                child: Text(
                  mode,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ))
          .toList(),
      value: modeController.text.isEmpty ? null : modeController.text,
      onChanged: (value) {
        setState(() {
          modeController.text = value ?? '';
        });
      },

      //  Button (dropdown field) ka style
      buttonStyleData: ButtonStyleData(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black54),
          color: Colors.white,
        ),
      ),

      //  Dropdown list ka style
      dropdownStyleData: DropdownStyleData(
        maxHeight: 250,
        width: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black26),
          color: Colors.white,
        ),
        offset: const Offset(0, -2), // box ke niche open hoga
      ),

      //  Icon (arrow) ka style
      iconStyleData: const IconStyleData(
        icon: Icon(Icons.keyboard_arrow_down),
        iconSize: 24,
        iconEnabledColor: Colors.black,
      ),
    ),
  );
}

}
