import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shantipe_2app/Utils/Custom_AppBar.dart';

class DmtLoginScreen extends StatefulWidget {
  const DmtLoginScreen({super.key});

  @override
  State<DmtLoginScreen> createState() => _DmtLoginScreenState();
}

class _DmtLoginScreenState extends State<DmtLoginScreen> {
  // ignore: non_constant_identifier_names
  final PhoneNumber = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(titleText: '',
      onBackPress: () {
        Navigator.pop(context);
      },),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Domestic Money Transfer Login', style: TextStyle(fontSize: 20, fontFamily: 'Open Sans', fontWeight: FontWeight.bold),),
              SizedBox(height: 15),
              TextField(
                keyboardType: TextInputType.number,
                controller: PhoneNumber,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.phone, color: Color(0xff0080FF)),
                  labelText: "Phone Number",
                  hintText: "Enter your phone number",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 120),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(
                      vertical: 15, horizontal: 100
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    )
                  ),
                  onPressed: () =>Get.toNamed('/dmt_register'),
                  child: Text('Submit',style: TextStyle(fontSize: 18, fontFamily: 'Open Sans', 
                  fontWeight: FontWeight.bold,color: Colors.white),),
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}