// import 'package:bank_sampah/Model/user.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:bank_sampah/pallete.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class input_data extends StatefulWidget {
  const input_data({super.key});

  @override
  State<input_data> createState() => _input_dataState();
}

class _input_dataState extends State<input_data> {
  final formkey = GlobalKey<FormState>();
  TextEditingController controllerNamaBankSampah = TextEditingController();
  TextEditingController controllerNamaPetugas = TextEditingController();
  TextEditingController controllerNamaNasabah = TextEditingController();
  TextEditingController controllerTanggal = TextEditingController();

  Future _simpan() async {
    final response = await http.post(
        Uri.parse(pallete.baseUrl + 'BankSampah/API/create/transaksi.php'),
        body: {
          "nama_bank_sampah": controllerNamaBankSampah.text,
          "nama_petugas": controllerNamaPetugas.text,
          "nama_nasabah": controllerNamaNasabah.text,
          "tanggal": controllerTanggal.text,
        });
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final int? idTransaksi = responseData['id_transaksi'];
      return idTransaksi;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/');
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
            height: 550,
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
                Column(
                  children: <Widget>[
                    SizedBox(height: 40),
                    // nama bank sampah
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "Nama Bank Sampah",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),

                    // text formfield nama bank sampah
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: SizedBox(
                        width: 270,
                        child: TextFormField(
                          controller: controllerNamaBankSampah,
                          decoration: InputDecoration(
                              hintText: "Masukkan nama bank sampah"),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Nama bank sampah harus diisi";
                            }
                            ;
                            return null;
                          },
                        ),
                      ),
                    ),

                    SizedBox(height: 40),

                    // nama petugas
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "Nama Petugas",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),

                    // text formfield nama petugas
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: SizedBox(
                        width: 270,
                        child: TextFormField(
                          controller: controllerNamaPetugas,
                          decoration: InputDecoration(
                              hintText: "Masukkan nama Petugas"),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Nama petugas harus diisi";
                            }
                            ;
                            return null;
                          },
                        ),
                      ),
                    ),

                    SizedBox(height: 40),

                    // nama nasabah
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "Nama Nasabah",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),

                    // text formfield nama nasabah
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: SizedBox(
                        width: 270,
                        child: TextFormField(
                          controller: controllerNamaNasabah,
                          decoration: InputDecoration(
                              hintText: "Masukkan nama Nasabah"),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Nama nasabah harus diisi";
                            }
                            ;
                            return null;
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 15),
                              height: 44,
                              width: 271,
                              decoration: BoxDecoration(
                                  color: Color(0xffD9D9D9),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 220,
                                    child: TextFormField(
                                      controller: controllerTanggal,
                                      decoration: const InputDecoration(
                                        hintText: 'Pilih Tanggal',
                                        border: UnderlineInputBorder(
                                            borderSide: BorderSide.none),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 15),
                                      ),
                                      readOnly: true,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  InkWell(
                                      onTap: () async {
                                        DateTime? pickedTgl =
                                            await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime(2099),
                                        );
                                        if (pickedTgl != null) {
                                          print(pickedTgl);
                                          String fDate =
                                              DateFormat('yyyy-MM-dd')
                                                  .format(pickedTgl);
                                          print(fDate);

                                          setState(() {
                                            controllerTanggal.text =
                                                fDate; //set foratted date to TextField value.
                                          });
                                        } else {
                                          print("Date is not selected");
                                        }
                                      },
                                      child: Icon(
                                          Icons.keyboard_arrow_down_outlined)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 55),
          Center(
            child: InkWell(
              onTap: () {
                if (formkey.currentState!.validate()) {
                  _simpan().then((idTransaksi) {
                    if (idTransaksi != null) {
                      final snackBarTrue = SnackBar(
                        content: const Text('Data berhasil di simpan'),
                      );
                      Navigator.pushNamed(
                        context,
                        '/InputDetail',
                        arguments: idTransaksi,
                      );
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
                  'LANJUTKAN',
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
// Future createUser(User user) async {
//   final docUser = FirebaseFirestore.instance.collection('users').doc();
//   user.id = docUser.id;
//   final json = user.toJson();
//   await docUser.set(json);
// }
