class PrayerTimes {
  final String date;
  final List<String> times;

  PrayerTimes({required this.date, required this.times});

  factory PrayerTimes.fromJson(Map<String, dynamic> json) {
    return PrayerTimes(
      date: json['date'],
      times: List<String>.from(json['times'].map((x) => x)),
    );
  }
}
