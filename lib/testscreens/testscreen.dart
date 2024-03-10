import 'package:flutter/material.dart';
import 'package:zikirmatik/models/apiservices-models/prayermodel.dart';
import 'package:zikirmatik/models/apiservices-models/prayerservices.dart';
import 'package:zikirmatik/models/model.dart';
import 'package:zikirmatik/models/service.dart';

class ZikirListesi extends StatefulWidget {
  @override
  _ZikirListesiState createState() => _ZikirListesiState();
}

class _ZikirListesiState extends State<ZikirListesi> {
  final ZikirService _zikirService = ZikirService();
  late Future<List<Zikir>> _zikirler;

  @override
  void initState() {
    super.initState();
    _zikirler = _zikirService.getZikirler();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Zikir Listesi'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          FutureBuilder<List<Zikir>>(
            future: _zikirler,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(snapshot.data![index].nameLatin),
                      subtitle:
                          //tüm bilgileri yazdır
                          Row(
                        children: [
                          Text("Id: ${snapshot.data![index].id.toString()}"),
                          SizedBox(
                            width: 10,
                          ),
                          Text(snapshot.data![index].nameArabic),
                          SizedBox(
                            width: 10,
                          ),
                          Text("latin: ${snapshot.data![index].nameLatin}"),
                          Text("Toplam: ${snapshot.data![index].totalCount}"),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Şuanki: ${snapshot.data![index].currentCount}"),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _zikirService.deleteZikir(snapshot.data![index].id);
                          setState(() {
                            _zikirler = _zikirService.getZikirler();
                          });
                        },
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('Hata: ${snapshot.error}');
              }
              return CircularProgressIndicator();
            },
          ),
          ElevatedButton(
              onPressed: () {},
              child: Column(
                children: [
                  Text("Namaz Vakitleri"),
                ],
              )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ZikirEklemeSayfasi()),
          );
        },
      ),
    );
  }
}

class ZikirEklemeSayfasi extends StatefulWidget {
  @override
  _ZikirEklemeSayfasiState createState() => _ZikirEklemeSayfasiState();
}

class _ZikirEklemeSayfasiState extends State<ZikirEklemeSayfasi> {
  final ZikirService _zikirService = ZikirService();
  final _formKey = GlobalKey<FormState>();
  final _zikir = Zikir(
      id: 0, nameLatin: '', nameArabic: '', currentCount: 0, totalCount: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Zikir Ekle'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Latin Adı'),
                onSaved: (value) {
                  _zikir.nameLatin = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Arapça Adı'),
                onSaved: (value) {
                  _zikir.nameArabic = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Toplam Zikir'),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  _zikir.totalCount = int.parse(value!);
                },
              ),
              ElevatedButton(
                child: Text('Ekle'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _zikirService.insertZikir(_zikir);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
