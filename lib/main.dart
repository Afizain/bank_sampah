import 'package:bank_sampah/pages/HargaSampah.dart';
import 'package:bank_sampah/pages/InputDataDetail.dart';
import 'package:bank_sampah/pages/InputDataDetail2.dart';
import 'package:bank_sampah/pages/Laporan/kategoriReport.dart';
import 'package:bank_sampah/pages/Laporan/nasabahReport.dart';
import 'package:bank_sampah/pages/Laporan/transaksiReport.dart';
import 'package:bank_sampah/pages/home_page.dart';
import 'package:bank_sampah/pages/input_data.dart';
import 'package:bank_sampah/pages/success_page.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bank Sampah',
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => home_page(),
        "/input-data": (context) => input_data(),
        "/InputDetail": (context) => InputDataDetail(),
        "/InputDetail2": (context) => InputDataDetail2(),
        "/harga-sampah": (context) => hargaSampah(),
        "/success-page": (context) => success_page(),

        // Laporan
        "/laporan-page": (context) => laporanList(),
        "/transaksiReport-page": (context) => transaksiReport(),
        "/kategoriReport-page": (context) => kategoriReport(),
        "/nasabahReport-page": (context) => nasabahReport(),
      },
    );
  }
}
