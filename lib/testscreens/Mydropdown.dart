import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final List<String> _values = List.generate(100, (index) => 'Item $index');

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text('Show Items'),
      onPressed: () async {
        final selectedValue = await showMenu<String>(
          context: context,
          position: RelativeRect.fill,
          items: _values.map((String value) {
            return PopupMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        );

        if (selectedValue != null) {
          print('Selected: $selectedValue');
        }
      },
    );
  }
}
