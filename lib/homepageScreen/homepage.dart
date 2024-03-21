import 'package:flutter/material.dart';
import 'package:zikirmatik/homepageScreen/widgets.dart';
import 'package:zikirmatik/models/apiservices-models/ayah.dart';
import 'package:zikirmatik/models/apiservices-models/ayahservices.dart';
import 'package:zikirmatik/models/apiservices-models/prayermodel.dart';
import 'package:zikirmatik/models/apiservices-models/prayerservices.dart';
import 'package:zikirmatik/models/model.dart';
import 'package:zikirmatik/models/service.dart';
import 'package:zikirmatik/models/timeparse.dart';

import 'package:zikirmatik/testscreens/testscreen.dart';
import 'package:zikirmatik/zikirPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ZikirService _dbService = ZikirService();
  List<Zikir> zikirList = [];
  // bilindik vir ayet oluştur
  Ayah ayah = Ayah(
    number: 1,
    arabicText: "Bismillahirrahmanirrahim",
    turkishText: "Rahman ve Rahim olan Allah'ın adıyla",
    surahName: "Fatiha",
    surahNanmeEnglish: "Fatiha",
  );

  PrayerTimes prayerTimes = PrayerTimes(date: "Yükleniyor...", times: [
    "Yükleniyor...",
    "Yükleniyor...",
    "Yükleniyor...",
    "Yükleniyor...",
    "Yükleniyor...",
    "Yükleniyor..."
  ]);
  void initState() {
    super.initState();
    _fetchZikirler();
    _fetchAyah();
    _fetchPrayerTimes();
  }

  _fetchZikirler() async {
    var fetchedZikirList = await _dbService.getZikirler();
    setState(() {
      zikirList = fetchedZikirList;
    });
  }

  _fetchAyah() async {
    var fetchedAyah = await getAyah(getVerseNumber());
    setState(() {
      ayah = fetchedAyah;
    });
  }

  _fetchPrayerTimes() async {
    var fetchedPrayerTimes =
        await PrayerTimesService().fetchPrayerTimes("İstanbul");
    print("Fetch prayer times: $fetchedPrayerTimes");
    setState(() {
      prayerTimes = fetchedPrayerTimes[0];
    });
  }

  void addedFunction() {
    print("added");
    _fetchZikirler();
  }

  //dropdown menüsü için
  String globalValue = "Zikir Seçin";

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: appBar(),
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          children: [
            // içinde namaz saatleri yazan yeşil arkaplanlı bir container
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.green,
              ),
              width: double.infinity,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        getFormattedDate(
                          //bugünün tarihi
                          DateTime.now(),
                        ),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            //fetch infos
                            _fetchAyah();
                            _fetchPrayerTimes();
                          },
                          icon: Icon(Icons.refresh))
                    ],
                  ),
                  Text(
                    "Namaz Vakitleri",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //english prayer times
                        buildPrayertime(prayerTimes.times[0], "İmsak"),
                        buildPrayertime(prayerTimes.times[1], "Güneş"),
                        buildPrayertime(prayerTimes.times[2], "Öğle"),
                        buildPrayertime(prayerTimes.times[3], "İkindi"),
                        buildPrayertime(prayerTimes.times[4], "Akşam"),
                        buildPrayertime(prayerTimes.times[5], "Yatsı"),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        //sol üst ve sağ alt köşeye border görünümü verir
                        border: Border(
                          top: BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
                          bottom: BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(ayah.arabicText,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              )),
                          SizedBox(height: 20),
                          Text(ayah.turkishText,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              )),
                        ],
                      )),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(
                      ayah.number.toString(),
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      ayah.surahNanmeEnglish,
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                      ),
                    ),
                  ])
                ],
              ),
            ),
            //griedview içinde çekilen zikir sayıları ve isimleri

            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Container(
                width: double.infinity,
                height: height * 0.5,
                child: GridView.builder(
                  //kaydıurmayı etkinleştirir
                  physics: AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: zikirList.length + 1,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return index == zikirList.length
                        ? //+ butomnu yeni dua veya zikir eklemöek için
                        Padding(
                            padding: index % 2 == 0
                                ? EdgeInsets.only(left: 10)
                                : EdgeInsets.only(right: 10),
                            child: GestureDetector(
                              onTap: () async {
                                //yeni dua dialogu açılacak
                                bool? result = await showDialog<bool>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return MyDialog(
                                      addedFunction: addedFunction,
                                    );
                                  },
                                );
                                if (result != null && result) {
                                  _fetchZikirler();
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Yeni Dua Ekle",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.green[500],
                                      ),
                                    ),
                                    Icon(
                                      Icons.add_circle_outline,
                                      color: Colors.green[500],
                                      size: 50,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Stack(
                            children: [
                              Padding(
                                padding: index % 2 == 0
                                    ? EdgeInsets.only(left: 10)
                                    : EdgeInsets.only(right: 10),
                                child: GestureDetector(
                                  onTap: () async {
                                    //sayfadan geldikten sonra zikirleri yenile
                                    final result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DhikrPage(
                                          zikir: zikirList[index],
                                        ),
                                      ),
                                    );

                                    // Geri döndükten sonra çağrılacak fonksiyon
                                    addedFunction();
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.green[500],
                                    ),
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          zikirList[index].nameLatin,
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          zikirList[index].nameArabic,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          zikirList[index]
                                              .currentCount
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 24,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text("Bağışlanan zikirler: ")
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                  top: 0,
                                  right: 0,
                                  child: IconButton(
                                    icon:
                                        Icon(Icons.close, color: Colors.white),
                                    onPressed: () async {
                                      //dialog açılacak
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text(
                                                "Silmek istediğinize emin misiniz?"),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text("Hayır"),
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  await _dbService.deleteZikir(
                                                      zikirList[index].id);
                                                  addedFunction();
                                                  Navigator.pop(context);
                                                },
                                                child: Text("Evet"),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  )),
                            ],
                          );
                  },
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }

  Widget buildPrayertime(String time, String name) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.white,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 13,
              color: Colors.white,
            ),
          ),
          Text(
            time,
            style: TextStyle(
              fontSize: 11,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: Text("Zikir Matik"),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ZikirEklemeSayfasi()),
            );
          },
        ),
      ],
    );
  }
}
