import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:diacritic/diacritic.dart';


class SchoolDropdown extends StatelessWidget {
  final List<String> schools;
  final String? selected;
  final Function(String?) onChanged;

  const SchoolDropdown({
    super.key,
    required this.schools,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<String>(
      items: schools,
      selectedItem: selected,

      popupProps: PopupProps.menu(
        showSearchBox: true,
        searchDelay: Duration(milliseconds: 0),
        menuProps: const MenuProps(backgroundColor: Colors.white),
        searchFieldProps: TextFieldProps(
          autofocus: true,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: "Tìm trường...",
            filled: true,
            fillColor: Colors.grey[100],
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ),

      filterFn: (item, filter) {
        final itemText = removeDiacritics(item.toLowerCase());
        final filterText = removeDiacritics(filter!.toLowerCase());
        return itemText.contains(filterText);
      },

      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          hintText: "Chọn trường",
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.black12),
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.black12),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.blue),
          ),
        ),
      ),

      dropdownBuilder: (context, selectedItem) {
        return Text(
          selectedItem ?? "Chọn trường",
          style: const TextStyle(fontSize: 14, color: Colors.black),
        );
      },

      onChanged: onChanged,
    );
  }
}
