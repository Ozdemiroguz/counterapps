import 'package:flutter/material.dart';
import 'package:zikirmatik/models/model.dart';
import 'package:zikirmatik/models/service.dart';
import 'package:zikirmatik/styles.dart';

class MyDialog extends StatefulWidget {
  final VoidCallback addedFunction;
  const MyDialog({Key? key, required this.addedFunction}) : super(key: key);
  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  @override
  //formkey
  final _formKey = GlobalKey<FormState>();
  List<Dua> _duaList = [
    Dua(
      id: 1,
      nameLatin: "Subhanallah",
      nameArabic: "سبحان الله",
      dua: "Subhanallah",
    ),
    Dua(
      id: 2,
      nameLatin: "Elhamdulillah",
      nameArabic: "الحمد لله",
      dua: "Elhamdulillah",
    ),
    Dua(
      id: 3,
      nameLatin: "La havle vela kuvvete illa billah",
      nameArabic: "لا حول ولا قوة إلا بالله",
      dua: "La havle vela kuvvete illa billah",
    ),
    Dua(
      id: 4,
      nameLatin: "Allahu Ekber",
      nameArabic: "الله أكبر",
      dua: "Allahu Ekber",
    ),
    Dua(
      id: 5,
      nameLatin: "La ilahe illallah",
      nameArabic: "لا إله إلا الله",
      dua: "La ilahe illallah",
    ),
    Dua(
      id: 6,
      nameLatin: "Astaghfirullah",
      nameArabic: "أستغفر الله",
      dua: "Astaghfirullah",
    ),
    Dua(
      id: 7,
      nameLatin: "Hasbunallah",
      nameArabic: "حسبنا الله",
      dua: "Hasbunallah",
    ),
  ];
  String _selectedValue = "Subhanallah";
  bool isdua = true;
  TextEditingController _duaController = TextEditingController();
  TextEditingController _startController = TextEditingController();
  TextEditingController _endController = TextEditingController();
  TextEditingController _counterController = TextEditingController();
  // sayılı değerleri 0 a eşitle
  @override
  void initState() {
    super.initState();
    _startController.text = "0";
    _endController.text = "0";
  }

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //2 tane gesture dircetor ile 2 farklı sayfa olacak
          GestureDetector(
            onTap: () {
              if (isdua == false) {
                setState(() {
                  isdua = true;
                });
              }
              //yeni dua eklenecek
            },
            child: Text(
              "Yeni Dua ",
              style: TextStyle(
                  fontSize: 20, color: isdua ? primaryColor : Colors.grey),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (isdua == true) {
                setState(() {
                  isdua = false;
                });
              }
              //isdua kontrol edilcek false ise true olacak
            },
            child: Text(
              "Yeni Sayaç",
              style: TextStyle(
                  fontSize: 20, color: isdua ? Colors.grey : primaryColor),
            ),
          ),
        ],
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Visibility(
              visible: isdua,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DropdownButton<String>(
                  menuMaxHeight: 100,
                  value: _selectedValue,
                  items: _duaList.map((dua) {
                    return DropdownMenuItem(
                      child: SizedBox(
                        width: width * 0.7,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(dua.nameLatin,
                                  style: const TextStyle(fontSize: 20)),
                              Text(dua.nameArabic),
                            ],
                          ),
                        ),
                      ),
                      value: dua.nameLatin,
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      print(value!);
                      _selectedValue = value;
                      print(_selectedValue);
                    });
                  },
                ),
              ),
            ),
            Visibility(
              visible: !isdua,
              child: TextFormField(
                controller: _duaController,
                cursorColor: Colors.green,
                decoration: InputDecoration(
                  labelText: "Yeni Dua",
                  labelStyle: TextStyle(
                    color: Colors.green,
                  ),
                  focusedBorder: outlineInputBorder,
                  enabledBorder: outlineInputBorder,
                ),
                keyboardType: TextInputType.text,
                style: const TextStyle(
                  fontSize: 20,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Dua Boş Olamaz';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: width * 0.3,
                  child: TextFormField(
                    controller: _startController,
                    cursorColor: Colors.green,
                    decoration: InputDecoration(
                      labelText: "Başlanılacak Sayı",
                      labelStyle: TextStyle(
                        color: Colors.green,
                      ),
                      focusedBorder: outlineInputBorder,
                      enabledBorder: outlineInputBorder,
                    ),
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Başlanılacak Sayı Boş Olamaz';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  width: width * 0.3,
                  child: TextFormField(
                    controller: _endController,
                    cursorColor: Colors.green,
                    decoration: InputDecoration(
                      labelText: "Bitirilecek Sayı",
                      labelStyle: TextStyle(
                        color: Colors.green,
                      ),
                      border: outlineInputBorder,
                      focusedBorder: outlineInputBorder,
                      enabledBorder: outlineInputBorder,
                    ),
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Bitirilecek Sayı Boş Olamaz';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            //form button
            SizedBox(
              width: width * 0.9,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final ZikirService _zikirService = ZikirService();
                    if (isdua) {
                      //dua eklenecek
                      Dua dua = _duaList.firstWhere(
                          (element) => element.nameLatin == _selectedValue);
                      Zikir zikir = Zikir(
                        id: 0,
                        nameLatin: dua.nameLatin,
                        nameArabic: dua.nameArabic,
                        currentCount: int.parse(_startController.text),
                        totalCount: int.parse(_endController.text),
                      );
                      bool result = await _zikirService.insertZikir(zikir);
                      if (result) {
                        //scaffold snackbar ile eklendi
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Zikir Eklendi"),
                          ),
                        );
                        Navigator.pop(context, true);
                      } else {
                        //scaffold snackbar ile eklendi
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Zikir Eklenemedi"),
                          ),
                        );
                        Navigator.pop(context, false);
                      }
                    } else {
                      if (_duaController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Dua Adı Boş Olamaz"),
                          ),
                        );
                        return;
                      }
                      Zikir zikir = Zikir(
                        id: 0,
                        nameLatin: _duaController.text,
                        nameArabic: "",
                        currentCount: int.parse(_startController.text),
                        totalCount: int.parse(_endController.text),
                      );

                      bool result = await _zikirService.insertZikir(zikir);
                      if (result) {
                        //scaffold snackbar ile eklendi
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Zikir Eklendi"),
                          ),
                        );
                        Navigator.pop(context, true);
                      } else {
                        //scaffold snackbar ile eklendi
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Zikir Eklenemedi"),
                          ),
                        );
                        Navigator.pop(context, false);
                      }
                    }
                  }
                },
                child: const Text(
                  "Ekle",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//outlined border  style
OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10),
  borderSide: const BorderSide(color: Colors.green),
  //green border
);
//bir container widget oluştur 

