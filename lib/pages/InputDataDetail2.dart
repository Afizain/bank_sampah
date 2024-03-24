import 'package:bank_sampah/pallete.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class InputDataDetail2 extends StatefulWidget {
  @override
  State<InputDataDetail2> createState() => _InputDataDetailState();
}

class _InputDataDetailState extends State<InputDataDetail2> {
  final formkey = GlobalKey<FormState>();
  int _idTransaksi = 0;
  String? selectedCategoryName;
  String? selectedCategory;
  String? selectedJenis;
  String? selectedJenisName;
  String? selectedJenisHarga;
  List<Map<String, dynamic>> kategoriOptions = [];
  List<Map<String, dynamic>> jenisOptions = [];
  int totalHarga = 0;
  int qty = 0;
  List<Widget> containers = [];

  void incrementCount() {
    setState(() {
      qty++;
    });
  }

  void decrementCount() {
    if (qty < 1) {
      return;
    }
    setState(() {
      qty--;
    });
  }

  Future _simpan() async {
    final response = await http.post(
        Uri.parse(
            pallete.baseUrl + 'BankSampah/API/create/detailTransaksi.php'),
        body: {
          "id_transaksi": _idTransaksi.toString(),
          "id_kategori": selectedCategory.toString(),
          "id_jenis": selectedJenis.toString(),
          "jumlah": qty.toString(),
          "total_harga": totalHarga.toString()
        });
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<void> getCategories() async {
    try {
      var response = await http
          .get(Uri.parse(pallete.baseUrl + 'BankSampah/API/read/kategori.php'));
      if (response.statusCode == 200) {
        print(response.body);
        List<dynamic> data = jsonDecode(response.body);

        setState(() {
          kategoriOptions = List<Map<String, dynamic>>.from(data);
        });
      } else {
        print('gagal menampilkan kategori: ${response.statusCode}');
      }
    } catch (error) {
      print('error get kategori: $error');
    }
  }

  Future<void> getJenis() async {
    try {
      if (selectedCategory != null) {
        var response = await http.get(Uri.parse(pallete.baseUrl +
            'BankSampah/API/read/jenis.php?id_kategori=$selectedCategory'));
        if (response.statusCode == 200) {
          print(response.body);
          List<dynamic> data = jsonDecode(response.body);
          setState(() {
            jenisOptions = List<Map<String, dynamic>>.from(data);
          });
        } else {
          print('gagal menampilkan jenis: ${response.statusCode}');
        }
      }
    } catch (error) {
      print('error get jenis: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    getCategories();
    getJenis();
    _idTransaksi;
    selectedCategory;
    selectedJenis;
    qty;
    totalHarga;
    print(kategoriOptions);
    print(jenisOptions);
    print(_idTransaksi);
  }

  Widget build(BuildContext context) {
    _idTransaksi = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/input-data');
          },
          icon: Icon(Icons.arrow_back_ios_sharp, color: Colors.black, size: 30),
        ),
        title: Text(
          'Bank Sampah',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w800, color: Colors.black),
        ),
      ),
      body: Form(
        key: formkey,
        child: ListView(children: [
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            height: 510,
            width: 387,
            decoration: BoxDecoration(
              color: Color(0xffE8E8E8),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: 70,
                  width: 387,
                  decoration: BoxDecoration(
                    color: Color(0xff276561),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset('assets/images/image4.png'),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            'Mohon isi data dibawah ini dengan benar',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // pengisian data bank sampah
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  height: 228,
                  width: 364,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 40),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 15),
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            height: 50,
                            width: 271,
                            decoration: BoxDecoration(
                                color: Color(0xffD9D9D9),
                                borderRadius: BorderRadius.circular(5)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DropdownButtonHideUnderline(
                                  child: DropdownButton<Map<String, dynamic>>(
                                    isExpanded: true,
                                    iconEnabledColor: Colors.black,
                                    iconSize: 35,
                                    hint: Text(
                                      'Pilih Kategori Sampah',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    value: selectedCategory != null
                                        ? kategoriOptions.firstWhere(
                                            (element) =>
                                                element['id_kategori'] ==
                                                selectedCategory)
                                        : null,
                                    items: kategoriOptions.map((kategori) {
                                      return DropdownMenuItem<
                                          Map<String, dynamic>>(
                                        value: kategori,
                                        child: Text(kategori['nama_kategori']
                                            as String),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectedCategory =
                                            newValue!['id_kategori'] as String?;
                                        selectedCategoryName =
                                            newValue['nama_kategori']
                                                as String?;
                                        getJenis();
                                        print(selectedCategoryName);
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 15),
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            height: 50,
                            width: 271,
                            decoration: BoxDecoration(
                                color: Color(0xffD9D9D9),
                                borderRadius: BorderRadius.circular(5)),
                            child: Column(
                              children: [
                                DropdownButtonHideUnderline(
                                  child: DropdownButton<Map<String, dynamic>>(
                                    isExpanded: true,
                                    iconEnabledColor: Colors.black,
                                    iconSize: 35,
                                    hint: Text(
                                      'Pilih Jenis Sampah',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    value: selectedJenis != null
                                        ? jenisOptions.firstWhere((element) =>
                                            element['id_jenis'] ==
                                            selectedJenis)
                                        : null,
                                    items: jenisOptions.map((jenis) {
                                      return DropdownMenuItem<
                                          Map<String, dynamic>>(
                                        value: jenis,
                                        child:
                                            Text(jenis['nama_jenis'] as String),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectedJenis =
                                            newValue!['id_jenis'] as String?;
                                        selectedJenisName =
                                            newValue['nama_jenis'] as String?;
                                        selectedJenisHarga =
                                            newValue['harga'] as String;
                                        print(selectedJenis);
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: 35,
                            width: 100,
                            margin: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            decoration: BoxDecoration(
                              color: Color(0xffD9D9D9),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                    onTap: () {
                                      decrementCount();
                                      setState(() {
                                        qty;
                                        print(qty);
                                      });
                                    },
                                    child: Icon(Icons.remove)),
                                Container(
                                  width: 50,
                                  child: TextField(
                                    decoration: InputDecoration(
                                        border: InputBorder.none),
                                    controller:
                                        TextEditingController(text: '$qty'),
                                    onChanged: (newValue) {
                                      qty = int.parse(newValue);
                                      print(qty);
                                    },
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                InkWell(
                                    onTap: () {
                                      incrementCount();
                                      setState(() {
                                        qty;
                                        print(qty);
                                      });
                                    },
                                    child: Icon(Icons.add)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Spacer(),
                    InkWell(
                      onTap: () {},
                      child: Icon(
                        Icons.remove_circle,
                        color: Color(0xff999999),
                        size: 40,
                      ),
                    ),
                    Icon(
                      Icons.add_circle,
                      color: Color(0xff999999),
                      size: 40,
                    ),
                    SizedBox(width: 10),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: 66,
                width: 387,
                decoration: BoxDecoration(
                    color: Color(0xffE8E8E8),
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Harga Satuan  : ${selectedJenisHarga ?? 0}',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Total Harga     : ${totalHarga = int.tryParse(selectedJenisHarga.toString()) != null ? int.tryParse(selectedJenisHarga.toString())! * qty : 0}',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Center(
            child: InkWell(
              onTap: () {
                if (formkey.currentState!.validate()) {
                  _simpan().then((value) {
                    if (value) {
                      final snackBarTrue = SnackBar(
                        content: const Text('Data berhasil di simpan'),
                      );
                      Navigator.pushNamed(context, '/success-page');
                      ScaffoldMessenger.of(context).showSnackBar(snackBarTrue);
                    } else {
                      final SnackBarFalse = SnackBar(
                        content: const Text('Data gagal disimpan'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(SnackBarFalse);
                    }
                  });
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: 53,
                width: 230,
                decoration: BoxDecoration(
                    color: Color(0xff276561),
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                    child: Text(
                  'SIMPAN',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 20),
                )),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ]),
      ),
    );
  }
}
