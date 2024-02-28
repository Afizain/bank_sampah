import 'package:flutter/material.dart';

class InputDataKategori extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      body: ListView(children: [
        SizedBox(height: 20),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          height: 530,
          width: 387,
          decoration: BoxDecoration(
            color: Color(0xffE8E8E8),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35),
              topRight: Radius.circular(35),
            ),
          ),
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
              // pengisian data bank sampah
              Column(
                children: <Widget>[
                  SizedBox(height: 40),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        height: 44,
                        width: 271,
                        decoration: BoxDecoration(
                            color: Color(0xffD9D9D9),
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 15),
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: Text(
                                'Pilih Kategori Sampah',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                            ),
                            Spacer(),
                            InkWell(
                                onTap: () {},
                                child: Icon(
                                  Icons.arrow_drop_down,
                                  size: 40,
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
        SizedBox(height: 55),
        Center(
          child: InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: 53,
              width: 230,
              decoration: BoxDecoration(
                  color: Color(0xff276561),
                  borderRadius: BorderRadius.circular(20)),
              child: Center(
                  child: Text(
                'LANJUTKAN',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 20),
              )),
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
      ]),
    );
  }
}
