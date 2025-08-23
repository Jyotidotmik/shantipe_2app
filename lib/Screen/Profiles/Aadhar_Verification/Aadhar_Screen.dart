import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Utils/Custom_AppBar.dart';
import '../../../Utils/upload_button.dart';
import 'Widget_Pantitle.dart';

class AadhaarScreen extends StatefulWidget {
  const AadhaarScreen({super.key});

  @override
  State<AadhaarScreen> createState() => _AadhaarScreenState();
}

class _AadhaarScreenState extends State<AadhaarScreen> {
  File? _aadharImage;
 
  final ImagePicker _picker = ImagePicker();
 Future<void> _pickImage(
    ImageSource source,
    Function(File?) onImagePicked,
  ) async {
    final pickedFile = await _picker.pickImage(source: source);
    setState(() {
      onImagePicked(File(pickedFile!.path));
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        titleText: "Aadhaar Verification",
        onBackPress: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height * 0.015),
            //  Verified Banner
            Container(
              width: double.infinity,
              color: const Color(0xFFD1FADF), // Light green
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle, color: Color(0xFF12B76A)),
                  SizedBox(width: 8),
                  Text(
                    'Verified',
                    style: TextStyle(
                      color: Color(0xFF12B76A),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: size.height * 0.02),
            // Aadhaar Details
            Container(
              padding: EdgeInsets.all(size.width * 0.04),
              decoration: BoxDecoration(
                color: const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  PanTile(title: "NAME", value: "LALIT YADAV"),
                  PanTile(title: "AADHAAR NUMBER", value: "xxxx xxxx 6176"),
                  PanTile(title: "DATE OF BIRTH", value: "23-02-1996"),
                  PanTile(
                    title: "ADDRESS",
                    value:
                        "C/O BUDH RAM, HOUSE NO 165, GALI NO 8, G BLOCK PREM NAGAR, SHANIBAZAR ROAD, Najafgarh, South West Delhi, Delhi, 110043",
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.02),
            //  Upload Aadhaar Image
           Utils.buildUploadContainer(
                        'Upload Aadhar Card Image',
                        _aadharImage,
                        () => _pickImage(ImageSource.camera, (image) {
                          setState(() {
                            _aadharImage = image;
                          });
                        }),
                        150,
                        400,
                      ),
            SizedBox(height: size.height * 0.02),
            // Bottom Note
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: size.height * 0.018,
                horizontal: size.width * 0.03,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF1F5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.lock_outline, size: 18),
                  SizedBox(width: size.width * 0.02),
                  Text(
                    "Aadhaar number can't be changed",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: size.width * 0.035,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: size.height * 0.03),
          ],
        ),
      ),
    );
  }
}