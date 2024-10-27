import 'package:flutter/material.dart';

import '../../../../core/resources/app_sizes.dart';

class CustomDropdown extends StatefulWidget {
  const CustomDropdown({
    super.key,
    required this.label,
    required this.items,
    this.onChanged,
    this.value,
  });

  final String label;
  final List<String> items;
  final Function(String)? onChanged;
  final String? value;

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? _value;

  @override
  void initState() {
    _value = widget.value ?? widget.items.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(widget.label),
        smallGap,
        DropdownButton<String>(
          value: _value,
          items: widget.items
              .map(
                (difficult) => DropdownMenuItem(
                  value: difficult,
                  child: Text(difficult),
                ),
              )
              .toList(),
          onChanged: (String? value) {
            if (value == null) return;
            widget.onChanged?.call(value);
            setState(() {
              _value = value;
            });
          },
        ),
      ],
    );
  }
}
