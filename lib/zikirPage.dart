import 'package:flutter/material.dart';
import 'package:zikirmatik/models/model.dart';

import 'main.dart';

class DhikrPage extends StatefulWidget {
  final Zikir zikir;

  const DhikrPage({super.key, required this.zikir});

  @override
  _DhikrPageState createState() => _DhikrPageState();
}

class _DhikrPageState extends State<DhikrPage> {
  int dhikrCount = 0;

  void incrementDhikrCount() {
    setState(() {
      dhikrCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kindacode.com'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.zikir.nameLatin,
              style: TextStyle(fontSize: 24),
            ),
            Text(
              widget.zikir.nameArabic,
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Count: $dhikrCount',
              style: TextStyle(fontSize: 24),
            ),
            ElevatedButton(
              onPressed: () {
                incrementDhikrCount();
              },
              child: const Text('Increment'),
            ),
          ],
        ),
      ),
    );
  }
}
