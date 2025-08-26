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
        if (label != null && label!.isNotEmpty)
          Text(
            label!,
            style: const TextStyle(
              color: Color(0xFF263238),
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          readOnly: readOnly,
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
          maxLength: maxLength,
          inputFormatters: [
            LengthLimitingTextInputFormatter(maxLength),
            if (isNumber) FilteringTextInputFormatter.digitsOnly,
          ],
          decoration: InputDecoration(
            hintText: hintText,
            counterText: '',
            filled: true,
            fillColor: readOnly ? Colors.grey.shade300 : Colors.white,
            // prefixIcon: readOnly
            //     ? const Icon(Icons.lock_outline, color: Colors.grey)
            //     : null,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(5),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:  BorderSide(color: Colors.red.shade300),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          cursorColor: Colors.amber,
        ),
      ],
    );
  }
}
