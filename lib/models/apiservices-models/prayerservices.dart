import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zikirmatik/models/apiservices-models/prayermodel.dart';

class PrayerTimesService {
  Future<List<PrayerTimes>> fetchPrayerTimes(String city) async {
    final response = await http.get(
      Uri.parse(
          'https://namaz-vakti.vercel.app/api/timesFromPlace?country=Turkey&region=$city&city=$city&date=${DateTime.now().toIso8601String().substring(0, 10)}&days=3&timezoneOffset=180&calculationMethod=Turkey'),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      Map<String, dynamic> times = json['times'];
      return times.entries
          .map((e) => PrayerTimes.fromJson({'date': e.key, 'times': e.value}))
          .toList();
    } else {
      throw Exception('Failed to load prayer times');
    }
  }
}
