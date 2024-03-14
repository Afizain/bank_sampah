import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? selectedCategory;
  List<Map<String, dynamic>> categoryOptions = [];

  String result = '';

  @override
  void initState() {
    super.initState();
    fetchCategories();
    print(categoryOptions);
  }

  Future<void> fetchCategories() async {
    try {
      var response = await http
          .get(Uri.parse('http://192.168.1.22/BankSampah/API/kategori.php'));
      if (response.statusCode == 200) {
        print(response.body);
        List<dynamic> data = jsonDecode(response.body);
        setState(() {
          categoryOptions = List<Map<String, dynamic>>.from(data);
        });
      } else {
        print('Failed to fetch categories: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching categories: $error');
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        result = 'Selected Category: $selectedCategory';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Example'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField<Map<String, dynamic>>(
                decoration: const InputDecoration(
                  labelText: 'Category',
                ),
                value: selectedCategory != null
                    ? categoryOptions.firstWhere((element) =>
                        element['nama_kategori'] == selectedCategory)
                    : null,
                items: categoryOptions.map((category) {
                  return DropdownMenuItem<Map<String, dynamic>>(
                    value: category,
                    child: Text(category['nama_kategori'] as String),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedCategory = newValue!['nama_kategori'] as String?;
                  });
                },
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit'),
              ),
              const SizedBox(height: 20.0),
              Text(
                result,
                style: const TextStyle(fontSize: 18.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
