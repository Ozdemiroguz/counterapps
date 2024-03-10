import 'package:flutter/material.dart';
import 'package:zikirmatik/models/apiservices-models/prayermodel.dart';
import 'package:zikirmatik/models/apiservices-models/prayerservices.dart';

class PrayerTimesPage extends StatefulWidget {
  final String city;

  PrayerTimesPage({Key? key, required this.city}) : super(key: key);

  @override
  _PrayerTimesPageState createState() => _PrayerTimesPageState();
}

class _PrayerTimesPageState extends State<PrayerTimesPage> {
  late Future<List<PrayerTimes>> futurePrayerTimes;

  @override
  void initState() {
    super.initState();
    futurePrayerTimes = PrayerTimesService().fetchPrayerTimes(widget.city);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.city} Namaz Vakitleri'),
      ),
      body: Center(
        child: FutureBuilder<List<PrayerTimes>>(
          future: futurePrayerTimes,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data![index].date),
                    subtitle: Text(snapshot.data![index].times.join(', ')),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
