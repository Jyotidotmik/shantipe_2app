import 'package:flutter/material.dart';

import '../../../Utils/Custom_AppBar.dart';
import '../../Fund Transfer/Widget/Custom_TextField.dart';
import '../widget/custom_button.dart';

class RegisterScreen extends StatefulWidget {
  final String mobile;
  const RegisterScreen({
    super.key,
    required this.mobile,
  });

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController aadharNumberController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    mobileController.text = widget.mobile; 
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
        titleText: "",
        onBackPress: () {
          Navigator.pop(context);
        },
      ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  CustomTextField(
                    controller: mobileController,
                    label: 'Mobile Number',
                    hintText: "Enter Mobile Number",
                    maxLength: 10,
                    isNumber: true,
                    readOnly: true,
                  ),
                  SizedBox(height: 10),
                  CustomTextField(
                    controller: aadharNumberController,
                    label: 'Aadhaar Number',
                    hintText: "Enter Aadhaar Number",
                    maxLength: 12,
                    isNumber: true,
                  ),
                  SizedBox(height: 20),
                  DmtCustomButton(
                    onPressed:(){},
                    label: "Submit",
                  ),
                ],
              ),
            ),
            if (_isLoading)
              Positioned.fill(
                child: AbsorbPointer(
                  absorbing: true,
                  child: Container(
                    // ignore: deprecated_member_use
                    color: Colors.black.withOpacity(0.5),
                    child: const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
