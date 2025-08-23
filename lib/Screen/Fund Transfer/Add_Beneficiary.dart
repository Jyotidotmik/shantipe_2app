import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../Utils/Custom_AppBar.dart';
import '../../Utils/Custom_button.dart';
import 'Widget/Select_Bank_Dropdown.dart';

class AddBeneficiary extends StatefulWidget {
  final String contactKeyEncoded;
  AddBeneficiary({required this.contactKeyEncoded});
  @override
  _AddBeneficiaryState createState() => _AddBeneficiaryState();
}

class _AddBeneficiaryState extends State<AddBeneficiary> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bankId = TextEditingController();
  final TextEditingController accountController = TextEditingController();
  final TextEditingController cccountconfirm = TextEditingController();
  final TextEditingController ifscController = TextEditingController();
  final TextEditingController accountKey = TextEditingController();
  bool _isLoading = false;
  bool isVerified = false;

  // final DmtService dmtService = DmtService();
  // final FundTransferService fundTransferService = FundTransferService();

  String? selectedBank;
  List<Map<String, String>> banks = [];

  @override
  void initState() {
    super.initState();
    //_fetchBanks(widget.contactKeyEncoded);
  }

  // Future<void> _fetchBanks(String contactKeyEncoded) async {
  //   // bool isLoading = true;
  //   try {
  //     String contactId = "";
  //     try {
  //       if (contactKeyEncoded.isNotEmpty) {
  //         final decodedBytes = base64.decode(contactKeyEncoded);
  //         final decodedString = utf8.decode(decodedBytes);
  //         final Map<String, dynamic> data = json.decode(decodedString);
  //         contactId = data['contact_id'] ?? '';
  //       }
  //     } catch (e) {
  //       print('Error decoding contactKey: $e');
  //       contactId = '';
  //     }

  //     final response = await fundTransferService.fundTransferGetBankName();
  //     print('API Response: ${jsonEncode(response)}');

  //     if (response['status'] == 'SUCCESS' && response['data'] != null && response['data']['globalBankList'] is List) {
  //       final List<dynamic> bankList = response['data']['globalBankList'];

  //       if (bankList.isEmpty) throw Exception('Bank list is empty');

  //       setState(() {
  //         banks = bankList.map<Map<String, String>>((bank) {
  //           return {
  //             'id': (bank['id'] ?? '').toString(),
  //             'name': (bank['bank'] ?? '').toString(),
  //             'ifsc': (bank['ifsc'] ?? '').toString(),
  //             'accountKey': contactId,
  //           };
  //         }).toList();
  //       });

  //       print('Banks List~~~>: $banks');
  //     } else {
  //       throw Exception('Invalid API response or structure');
  //     }
  //   } catch (e) {
  //     print('Error fetching banks: $e');
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Failed to fetch banks: ${e.toString()}')),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: 'Register',
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  width: 351,
                  height: 33,
                  child: Text(
                    'Create New Account',
                    style: TextStyle(
                      color: Color(0xff000000),
                      fontSize: 22,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                _buildTextField(label: 'Name', hintText: 'Enter Beneficiary Name', keyboardType: TextInputType.text, controller: nameController),
                SizedBox(height: 20.0),
                _buildTextField(label: 'Account Number', hintText: 'Enter Account Number', keyboardType: TextInputType.number, controller: accountController),
                SizedBox(height: 20.0),
                banks.isEmpty
                    ? Center(child: CircularProgressIndicator()) // Spinner shown
                     : SelectBankDropdown(
                  label: 'Select Bank',
                  hintText: 'Choose a bank',
                  value: selectedBank,
                  items: banks.map((bank) => bank['name']!).toList(),
                 onChanged: (value) {
                          setState(() {
                            _isLoading = true;
                          });
                          setState(() {
                            selectedBank = value;
                            final selectedBankDetails = banks.firstWhere((bank) => bank['name'] == value);
                            ifscController.text = selectedBankDetails['ifsc']!;
                            bankId.text = selectedBankDetails['id']!;
                            accountKey.text = selectedBankDetails['accountKey']!;
                          });
                        },
                ),


                // Complete dropdown with onChanged
                SizedBox(height: 20.0),
                _buildTextField(label: 'IFSC Code', hintText: 'IFSC Code', keyboardType: TextInputType.text, controller: ifscController, isReadOnly: false),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 150,
                      height: 42,
                      child: CustomTextButton(
                        BorderRadius: BorderRadius.circular(5),
                        text: 'Submit',
                        onPressed: () async {
                          setState(() {
                            _isLoading = true;
                          });
                          print({
                            nameController,
                            accountController,
                            selectedBank,
                            bankId,
                            ifscController,
                            accountKey,
                          });
                          if (nameController.text.isEmpty || accountController.text.isEmpty || selectedBank == null || bankId.text.isEmpty || ifscController.text.isEmpty || accountKey.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Please fill all the fields')),
                            );
                            setState(() {
                              _isLoading = false;
                            });
                            return;
                          }

                          try {
                            // await fundTransferService.addBeneficiary(
                            //   bankname: bankId.text, // Make sure bankId contains the correct bank ID
                            //   ifsc: ifscController.text, // IFSC Code
                            //   account: accountController.text, // Account Number
                            //   accountConfirmation: accountController.text, // Account Confirmation
                            //   name: nameController.text, // User Name
                            //   accountKey: accountKey.text, // Account Key fetched from selected bank
                            //   isVerified: isVerified ? "1" : "0",
                            //   context: context, bankId: '',
                            // );
                            //_showBillDialog(context);
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error: $e')),
                            );
                          } finally {
                            setState(() {
                              _isLoading = false;
                            });
                          }
                        },
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      height: 42,
                      child: CustomTextButton(
                        BorderRadius: BorderRadius.circular(5),
                        text: 'Reset',
                        onPressed: () {
                          _resetForm();
                        },
                        color: Color.fromARGB(255, 229, 208, 20),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // if (_isLoading)
          //   Container(
          //     // color: Colors.black.withOpacity(0.3), // optional: darken background
          //     color: Color.fromRGBO(0, 0, 0, 0.3),
          //     child: const Center(
          //       child: CircularProgressIndicator(color: Colors.blue),
          //     ),
          //   ),
        ],
      ),
    );
  }

  void _showBillDialog(BuildContext context) {
    TextEditingController _otpController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: EdgeInsets.all(8.0),
          contentPadding: EdgeInsets.all(8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: Container(
            padding: const EdgeInsets.symmetric(vertical: 18),
            decoration: ShapeDecoration(
              color: Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Center(
              child: Text(
                'Enter OTP',
                style: TextStyle(
                  color: Color(0xFFC43F3E),
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          content: Container(
            width: double.infinity,
            constraints: BoxConstraints(
              maxWidth: 800,
              minWidth: 300,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  PinCodeTextField(
                    controller: _otpController,
                    appContext: context,
                    pastedTextStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    length: 6,
                    obscureText: false,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(12),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeColor: Colors.black,
                      inactiveColor: Colors.black,
                      selectedColor: Colors.black,
                      activeFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                      selectedFillColor: Colors.white,
                    ),
                    cursorColor: Colors.black,
                    cursorHeight: 10,
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    keyboardType: TextInputType.number,
                    boxShadows: const [
                      BoxShadow(
                        offset: Offset(0, 1),
                        color: Colors.black12,
                        blurRadius: 10,
                      )
                    ],
                    onChanged: (value) {},
                  ),
                  SizedBox(height: 20),
                  if (_isLoading) Center(child: CircularProgressIndicator()), // Show loading spinner
                  CustomNormalButton(
                    buttonText: 'OK', onTap: () {  },
                    // onTap: () async {
                    //   String otpCode = _otpController.text;
                    //   setState(() {
                    //     _isLoading = true; // Set loading to true
                    //   });
                    //   await dmtService.otpverify(otpCode);
                    //   setState(() {
                    //     _isLoading = false; // Set loading to false
                    //   });
                    //   await Future.delayed(Duration(milliseconds: 500));
                    //   Navigator.pop(context);
                    // },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String hintText,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        DropdownButtonFormField<String>(
          value: value,
          isExpanded: true,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(),
          ),
          items: items.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    required TextEditingController controller,
    bool isReadOnly = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Color(0xFF263238),
            fontSize: 14,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 6.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
            ),
            keyboardType: keyboardType,
            readOnly: isReadOnly,
          ),
        ),
      ],
    );
  }

  void _resetForm() {
    accountController.clear();
    ifscController.clear();
    setState(() {
      selectedBank = null;
      isVerified = false;
    });
  }
}
