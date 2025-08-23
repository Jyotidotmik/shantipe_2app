import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../Utils/Custom_AppBar.dart';
import '../../Utils/Custom_button.dart';
import 'Widget/Custom_TextField.dart';

class fundTransferRegister extends StatefulWidget {
  final String mobile;
  final String contactKeyEncoded;
  final String fromScreen;
  const fundTransferRegister({
    super.key,
    required this.mobile,
    required this.contactKeyEncoded,
    required this.fromScreen,
  });

  @override
  fundTransferRegisterState createState() => fundTransferRegisterState();
}

class fundTransferRegisterState extends State<fundTransferRegister> {
  final _formKey = GlobalKey<FormState>();
  //final FundTransferService fundTransferService = FundTransferService();

  // Controller declarations
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController aadharController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();

  bool _isLoading = false;
  bool isAadharKyc = true; // default selected toggle option

  @override
  void initState() {
    super.initState();
    mobileController.text = widget.mobile; // set the passed mobile number
  }

  @override
  void dispose() {
    // Dispose controllers when the widget is removed
    mobileController.dispose();
    aadharController.dispose();
    emailController.dispose();
    nameController.dispose();
    addressController.dispose();
    pincodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(titleText: 'Register'),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(25.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // Toggle Button to switch between Aadhaar KYC and Non-KYC
                  ToggleButtons(
                    isSelected: [isAadharKyc, !isAadharKyc],
                    onPressed: (index) {
                      setState(() {
                        isAadharKyc = index == 0;
                      });
                    },
                    borderRadius: BorderRadius.circular(10),
                    selectedColor: Colors.white,
                    fillColor: Colors.green,
                    children: const [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text('Aadhaar KYC'),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text('Non-KYC'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Common Field: Mobile
                  CustomTextField(
                    controller: mobileController,
                    label: 'Mobile Number',
                    hintText: "Enter Mobile Number",
                    maxLength: 10,
                    isNumber: true,
                    readOnly: true,
                  ),

                  if (isAadharKyc) ...[
                    // Aadhaar KYC Fields
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: aadharController,
                      label: 'Aadhaar Number',
                      hintText: "Enter Aadhaar Number",
                      maxLength: 12,
                      isNumber: true,
                    ),
                  ] else ...[
                    // Non-KYC Fields
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: emailController,
                      label: 'Email',
                      hintText: "Enter Email",
                      // keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: nameController,
                      label: 'Name',
                      hintText: "Enter Full Name",
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: addressController,
                      label: 'Address',
                      hintText: "Enter Address",
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: pincodeController,
                      label: 'Pincode',
                      hintText: "Enter Pincode",
                      maxLength: 6,
                      isNumber: true,
                    ),
                  ],
                  const SizedBox(height: 30),
                  // Submit Button
                  // DmtCustomButton(
                  //   onPressed: _isLoading ? null : submitForm,
                  //   label: "Submit",
                  // ),
                ],
              ),
            ),
          ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }

  // void submitForm() async {
  //   FocusScope.of(context).unfocus();

  //   final mobile = mobileController.text.trim();

  //   // Aadhaar KYC validation
  //   if (isAadharKyc) {
  //     final aadhaar = aadharController.text.trim();

  //     if (aadhaar.isEmpty || aadhaar.length != 12) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text("Please enter a valid 12-digit Aadhaar number")),
  //       );
  //       return;
  //     }
  //   } else {
  //     // Non-KYC field validation
  //     final email = emailController.text.trim();
  //     final name = nameController.text.trim();
  //     final address = addressController.text.trim();
  //     final pinCode = pincodeController.text.trim();

  //     if (email.isEmpty || name.isEmpty || address.isEmpty || pinCode.isEmpty) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text("Please fill all the required fields")),
  //       );
  //       return;
  //     }
  //     if (pinCode.length != 6) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text("Please enter a valid 6-digit pincode")),
  //       );
  //       return;
  //     }
  //   }
  //   setState(() => _isLoading = true);
  //   try {
  //     Map<String, dynamic>? response;

  //     // Make API call based on KYC mode
  //     if (isAadharKyc) {
  //       response = await fundTransferService.fundTransferRegister(
  //         mobile: mobile,
  //         aadhaar: aadharController.text.trim(),
  //         isKyc: 1,
  //         context: context,
  //       );
  //     } else {
  //       response = await fundTransferService.fundTransferRegister(
  //         mobile: mobile,
  //         email: emailController.text.trim(),
  //         name: nameController.text.trim(),
  //         address: addressController.text.trim(),
  //         pinCode: pincodeController.text.trim(),
  //         isKyc: 0,
  //         context: context,
  //       );
  //     }

  //     // Handle response
  //     if (response != null) {
  //       final message = response['message'] ?? "Something went wrong";

  //       ScaffoldMessenger.of(
  //         Navigator.of(context, rootNavigator: true).context,
  //       ).showSnackBar(SnackBar(content: Text(message)));

  //       if (response['status'] == 'SUCCESS') {
  //         // If Aadhaar KYC and OTP activity, show OTP dialog
  //         if (isAadharKyc && response['activity'] == 'otp') {
  //           Future.delayed(const Duration(milliseconds: 300), () {
  //             _showOtpDialog(context);
  //           });
  //         } else {
  //           // Navigate based on fromScreen value
  //           Widget nextScreen;

  //           switch (widget.fromScreen) {
  //             case "CC":
  //               nextScreen = CreditCardLoginScreen();
  //               break;
  //             case "FT":
  //               nextScreen = FundTranferLoginFormScreen(
  //                 appBar: "Fund Transfer Login",
  //                 title: "Fund Transfer Login",
  //               );
  //               break;
  //             case "UPI":
  //               nextScreen = UpiLoginformscreen();
  //               break;
  //             default:
  //               nextScreen = FundTranferLoginFormScreen(
  //                 appBar: "Fund Transfer Login",
  //                 title: "Fund Transfer Login",
  //               );
  //           }

  //           Navigator.pushReplacement(
  //             context,
  //             MaterialPageRoute(builder: (context) => nextScreen),
  //           );
  //         }
  //       }
  //     } else {
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text("Error: ${e.toString()}")),
  //     );
  //   } finally {
  //     setState(() => _isLoading = false); // Hide loader
  //   }
  // }

  // OTP Dialog for Aadhaar KYC
  // ignore: unused_element
  void _showOtpDialog(BuildContext context) {
    final TextEditingController _otpController = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        bool _isLoading = false;
        String? statusMessage;
        bool isSuccessMessage = false;
        Timer? messageTimer;

        return StatefulBuilder(
          builder: (context, setState) {
            void showMessage(String message, {bool success = false}) {
              messageTimer?.cancel();
              setState(() {
                statusMessage = message;
                isSuccessMessage = success;
              });
              messageTimer = Timer(const Duration(seconds: 4), () {
                setState(() => statusMessage = null);
                // if (success) {
                //   Navigator.pop(context); // Close dialog
                //   Navigator.pushReplacement(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => FundTranferLoginFormScreen(
                //         appBar: "Fund Transfer Login",
                //         title: "Fund Transfer Login",
                //         mobile: widget.mobile,
                //       ),
                //     ),
                //   );
                // }
                //if (success) {
                //   Navigator.pop(context); // Close the OTP dialog

                //   // Navigate to appropriate login screen based on 'fromScreen' value after successful OTP
                //   Widget nextScreen;
                //   switch (widget.fromScreen) {
                //     case "CC": // Credit Card login
                //       nextScreen = CreditCardLoginScreen();
                //       break;
                //     case "FT": // Fund Transfer login
                //       nextScreen = FundTranferLoginFormScreen(
                //         appBar: "Fund Transfer Login",
                //         title: "Fund Transfer Login",
                //         mobile: widget.mobile, // Pass mobile number to login screen if needed
                //       );
                //       break;
                //     case "UPI": // UPI login
                //       nextScreen = UpiLoginformscreen();
                //       break;
                //     default: // Default to Fund Transfer login
                //       nextScreen = FundTranferLoginFormScreen(
                //         appBar: "Fund Transfer Login",
                //         title: "Fund Transfer Login",
                //         mobile: widget.mobile,
                //       );
                //   }

                //   Navigator.pushReplacement(
                //     context, // Use this.context to refer to the widget's context, not dialogContext
                //     MaterialPageRoute(builder: (context) => nextScreen),
                //   );
                // }
              });
            }

            return AlertDialog(
              contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              titlePadding: const EdgeInsets.only(top: 10, left: 20, right: 10),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Enter OTP',
                    style: TextStyle(
                      color: Color(0xFFC43F3E),
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.black54),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              content: SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'OTP sent to aadhaar registered mobile number',
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 15),
                    PinCodeTextField(
                      controller: _otpController,
                      appContext: context,
                      length: 6,
                      keyboardType: TextInputType.number,
                      animationDuration: const Duration(milliseconds: 200),
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(12),
                        fieldHeight: 55,
                        fieldWidth: 45,
                        activeColor: Colors.black,
                        inactiveColor: Colors.black26,
                        selectedColor: Colors.black,
                        activeFillColor: Colors.white,
                        inactiveFillColor: Colors.white,
                        selectedFillColor: Colors.white,
                      ),
                      onChanged: (value) {
                        if (statusMessage != null) {
                          setState(() => statusMessage = null);
                        }
                      },
                    ),
                    const SizedBox(height: 8),
                    if (statusMessage != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Text(
                          statusMessage!,
                          style: TextStyle(
                            color: isSuccessMessage ? Colors.green : Colors.red,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    _isLoading
                        ? const CircularProgressIndicator()
                        : CustomNormalButton(
                            buttonText: 'OK',
                            onTap: () async {
                              FocusScope.of(context).unfocus();
                              final otp = _otpController.text.trim();

                              if (otp.isEmpty || otp.length != 6) {
                                showMessage("Enter a valid 6-digit OTP");
                                return;
                              }
                              setState(() => _isLoading = true);
                            //final result = await fundTransferService.otpverify(otp, context);
                              setState(() => _isLoading = false);
                              // if (result['success'] == true) {
                              //   showMessage(result['message'] ?? 'Verification successful', success: true);
                              // } else {
                              //   _otpController.clear();
                              //   showMessage(result['message'] ?? 'Verification failed');
                              // }
                            },
                          ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
