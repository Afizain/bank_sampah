import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:bank_sampah/pdf/handle.dart';
import 'package:flutter/services.dart';
import 'package:bank_sampah/Model/detailTrans.dart';
import 'package:bank_sampah/pallete.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class InputDataDetail extends StatefulWidget {
  @override
  State<InputDataDetail> createState() => _InputDataDetailState();
}

class _InputDataDetailState extends State<InputDataDetail> {
  final formkey = GlobalKey<FormState>();
  int _idTransaksi = 0;
  List<Map<String, dynamic>> kategoriOptions = [];
  Map<int, List<Map<String, dynamic>>> jenisOptionsMap = {};
  List<InputContainer> containers = [];
  String? Harga;
  int? Amount;
  List<Map<String, dynamic>> joinTransData = [];

  int calculateTotalAmount() {
    int totalAmount = 0;
    for (InputContainer container in containers) {
      totalAmount += container.amount;
    }
    return totalAmount;
  }

  void incrementCount(InputContainer container) {
    setState(() {
      container.quantity++;
      Amount = container.amount =
          int.parse(container.selectedJenisHarga!) * container.quantity;
      print(container.quantity);
      print(Amount);
    });
  }

  void decrementCount(InputContainer container) {
    if (container.quantity < 1) {
      return;
    }
    setState(() {
      container.quantity--;
      Amount = container.amount =
          int.parse(container.selectedJenisHarga!) * container.quantity;
      print(container.quantity);
      print(Amount);
    });
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

  Future<void> getJenis(String? selectedCategory, int index) async {
    try {
      if (selectedCategory != null) {
        var response = await http.get(Uri.parse(pallete.baseUrl +
            'BankSampah/API/read/jenis.php?id_kategori=$selectedCategory'));
        if (response.statusCode == 200) {
          print(response.body);
          List<dynamic> data = jsonDecode(response.body);
          setState(() {
            jenisOptionsMap[index] = List<Map<String, dynamic>>.from(data);
          });
        } else {
          print('gagal menampilkan jenis: ${response.statusCode}');
        }
      }
    } catch (error) {
      print('error get jenis: $error');
    }
  }

  Future saveData() async {
    try {
      List<Map<String, dynamic>> dataToSave = containers.map((container) {
        return {
          'id_transaksi': _idTransaksi,
          'id_kategori': container.selectedCategory,
          'id_jenis': container.selectedJenis,
          'jumlah': container.quantity,
          'amount': container.amount,
        };
      }).toList();

      var response = await http.post(
        Uri.parse(
            pallete.baseUrl + 'BankSampah/API/create/detailTransaksi.php'),
        body: {'data': jsonEncode(dataToSave)},
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print('Error saving data: $error');
    }
  }

  Future<void> getJoinTrans(int _idTransaksi) async {
    try {
      var response = await http.get(Uri.parse(pallete.baseUrl +
          'BankSampah/API/read/joinTrans.php?id_transaksi=$_idTransaksi'));
      if (response.statusCode == 200) {
        // print(response.body);
        List<dynamic> data = jsonDecode(response.body);

        setState(() {
          joinTransData = List<Map<String, dynamic>>.from(data);
          print(joinTransData);
        });
      } else {
        print('gagal menampilkan detail jenis: ${response.statusCode}');
      }
    } catch (error) {
      print('error get detail jenis: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    getCategories();
    _idTransaksi;
    containers.add(InputContainer(quantity: 0));
  }

  @override
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
        child: ListView(
          children: [
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
              child: SingleChildScrollView(
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
                    Column(
                      children: containers.asMap().entries.map((entry) {
                        int index = entry.key;
                        InputContainer container = entry.value;
                        return buildContainer(container, index);
                      }).toList(),
                    ),
                    Row(
                      children: [
                        Spacer(),
                        InkWell(
                          onTap: () {
                            if (containers.length > 1) {
                              setState(() {
                                containers.removeLast();
                              });
                            }
                          },
                          child: Icon(
                            Icons.remove_circle,
                            color: Color(0xff999999),
                            size: 40,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              containers.add(InputContainer());
                            });
                          },
                          child: Icon(
                            Icons.add_circle,
                            color: Color(0xff999999),
                            size: 40,
                          ),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                    SizedBox(height: 10)
                  ],
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(height: 10),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: 80,
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
                            Container(
                              height: 20,
                              width: 100,
                              child: Text(
                                'Harga Satuan',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w800),
                              ),
                            ),
                            SizedBox(width: 20),
                            Container(
                              height: 20,
                              width: 100,
                              child: Text(
                                '${Harga ?? 0}',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w800),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Container(
                              height: 20,
                              width: 100,
                              child: Text(
                                'Total Harga',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w800),
                              ),
                            ),
                            SizedBox(width: 20),
                            Container(
                              height: 20,
                              width: 100,
                              child: Text(
                                '${calculateTotalAmount()}',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w800),
                              ),
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
                onTap: () async {
                  if (formkey.currentState!.validate()) {
                    bool success = await saveData();
                    if (success) {
                      setState(() {
                        getJoinTrans(_idTransaksi).then((_) async {
                          final snackBarTrue = SnackBar(
                            content: const Text('Data berhasil di simpan'),
                          );
                          final pdfFile = await PdfInvoiceApi.generate(
                              PdfColors.black,
                              pw.Font.courier(),
                              joinTransData,
                              calculateTotalAmount());
                          FileHandleApi.openFile(pdfFile);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(snackBarTrue);
                        });
                      });
                      Navigator.pushNamed(context, '/success-page');
                    } else {
                      final SnackBarFalse = SnackBar(
                        content: const Text('Data gagal disimpan'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(SnackBarFalse);
                    }
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
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildContainer(InputContainer container, int index) {
    List<Map<String, dynamic>> jenisOptions = jenisOptionsMap[index] ?? [];
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      height: 228,
      width: 364,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
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
                  borderRadius: BorderRadius.circular(5),
                ),
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
                        value: container.selectedCategory != null
                            ? kategoriOptions.firstWhere((element) =>
                                element['id_kategori'] ==
                                container.selectedCategory)
                            : null,
                        items: kategoriOptions.map((kategori) {
                          return DropdownMenuItem<Map<String, dynamic>>(
                            value: kategori,
                            child: Text(kategori['nama_kategori'] as String),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            container.selectedCategory =
                                newValue!['id_kategori'] as String?;
                            getJenis(container.selectedCategory, index);
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
                        value: container.selectedJenis != null
                            ? jenisOptions.isNotEmpty
                                ? jenisOptions.indexWhere((element) =>
                                            element['id_jenis'] ==
                                            container.selectedJenis) !=
                                        -1
                                    ? jenisOptions[jenisOptions.indexWhere(
                                        (element) =>
                                            element['id_jenis'] ==
                                            container.selectedJenis)]
                                    : null
                                : null
                            : null,
                        items: jenisOptions.map((jenis) {
                          return DropdownMenuItem<Map<String, dynamic>>(
                            value: jenis,
                            child: Text(jenis['nama_jenis'] as String),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            container.selectedJenis =
                                newValue!['id_jenis'] as String?;
                            Harga = container.selectedJenisHarga =
                                newValue['harga'] as String;
                            print(container.selectedJenisHarga);
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
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                decoration: BoxDecoration(
                  color: Color(0xffD9D9D9),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                        onTap: () {
                          decrementCount(container);
                        },
                        child: Icon(Icons.remove)),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(border: InputBorder.none),
                        controller: TextEditingController(
                            text: '${container.quantity}'),
                        onChanged: (newValue) {
                          container.quantity = int.parse(newValue);
                          Amount = container.amount =
                              int.parse(container.selectedJenisHarga!) *
                                  container.quantity;
                          print(container.quantity);
                          print(container.amount);
                        },
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black, fontSize: 16, height: 10),
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          incrementCount(container);
                        },
                        child: Icon(Icons.add)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Membuat PDF
class PdfInvoiceApi {
  static Future<File> generate(PdfColor color, pw.Font fontFamily,
      List<Map<String, dynamic>> joinTransData, int totalAmount) async {
    final pdf = pw.Document();

    final iconImage =
        (await rootBundle.load('assets/images/Logo.png')).buffer.asUint8List();

    String idTransaksi =
        joinTransData.isNotEmpty ? joinTransData[0]['id_transaksi'] : '';
    String namaPetugas =
        joinTransData.isNotEmpty ? joinTransData[0]['nama_petugas'] : '';
    String namaNasabah =
        joinTransData.isNotEmpty ? joinTransData[0]['nama_nasabah'] : '';
    String Tgl = joinTransData.isNotEmpty ? joinTransData[0]['tanggal'] : '';

    final tableHeaders = [
      'Kategori Sampah',
      'Jenis Sampah',
      'Jumlah',
      'Amount',
    ];

    List<List<dynamic>> tableData = joinTransData
        .map((trans) => [
              trans['nama_kategori'],
              trans['nama_jenis'],
              trans['jumlah'].toString(),
              trans['amount'].toString(),
            ])
        .toList();

    pdf.addPage(
      pw.MultiPage(
        build: (context) {
          return [
            pw.Row(
              children: [
                pw.Image(
                  pw.MemoryImage(iconImage),
                  height: 72,
                  width: 72,
                ),
                pw.SizedBox(width: 1 * PdfPageFormat.mm),
                pw.Column(
                  mainAxisSize: pw.MainAxisSize.min,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'BANK SAMPAH',
                      style: pw.TextStyle(
                        fontSize: 17.0,
                        fontWeight: pw.FontWeight.bold,
                        color: color,
                        font: fontFamily,
                      ),
                    ),
                  ],
                ),
                pw.Spacer(),
                pw.Column(
                  mainAxisSize: pw.MainAxisSize.min,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                ),
              ],
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Divider(),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              'Nama Petugas :$namaPetugas\nNama Nasabah :$namaNasabah\nTanggal :$Tgl',
              textAlign: pw.TextAlign.justify,
              style: pw.TextStyle(
                fontSize: 14.0,
                color: color,
                font: fontFamily,
              ),
            ),
            pw.SizedBox(height: 5 * PdfPageFormat.mm),

            ///
            /// PDF Table Create
            ///
            pw.Table.fromTextArray(
              headers: tableHeaders,
              data: tableData,
              border: null,
              headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              headerDecoration:
                  const pw.BoxDecoration(color: PdfColors.grey300),
              cellHeight: 30.0,
              cellAlignments: {
                0: pw.Alignment.centerLeft,
                1: pw.Alignment.centerRight,
                2: pw.Alignment.centerRight,
                3: pw.Alignment.centerRight,
                4: pw.Alignment.centerRight,
              },
            ),
            pw.Divider(),
            pw.Container(
              alignment: pw.Alignment.centerRight,
              child: pw.Row(
                children: [
                  pw.Spacer(flex: 6),
                  pw.Expanded(
                    flex: 4,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Row(),
                        pw.Row(),
                        pw.Divider(),
                        pw.Row(
                          children: [
                            pw.Expanded(
                              child: pw.Text(
                                'Total',
                                style: pw.TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: pw.FontWeight.bold,
                                  color: color,
                                  font: fontFamily,
                                ),
                              ),
                            ),
                            pw.Text(
                              'Rp.$totalAmount',
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                color: color,
                                font: fontFamily,
                              ),
                            ),
                          ],
                        ),
                        pw.SizedBox(height: 2 * PdfPageFormat.mm),
                        pw.Container(height: 1, color: PdfColors.grey400),
                        pw.SizedBox(height: 0.5 * PdfPageFormat.mm),
                        pw.Container(height: 1, color: PdfColors.grey400),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ];
        },
        footer: (context) {
          return pw.Column(
            mainAxisSize: pw.MainAxisSize.min,
          );
        },
      ),
    );

    return FileHandleApi.saveDocument(
        name: 'Report BS $idTransaksi.pdf', pdf: pdf);
  }
}
