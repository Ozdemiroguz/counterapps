import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  ZikirService _zikirService = ZikirService();
  TextEditingController controllerAdd = TextEditingController();

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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                widget.zikir.nameLatin,
                style: TextStyle(fontSize: 48),
                textAlign: TextAlign.center,
              ),
              Text(
                widget.zikir.nameArabic,
                style: TextStyle(fontSize: 24),
              ),
              Text(
                "${widget.zikir.currentCount.toString()}",
                style: TextStyle(fontSize: 56),
              ),
              Text(
                textAlign: TextAlign.center,
                "(${sayiYaziyaCevir(widget.zikir.currentCount)})",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 20,
              ),
              forgivenTable(),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  //zikir bağışlama butonu
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    forgiven(),
                    Spacer(),
                    SizedBox(
                      width: 100,
                      height: 50,
                      child: TextFormField(
                        controller: controllerAdd,
                        decoration: InputDecoration(
                          labelText: 'Ekle',
                          labelStyle: TextStyle(color: Colors.green),
                          border: outlineInputBorder,
                          focusedBorder: outlineInputBorder,
                          enabledBorder: outlineInputBorder,
                          //sol üst ve sağ alt köşeleri yuvarlak yapar
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {},
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          //sayı girilmediyse ,0 ise ve sayı dışında bir şey girildiyse hata mesajı ver
                          if (controllerAdd.text.isEmpty ||
                              controllerAdd.text == '0' ||
                              !RegExp(r'^[0-9]*$')
                                  .hasMatch(controllerAdd.text)) {
                            //hata mesajı
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Lütfen bir sayı giriniz'),
                              duration: Duration(seconds: 2),
                            ));
                            return;
                          }
                          widget.zikir.currentCount +=
                              int.parse(controllerAdd.text);
                          _zikirService.updateZikir(widget.zikir);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Sayı eklendi'),
                            duration: Duration(seconds: 2),
                          ));
                          controllerAdd.clear();
                          setState(() {});
                        },
                        child: Text(
                          'Ekle',
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget forgiven() {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          //10 raidus border her köşesi 10 olur
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
        onPressed: () {
          TextEditingController controller = TextEditingController();
          TextEditingController controller1 = TextEditingController();
          //kime bağışlanacağını dialog ile sor ve bağışla
          //showdialog
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(
                    'Bağışla',
                    textAlign: TextAlign.center,
                  ),
                  titleTextStyle: TextStyle(
                      color: Colors.green,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),

                  //ortala

                  content: SizedBox(
                    height: 150,
                    child: Column(
                      //kime baıişlanacağını sor
                      children: [
                        TextFormField(
                          controller: controller,
                          decoration: InputDecoration(
                            labelText: 'Kime Bağışlanacak?',
                            labelStyle: TextStyle(color: Colors.green),
                            border: outlineInputBorder,
                            focusedBorder: outlineInputBorder,
                            enabledBorder: outlineInputBorder,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: controller1,
                          decoration: InputDecoration(
                            labelText: 'Kaç tane bağışlanacak',
                            labelStyle: TextStyle(color: Colors.green),
                            border: outlineInputBorder,
                            focusedBorder: outlineInputBorder,
                            enabledBorder: outlineInputBorder,
                          ),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'İptal',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        //bağışlanan kişi ve sayı
                        if (widget.zikir.currentCount == 0) {
                          //hata mesajı
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Bağışlanacak sayı 0 olamaz'),
                            duration: Duration(seconds: 2),
                          ));
                          return;
                        }
                        if (controller1.text.isEmpty ||
                            controller1.text == '0' ||
                            !RegExp(r'^[0-9]*$').hasMatch(controller1.text)) {
                          //hata mesajı
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Lütfen bir sayı giriniz'),
                            duration: Duration(seconds: 2),
                          ));
                          return;
                        }
                        if (int.parse(controller1.text) >
                            widget.zikir.currentCount) {
                          //hata mesajı
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                'Bağışlanacak sayı, mevcut sayıdan fazla olamaz'),
                            duration: Duration(seconds: 2),
                          ));
                          return;
                        }
                        String forgiven =
                            controller.text + "*" + controller1.text;
                        widget.zikir.forgiven.add(forgiven);
                        widget.zikir.totalCount += int.parse(controller1.text);
                        _zikirService.updateZikir(widget.zikir);
                        widget.zikir.currentCount -=
                            int.parse(controller1.text);
                        controller1.clear();
                        controller.clear();

                        setState(() {});

                        Navigator.pop(context);
                      },
                      child: Text(
                        'Bağışla',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                    ),
                  ],
                );
              });

          // Update the count in the database
        },
        child: Text(
          'Bağışla',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }

  Widget forgivenTable() {
    return SizedBox(
        height: 250,
        child: SingleChildScrollView(
          child: Column(
            children: [
              widget.zikir.forgiven.isEmpty
                  ? Container(
                      child: Text(
                      "Bağışlanan yok",
                      style: TextStyle(fontSize: 24),
                    ))
                  : Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Table(
                        children: [
                          TableRow(children: [
                            Text(
                              'Bağışlananlar',
                              style: TextStyle(fontSize: 24),
                            ),
                            Text(
                              'Sayı',
                              style: TextStyle(fontSize: 24),
                            ),
                          ]),
                          for (int i = 0;
                              i < widget.zikir.forgiven.length + 1;
                              i++)
                            i == widget.zikir.forgiven.length
                                ? TableRow(children: [
                                    Text(
                                      'Toplam',
                                      style: TextStyle(fontSize: 24),
                                    ),
                                    Text(
                                      widget.zikir.totalCount.toString(),
                                      style: TextStyle(fontSize: 24),
                                    ),
                                  ])
                                : TableRow(children: [
                                    Text(
                                      widget.zikir.forgiven[i].split('*')[0],
                                      style: TextStyle(fontSize: 24),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          widget.zikir.forgiven[i]
                                              .split('*')[1],
                                          style: TextStyle(fontSize: 24),
                                        ),
                                        Spacer(),
                                        IconButton(
                                          icon: Icon(Icons.delete),
                                          onPressed: () {
                                            //alert dialog ile sor
                                            showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                      title: Text('Sil'),
                                                      content: Text(
                                                          'Bu bağışı silmek istediğinize emin misiniz?'),
                                                      actions: [
                                                        ElevatedButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child:
                                                                Text('İptal')),
                                                        ElevatedButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                              widget.zikir
                                                                      .totalCount -=
                                                                  int.parse(widget
                                                                      .zikir
                                                                      .forgiven[
                                                                          i]
                                                                      .split(
                                                                          '*')[1]);
                                                              widget.zikir
                                                                      .currentCount +=
                                                                  int.parse(widget
                                                                      .zikir
                                                                      .forgiven[
                                                                          i]
                                                                      .split(
                                                                          '*')[1]);

                                                              widget.zikir
                                                                  .forgiven
                                                                  .removeAt(i);
                                                              _zikirService
                                                                  .updateZikir(
                                                                      widget
                                                                          .zikir);
                                                              setState(() {});
                                                            },
                                                            child: Text('Sil')),
                                                      ],
                                                    ));
                                          },
                                        ),
                                      ],
                                    )
                                  ]),
                        ],
                      ),
                    )
            ],
          ),
        ));
  }

  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    //sol alt ve sol üst yuvarlak yapar
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(10),
      bottomLeft: Radius.circular(10),
    ),
    borderSide: const BorderSide(color: Colors.green),

    //green border
  );
  String sayiYaziyaCevir(int sayi) {
    List<String> birler = [
      '',
      'Bir',
      'İki',
      'Üç',
      'Dört',
      'Beş',
      'Altı',
      'Yedi',
      'Sekiz',
      'Dokuz'
    ];
    List<String> onlar = [
      '',
      'On',
      'Yirmi',
      'Otuz',
      'Kırk',
      'Elli',
      'Altmış',
      'Yetmiş',
      'Seksen',
      'Doksan'
    ];
    List<String> basamaklar = [
      '',
      '',
      'Yüz',
      'Bin',
      '',
      'Yüz',
      'Milyon',
      '',
      'Yüz',
      'Milyar'
    ];
    String yazi = '';

    if (sayi == 0) {
      return 'Sıfır';
    }

    int basamak = 0;
    while (sayi > 0) {
      if (basamak % 3 == 0) {
        yazi = birler[sayi % 10] + ' ' + basamaklar[basamak] + ' ' + yazi;
      } else if (basamak % 3 == 1) {
        yazi = onlar[sayi % 10] + ' ' + yazi;
      } else if (basamak % 3 == 2) {
        yazi = birler[sayi % 10] + ' ' + basamaklar[basamak] + ' ' + yazi;
      }
      sayi ~/= 10;
      basamak++;
    }

    return yazi.trim();
  }
}
