import 'package:bank_sampah/pages/InputDataKategori.dart';
import 'package:bank_sampah/pages/coba.dart';
import 'package:bank_sampah/pages/home_page.dart';
import 'package:bank_sampah/pages/input_data.dart';
import 'package:bank_sampah/pages/success_page.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
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
        "/home": (context) => home_page(),
        "/input-data": (context) => input_data(),
        "/cobaa": (context) => InputDataDetail(),
        "/success-page": (context) => success_page(),
        "/": (context) => MyForm(),
      },
    );
  }
}
