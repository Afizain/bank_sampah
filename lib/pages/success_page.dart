import 'package:flutter/material.dart';

class success_page extends StatelessWidget {
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
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 150,
            ),
            height: 315,
            width: 387,
            decoration: BoxDecoration(
                color: Color(0xff276561),
                borderRadius: BorderRadius.circular(25)),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 50),
                  width: 207,
                  height: 164,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage('assets/images/image5.png'),
                    fit: BoxFit.fill,
                  )),
                ),
                Container(
                  width: 241,
                  margin: EdgeInsets.only(top: 5),
                  child: Text(
                    'Data Bank Sampah Berhasil Disimpan',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w800),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              SizedBox(height: 140),
              Container(
                height: 43,
                width: 178,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(15)),
                child: Icon(
                  Icons.share,
                  size: 35,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
