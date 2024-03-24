import 'package:flutter/material.dart';

class home_page extends StatelessWidget {
  const home_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(top: 68, left: 20),
            child: Text('Selamat Datang',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
          ),
          Column(
            children: [
              // SizedBox(height: 15),
              // Container(
              //   margin: EdgeInsets.symmetric(horizontal: 15),
              //   padding: EdgeInsets.symmetric(horizontal: 15),
              //   height: 42,
              //   width: 326,
              //   decoration: BoxDecoration(
              //       color: Color(0xffE4E4E4),
              //       borderRadius: BorderRadius.circular(25)),
              //   child: Row(
              //     children: [
              //       Icon(Icons.location_on_outlined),
              //       Padding(
              //         padding: const EdgeInsets.only(left: 5),
              //         child: Text(
              //           'Denpasar, Bali',
              //           style: TextStyle(
              //               fontSize: 16, fontWeight: FontWeight.bold),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: 1,
            width: 369,
            decoration: BoxDecoration(color: Colors.black),
          ),
          SizedBox(height: 30),
          Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: 170,
                width: 326,
                decoration: BoxDecoration(
                    color: Color(0xffE4E4E4),
                    borderRadius: BorderRadius.circular(25)),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 40, bottom: 8),
                            child: Text(
                              'Bank Sampah',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w800),
                            ),
                          ),
                          Text(
                            'Aplikasi Bank Sampah adalah solusi untuk menyelesaikan masalah sosial tentang kebersihan lingkungan',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 104,
                      height: 108,
                      margin: EdgeInsets.only(left: 5),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/image1.png'),
                          fit: BoxFit.fill,
                        ),
                        shape: BoxShape.rectangle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(left: 35),
            margin: EdgeInsets.only(top: 28, bottom: 28),
            height: 19,
            width: 100,
            child: Text(
              'Menu Kategori',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
            ),
          ),
          Column(
            children: [
              InkWell(
                onTap: () => Navigator.pushNamed(context, '/input-data'),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: 187,
                  width: 326,
                  decoration: BoxDecoration(
                      color: Color(0xffE4E4E4),
                      borderRadius: BorderRadius.circular(25)),
                  child: Row(
                    children: [
                      Container(
                        width: 104,
                        height: 108,
                        margin: EdgeInsets.only(left: 5),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/image2.png'),
                            fit: BoxFit.fill,
                          ),
                          shape: BoxShape.rectangle,
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Center(
                        child: Text(
                          'Input Sampah',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w800),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () => Navigator.pushNamed(context, '/harga-sampah'),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: 187,
                  width: 326,
                  decoration: BoxDecoration(
                      color: Color(0xffE4E4E4),
                      borderRadius: BorderRadius.circular(25)),
                  child: Row(
                    children: [
                      Container(
                        width: 104,
                        height: 108,
                        margin: EdgeInsets.only(left: 5),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/image3.png'),
                            fit: BoxFit.fill,
                          ),
                          shape: BoxShape.rectangle,
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Center(
                        child: Text(
                          'Harga Sampah',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w800),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () => Navigator.pushNamed(context, '/laporan-page'),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: 187,
                  width: 326,
                  decoration: BoxDecoration(
                      color: Color(0xffE4E4E4),
                      borderRadius: BorderRadius.circular(25)),
                  child: Row(
                    children: [
                      Container(
                        width: 104,
                        height: 108,
                        margin: EdgeInsets.only(left: 5),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/logo_riwayat.png'),
                            fit: BoxFit.fill,
                          ),
                          shape: BoxShape.rectangle,
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Center(
                        child: Text(
                          'Laporan',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w800),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class laporanList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff276561),
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/');
          },
          icon: Icon(Icons.arrow_back_ios_sharp, color: Colors.white, size: 30),
        ),
        title: Text(
          'Laporan',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white),
        ),
      ),
      body: ListView(
        children: <Widget>[
          InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/transaksiReport-page');
              },
              child: Card(child: _SampleCard(cardName: 'Laporan Transaksi'))),
          InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/kategoriReport-page');
              },
              child: Card(child: _SampleCard(cardName: 'Laporan Kategori'))),
          InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/nasabahReport-page');
              },
              child: Card(child: _SampleCard(cardName: 'Laporan Nasabah'))),
        ],
      ),
    );
  }
}

class _SampleCard extends StatelessWidget {
  const _SampleCard({required this.cardName});
  final String cardName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 300,
        height: 50,
        child: Row(
          children: [
            Text(cardName,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal)),
          ],
        ),
      ),
    );
  }
}
