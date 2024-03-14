// import 'package:bank_sampah/Model/user.dart';
import 'package:flutter/material.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class InputDataDetail extends StatefulWidget {
  @override
  State<InputDataDetail> createState() => _InputDataDetailState();
}

class _InputDataDetailState extends State<InputDataDetail> {
  String? selectedCategory;
  String? selectedJenis;
  List<Map<String, dynamic>> kategoriOptions = [];
  List<Map<String, dynamic>> jenisOptions = [];

  @override
  void initState() {
    super.initState();
    getCategories();
    getJenis();
    print(kategoriOptions);
    print(jenisOptions);
  }

  Future<void> getCategories() async {
    try {
      var response = await http
          .get(Uri.parse('http://192.168.1.22/BankSampah/API/kategori.php'));
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
        var response = await http.get(Uri.parse(
            'http://192.168.1.22/BankSampah/API/jenis.php?id_kategori=$selectedCategory'));
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

  Widget build(BuildContext context) {
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
      body: ListView(children: [
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
                                      ? kategoriOptions.firstWhere((element) =>
                                          element['nama_kategori'] ==
                                          selectedCategory)
                                      : null,
                                  items: kategoriOptions.map((kategori) {
                                    return DropdownMenuItem<
                                        Map<String, dynamic>>(
                                      value: kategori,
                                      child: Text(
                                          kategori['nama_kategori'] as String),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedCategory =
                                          newValue!['nama_kategori'] as String?;
                                      getJenis();
                                      print(selectedCategory);
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
                                          element['nama_jenis'] ==
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
                                          newValue!['nama_jenis'] as String?;
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
                          decoration: BoxDecoration(
                            color: Color(0xffD9D9D9),
                          ),
                          child: InputQty(
                            maxVal: 100,
                            initVal: 0,
                            minVal: -100,
                            steps: 1,
                            onQtyChanged: (val) {
                              print(val);
                            },
                          ),
                          margin: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          // child: SizedBox(
                          //   width: 150,
                          //   child: InputQty(
                          //     maxVal: 100,
                          //     initVal: 0,
                          //     minVal: -100,
                          //     steps: 1,
                          //     onQtyChanged: (val) {
                          //       print(val);
                          //     },
                          //   ),
                          // ),
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
                          'Total Jumlah  : 0',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Total Harga     : 0',
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
              Navigator.pushNamed(context, '/success-page');
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
    );
  }
}

  // Widget buidlUser(User user) => ListTile(
  //       title: Text(user.NamaBankSampah),
  //       subtitle: Text(user.NamaNasbah),
  //     );
  // Stream<List<User>> readUser() => FirebaseFirestore.instance
  //     .collection('users')
  //     .snapshots()
  //     .map((snapshot) =>
  //         snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());

  //  drop down

  // DropdownButton(
  //   hint: Text('Select Item'),
  // items: snapshot.data!.docs
  //     .map((DocumentSnapshot document) {
  //   return DropdownMenuItem(
  //     value: document.id,
  //     child: Text(document['Kategori']),
  //   );
  // }).toList(),
  //   onChanged: (newValue) {
  // setState(() {
  //   selectedCategory = newValue;
  // });
  //     // Lakukan sesuatu dengan nilai yang dipilih
  //     print('Selected Item: $newValue');
  //   },
  // );
