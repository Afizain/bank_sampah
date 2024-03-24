class detailJenis {
  String? namaKategori;
  String? namaJenis;
  String? ket;
  String? harga;

  detailJenis({this.namaKategori, this.namaJenis, this.ket, this.harga});

  detailJenis.fromJson(Map<String, dynamic> json) {
    namaKategori = json['nama_kategori'];
    namaJenis = json['nama_jenis'];
    ket = json['keterangan'];
    harga = json['harga'];
  }
}
