//ayet ve namaz tarihleini gösteceğimiz kart tasarımı

import 'package:flutter/material.dart';
import 'package:zikirmatik/models/apiservices-models/ayah.dart';
import 'package:zikirmatik/models/apiservices-models/ayahservices.dart';

class AyahAndTime extends StatefulWidget {
  @override
  _AyahAndTimeState createState() => _AyahAndTimeState();
}

class _AyahAndTimeState extends State<AyahAndTime> {
  late Ayah ayah;
  late String time;

  @override
  void initState() {
    super.initState();
    _fetchAyah();
    _fetchTime();
  }

  _fetchAyah() async {
    ayah = await getAyah(31);
    setState(() {});
  }

  _fetchTime() async {
    time = DateTime.now().toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(ayah.arabicText),
          Text(ayah.turkishText),
          Text(ayah.surahName),
          Text(ayah.number.toString()),
          Text(time),
        ],
      ),
    );
  }
}
