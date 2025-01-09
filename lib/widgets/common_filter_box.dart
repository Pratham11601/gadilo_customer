import 'package:flutter/material.dart';

import '../utils/app_enums.dart';

class CommonDropdownMenuExample extends StatefulWidget {
  final ValueChanged<FilterOption?> onChanged;
  final FilterOption? initialSelectedOption;

  const CommonDropdownMenuExample({
    super.key,
    required this.onChanged,
    this.initialSelectedOption,
  });

  @override
  _CommonDropdownMenuExampleState createState() => _CommonDropdownMenuExampleState();
}

class _CommonDropdownMenuExampleState extends State<CommonDropdownMenuExample> {
  FilterOption? selectedOption;

  @override
  void initState() {
    super.initState();
    selectedOption = widget.initialSelectedOption;
  }

  List<DropdownMenuItem<FilterOption>> get dropdownItems {
    return FilterOption.values.map((FilterOption option) {
      return DropdownMenuItem<FilterOption>(
        value: option,
        child: Text(
          option
              .toString()
              .split('.')
              .last
              .replaceAllMapped(
                RegExp(r'([A-Z])'),
                (Match m) => ' ${m[0]}',
              )
              .trim(), // Convert enum name to readable format
          style: TextStyle(
            color: Color.fromRGBO(15, 15, 20, 1),
            fontSize: 11,
            fontWeight: FontWeight.w400,
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<FilterOption>(
      hint: Text(
        "Filter",
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      items: dropdownItems,
      value: selectedOption,
      onChanged: (FilterOption? newValue) {
        setState(() {
          selectedOption = newValue;
        });
        widget.onChanged(newValue);
      },
      underline: Container(),
    );
  }
}
