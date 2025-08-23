import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final String hintText;
  final bool isNumber;
  final int maxLength;
  final bool readOnly;

  const CustomTextField({
    super.key,
    required this.controller,
    this.label,
    this.hintText = '',
    this.isNumber = false,
    this.maxLength = 100,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label ?? "",
          style: const TextStyle(
            color: Color(0xFF263238),
            fontSize: 14,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5),
          ),
          child: TextField(
            controller: controller,
            keyboardType: isNumber ? TextInputType.number : TextInputType.text,
            readOnly: readOnly,
            showCursor: !readOnly,
            maxLength: maxLength,
            inputFormatters: [
              LengthLimitingTextInputFormatter(maxLength),
              if (isNumber) FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
              counterText: '',
            ),
            cursorColor: Colors.amber,
          ),
        ),
      ],
    );
  }
}