/*SizedBox(
        width: width * 0.9,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Visibility(
              visible: isdua,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DropdownButton<String>(
                  value: _selectedValue,
                  items: _duaList.map((dua) {
                    return DropdownMenuItem(
                      child: SizedBox(
                        width: width * 0.7,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(dua.nameLatin,
                                  style: const TextStyle(fontSize: 20)),
                              Text(dua.nameArabic),
                            ],
                          ),
                        ),
                      ),
                      value: dua.nameLatin,
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      print(value!);
                      _selectedValue = value;
                      print(_selectedValue);
                    });
                  },
                ),
              ),
            ),
            Visibility(
              visible: !isdua,
              child: TextField(
                controller: _duaController,
                cursorColor: Colors.green,
                decoration: InputDecoration(
                  labelText: "Yeni Dua",
                  labelStyle: TextStyle(
                    color: Colors.green,
                  ),
                  border: outlineInputBorder,

                  focusedBorder: outlineInputBorder,
                  //focus olmayan border
                  enabledBorder: outlineInputBorder,
                ),
                keyboardType: TextInputType.text,
                style: const TextStyle(
                  fontSize: 20,
                ),
                //border ekleme
              ),
            ),
            //counter sayısıının eklenceği kısım
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: width * 0.3,
                  child: TextField(
                    controller: _startController,
                    cursorColor: Colors.green,

                    decoration: InputDecoration(
                      labelText: "Bşlanılacak Sayı",
                      labelStyle: TextStyle(
                        color: Colors.green,
                      ),
                      border: outlineInputBorder,
                      focusedBorder: outlineInputBorder,
                      //focus olmayan border
                      enabledBorder: outlineInputBorder,
                    ),
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                    //border ekleme
                  ),
                ),
                SizedBox(
                  width: width * 0.3,
                  child: TextField(
                    controller: _endController,
                    cursorColor: Colors.green,
                    decoration: InputDecoration(
                      labelText: "Bitirilecek Sayı",
                      labelStyle: TextStyle(
                        color: Colors.green,
                      ),
                      border: outlineInputBorder,
                      //green border
                      focusedBorder: outlineInputBorder,
                      //focus olmayan border
                      enabledBorder: outlineInputBorder,
                    ),
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                //border ekleme
              ],
            ),
            // Diğer widgetlar...
          ],
        ),
      ), */