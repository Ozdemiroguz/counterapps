import 'package:flutter/material.dart';
import 'package:zikirmatik/models/model.dart';
import 'package:zikirmatik/models/service.dart';

import 'main.dart';

class DhikrPage extends StatefulWidget {
  final Zikir zikir;

  DhikrPage({required this.zikir});

  @override
  _DhikrPageState createState() => _DhikrPageState();
}

class _DhikrPageState extends State<DhikrPage> {
  int dhikrCount = 0;
  ZikirService _zikirService = ZikirService();

  void incrementDhikrCount() {
    setState(() {});
    // Update the count in the database
    widget.zikir.currentCount++;
    _zikirService.updateZikir(widget.zikir);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Sayacı Arttır  '),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.zikir.nameLatin,
              style: TextStyle(fontSize: 48),
            ),
            Text(
              widget.zikir.nameArabic,
              style: TextStyle(fontSize: 24),
            ),
            Text(
              widget.zikir.currentCount.toString(),
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 200,
              width: 200,
              child: ElevatedButton(
                //kare yeşil buton
                style: ElevatedButton.styleFrom(
                  //kare yeşil buton

                  backgroundColor: Colors.green,
                ),

                onPressed: () {
                  incrementDhikrCount();
                },
                child: const Text(
                  'Arttır',
                  style: TextStyle(fontSize: 32, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
