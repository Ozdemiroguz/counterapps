import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:zikirmatik/models/apiservices-models/ayah.dart';
import 'package:zikirmatik/models/apiservices-models/ayahservices.dart';

Future<Ayah> getAyah(int ayahNumber) async {
  final response = await http.get(Uri.parse(
      'https://api.alquran.cloud/v1/ayah/$ayahNumber/editions/quran-uthmani,tr.yazir'));

  if (response.statusCode == 200) {
    // Parse the response body and return an Ayah object
    var data = jsonDecode(response.body);
    var ayahData = data['data'][0];
    var arabicText = ayahData['text'];
    var turkishText = data['data'][1]['text'];
    var surahName = ayahData['surah']['name'];
    var surahNameEnglish = ayahData['surah']['englishName'];

    return Ayah(
      number: ayahNumber,
      arabicText: arabicText,
      turkishText: turkishText,
      surahName: surahName,
      surahNanmeEnglish: surahNameEnglish,
    );
  } else {
    throw Exception('Failed to load ayah');
  }
}

// test sayfaso oluştur ve bu fonksiyonu çağır
// test sayfası oluştur

void main() {
  runApp(MaterialApp(
    home: TestScreen(),
  ));
}

class TestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            Ayah ayah = await getAyah(31);
            print(ayah.arabicText);
            print(ayah.turkishText);
            print(ayah.surahName);
            print(ayah.number);
          },
          child: Text('Get Ayah'),
        ),
      ),
    );
  }
}

int getVerseNumber() {
  // Yılın başlangıç tarihini belirle
  DateTime startOfYear = new DateTime(DateTime.now().year, 1, 1);

  // Şu anki tarihi al ve yılın kaçıncı dakikası olduğunu bul
  DateTime now = new DateTime.now();
  int minutesPassed = now.difference(startOfYear).inMinutes;

  // Ayet numarasını hesapla
  int verseNumber = ((minutesPassed / 525600) * 6626).round();

  return verseNumber;
}
