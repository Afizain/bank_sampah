import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:bank_sampah/pallete.dart';
import 'package:http/http.dart' as http;

class kategoriReport extends StatefulWidget {
  @override
  State<kategoriReport> createState() => _kategoriReportState();
}

class _kategoriReportState extends State<kategoriReport> {
  List<Map<String, dynamic>> dataLprnKategori = [];

  Future<void> getLprnKategori() async {
    try {
      var response = await http.get(
          Uri.parse(pallete.baseUrl + 'BankSampah/API/read/joinTrans.php'));
      if (response.statusCode == 200) {
        print(response.body);
        List<dynamic> data = jsonDecode(response.body);

        setState(() {
          dataLprnKategori = List<Map<String, dynamic>>.from(data);
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
    getLprnKategori();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff276561),
          elevation: 4,
          title: Text('Laporan Kategori'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: DataTable(
              headingRowColor:
                  MaterialStateColor.resolveWith((states) => Color(0xff276561)),
              columns: [
                DataColumn(
                  label:
                      Text('Kategori', style: TextStyle(color: Colors.white)),
                ),
                DataColumn(
                  label: Text('Jenis', style: TextStyle(color: Colors.white)),
                ),
                DataColumn(
                  label: Text('Qty', style: TextStyle(color: Colors.white)),
                ),
                DataColumn(
                  label: Text('Amount', style: TextStyle(color: Colors.white)),
                ),
              ],
              rows: dataLprnKategori
                  .map(
                    (e) => DataRow(cells: [
                      DataCell(Text(e['nama_kategori'])),
                      DataCell(Text(e['nama_jenis'])),
                      DataCell(Text(e['jumlah'])),
                      DataCell(Text(e['amount'])),
                    ]),
                  )
                  .toList()),
        ));
  }
}
