import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:bank_sampah/pallete.dart';
import 'package:http/http.dart' as http;

class nasabahReport extends StatefulWidget {
  @override
  State<nasabahReport> createState() => _nasabahReportState();
}

class _nasabahReportState extends State<nasabahReport> {
  List<Map<String, dynamic>> dataLprnNasabah = [];

  Future<void> getLprnNasabah() async {
    try {
      var response = await http.get(
          Uri.parse(pallete.baseUrl + 'BankSampah/API/read/transaksi.php'));
      if (response.statusCode == 200) {
        print(response.body);
        List<dynamic> data = jsonDecode(response.body);

        setState(() {
          dataLprnNasabah = List<Map<String, dynamic>>.from(data);
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
    getLprnNasabah();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 101, 39, 39),
          elevation: 4,
          title: Text('Laporan Nasabah'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Container(
            width: 400,
            child: DataTable(
                headingRowColor: MaterialStateColor.resolveWith(
                    (states) => Color.fromARGB(255, 101, 39, 39)),
                columns: [
                  DataColumn(
                    label:
                        Text('Tanggal', style: TextStyle(color: Colors.white)),
                  ),
                  DataColumn(
                    label: Text('nama_nasabah',
                        style: TextStyle(color: Colors.white)),
                  ),
                  DataColumn(
                    label:
                        Text('Jumlah', style: TextStyle(color: Colors.white)),
                  ),
                ],
                rows: dataLprnNasabah
                    .map(
                      (e) => DataRow(cells: [
                        DataCell(Text(e['tanggal'])),
                        DataCell(Text(e['nama_nasabah'])),
                        DataCell(Text(e['nama_bank'])),
                      ]),
                    )
                    .toList()),
          ),
        ));
  }
}
