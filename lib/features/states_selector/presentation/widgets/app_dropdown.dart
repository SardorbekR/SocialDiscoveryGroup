import 'package:flutter/material.dart';
import 'package:social_discovery_group/features/states_selector/data/models/address_model.dart';

class AppDropdownMenu extends StatelessWidget {
  final String label;
  final Function(Address?) onSelected;
  final List<Address> items;

  const AppDropdownMenu({
    required this.label,
    required this.onSelected,
    required this.items,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<Address>(
      label: Text(label),
      onSelected: onSelected,
      menuHeight: 350,
      width: MediaQuery.of(context).size.width * 0.8,
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      dropdownMenuEntries: items.map<DropdownMenuEntry<Address>>((item) {
        return DropdownMenuEntry<Address>(value: item, label: item.value);
      }).toList(),
    );
  }
}
