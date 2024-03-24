import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:bank_sampah/pallete.dart';
import 'package:http/http.dart' as http;

class transaksiReport extends StatefulWidget {
  @override
  State<transaksiReport> createState() => _transaksiReportState();
}

class _transaksiReportState extends State<transaksiReport> {
  List<Map<String, dynamic>> dataLprnTransaksi = [];

  Future<void> getLprnTransaksi() async {
    try {
      var response = await http.get(
          Uri.parse(pallete.baseUrl + 'BankSampah/API/read/transaksi.php'));
      if (response.statusCode == 200) {
        print(response.body);
        List<dynamic> data = jsonDecode(response.body);

        setState(() {
          dataLprnTransaksi = List<Map<String, dynamic>>.from(data);
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
    getLprnTransaksi();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 39, 47, 101),
          elevation: 4,
          title: Text('Laporan Transaksi'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Container(
            width: 400,
            child: DataTable(
                headingRowColor: MaterialStateColor.resolveWith(
                    (states) => Color.fromARGB(255, 39, 47, 101)),
                columns: [
                  DataColumn(
                    label: Text('Id', style: TextStyle(color: Colors.white)),
                  ),
                  DataColumn(
                    label: Text('Bank Sampah',
                        style: TextStyle(color: Colors.white)),
                  ),
                  DataColumn(
                    label:
                        Text('Tanggal', style: TextStyle(color: Colors.white)),
                  ),
                ],
                rows: dataLprnTransaksi
                    .map(
                      (e) => DataRow(cells: [
                        DataCell(Text(e['id_transaksi'])),
                        DataCell(Text(e['nama_bank'])),
                        DataCell(Text(e['tanggal'])),
                      ]),
                    )
                    .toList()),
          ),
        ));
  }
}
