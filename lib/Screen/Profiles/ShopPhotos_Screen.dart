import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shantipe_2app/Utils/Custom_AppBar.dart';

class ShopPhotosScreen extends StatefulWidget {
  const ShopPhotosScreen({super.key});

  @override
  State<ShopPhotosScreen> createState() => _ShopPhotosScreenState();
}
 
class _ShopPhotosScreenState extends State<ShopPhotosScreen> {
  File? shopPhoto1;
  File? shopPhoto2;

   final ImagePicker _picker = ImagePicker();

  Future<void> _takePhoto(int photoIndex) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        if (photoIndex == 1) {
          shopPhoto1 = File(pickedFile.path);
        } else if (photoIndex == 2) {
          shopPhoto2 = File(pickedFile.path);
        }
      });
    }
  }

  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
       backgroundColor: Colors.white,
      appBar: CustomAppBar(
        titleText: "Shop Photo Details",
        onBackPress: () {
          print("Custom back pressed");
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Shop Photos",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Click Live Shop Photos",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              "Take clear photos of your shop to avoid rejection and keep your BharatPe account active",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),

            // Shop Photo 1
             _photoCard(
              context: context,
              file: shopPhoto1,
              title: "Shop Photo 1",
              subtitle: "Take a clear photo of your shop from outside",
              enabled: true,
              onClick: () => _takePhoto(1),
            ),

            const SizedBox(height: 16),

            // Shop Photo 2
            _photoCard(
              context: context,
              file: shopPhoto2,
              title: "Shop Photo 2",
              subtitle: "Take a clear photo of your shop from inside",
              enabled: true,
              onClick: () => _takePhoto(2),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),

      // Bottom Button
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        color: Colors.white,
        child: SizedBox(
          height: 48,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              // Bottom click handler
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 4, 99, 233), // Blue
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              'Click Photo',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Color(0xffFFFFFF)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _photoCard({
    required BuildContext context,
    required File? file,
    required String title,
    required String subtitle,
    required bool enabled,
    required VoidCallback onClick,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Row(
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
            child: file != null
                ? Image.file(
                    file,
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    'lib/assets/images/store.png',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
          ),

          const SizedBox(width: 15),
          // Text and Button
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14.0,horizontal: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style:
                        const TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                  ),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(fontSize: 13)),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: enabled ? onClick : null,
                    icon: const Icon(Icons.camera_alt_outlined, size: 18),
                    label: const Text("Click Photo"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          enabled ? Colors.white : Colors.grey.shade300,
                      foregroundColor: const Color(0xFF0047AB),
                      side: BorderSide(
                          color: enabled ? const Color(0xFF0047AB):Colors.grey),
                      elevation: 0,
                        padding:
                          const EdgeInsets.symmetric(horizontal: 13,vertical: 8),
                          shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
