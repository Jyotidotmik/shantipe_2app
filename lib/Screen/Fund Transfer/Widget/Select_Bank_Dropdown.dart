import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class SelectBankDropdown extends StatelessWidget {
  final String label;
  final String hintText;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const SelectBankDropdown({
    Key? key,
    required this.label,
    required this.hintText,
    required this.value,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF263238),
            fontSize: 12,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6.0),
        DropdownSearch<String>(
          selectedItem: value,
          items: items,
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              hintText: hintText,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            ),
          ),
          popupProps: PopupProps.menu(
            showSearchBox: true,
            searchFieldProps: TextFieldProps(
              decoration: const InputDecoration(
                hintText: "Search Bank...",
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
              ),
            ),
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
