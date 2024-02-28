import 'package:bank_sampah/pages/InputDataKategori.dart';
import 'package:bank_sampah/pages/home_page.dart';
import 'package:bank_sampah/pages/input_data.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bank Sampah',
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => home_page(),
        "/input-data": (context) => input_data(),
        "/input-data-kategori": (context) => InputDataKategori(),
      },
    );
  }
}
