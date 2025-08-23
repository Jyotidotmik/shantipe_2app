import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shantipe_2app/Utils/Custom_AppBar.dart';
import 'package:shantipe_2app/Utils/upload_button.dart';

class DocumentUploadScreen extends StatefulWidget {
  const DocumentUploadScreen({super.key});

  @override
  State<DocumentUploadScreen> createState() => _DocumentUploadScreenState();
}

class _DocumentUploadScreenState extends State<DocumentUploadScreen> {
  // ignore: unused_field
  File? _shopFrontImage;
  File? _shopBackImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source, Function(File?) onImagePicked) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        onImagePicked(File(pickedFile.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      appBar: CustomAppBar(
        titleText: "Business Documents",
        onBackPress: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: const Color(0xffFFFFFF),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.05,
            vertical: height * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //  Subtitle
              Text(
                "Upload document to verify your business",
                style: TextStyle(
                  fontSize: width * 0.05,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1C1C1C),
                ),
              ),
              SizedBox(height: height * 0.025),
              //  Yellow Info Box
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: height * 0.018),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3B3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "Upload any 1 business document",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: width * 0.042,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              SizedBox(height: height * 0.03),

              //  Upload Container
              Utils.buildUploadContainer(
                'Upload in jpg, png, or pdf format',
                _shopBackImage,
                () => _pickImage(ImageSource.camera, (image) {
                  setState(() {
                    _shopBackImage = image;
                  });
                }),
                height * 0.20, // responsive height
                width * 0.92,  // responsive width
              ),
              SizedBox(height: height * 0.025),
              //  Info Row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info_outline, color: const Color(0xFF5F6B80), size: width * 0.05),
                  SizedBox(width: width * 0.025),
                  Expanded(
                    child: Text(
                      "Please upload the first page or merge multiple pages into one file",
                      style: TextStyle(
                        fontSize: width * 0.035,
                        color: const Color(0xFF5F6B80),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.16),
              //  Continue Button
              SizedBox(
                width: double.infinity,
                height: height * 0.05,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    "Continue",
                    style: TextStyle(
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
