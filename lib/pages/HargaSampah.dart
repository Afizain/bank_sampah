import 'package:bank_sampah/pallete.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:grouped_list/grouped_list.dart';

class hargaSampah extends StatefulWidget {
  @override
  State<hargaSampah> createState() => _hargaSampahState();
}

class _hargaSampahState extends State<hargaSampah> {
  List<Map<String, dynamic>> detailJenis = [];

  Future<void> getDetailjenis() async {
    try {
      var response = await http.get(
          Uri.parse(pallete.baseUrl + 'BankSampah/API/read/joinJenis.php'));
      if (response.statusCode == 200) {
        print(response.body);
        List<dynamic> data = jsonDecode(response.body);

        setState(() {
          detailJenis = List<Map<String, dynamic>>.from(data);
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
    getDetailjenis();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xff276561),
          leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
            icon:
                Icon(Icons.arrow_back_ios_sharp, color: Colors.white, size: 30),
          ),
          title: Text(
            'Harga Sampah',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white),
          ),
        ),
        body: GroupedListView(
          useStickyGroupSeparators: false,
          itemComparator: (element1, element2) =>
              element1['nama_jenis'].compareTo(element2['nama_jenis']),
          elements: detailJenis,
          groupBy: (element) => element['nama_kategori'],
          groupSeparatorBuilder: (value) => Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Color(0xff276561),
            child: Text(value,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16)),
          ),
          itemBuilder: (context, element) => Card(
            elevation: 4,
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              title: Text(element['nama_jenis']),
              trailing: Text('RP. ${element['harga']}'),
              subtitle: Text(element['keterangan']),
            ),
          ),
        ));
  }
}
