class User {
  String id;
  String NamaBankSampah;
  String NamaPetugas;
  String NamaNasbah;

  User({
    this.id = '',
    required this.NamaBankSampah,
    required this.NamaPetugas,
    required this.NamaNasbah,
  });

  // Metode toJson untuk mengubah objek User menjadi Map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'NamaBankSampah': NamaBankSampah,
      'NamaPetugas': NamaPetugas,
      'NamaNasbah': NamaNasbah,
    };
  }

  static User fromJson(Map<String, dynamic> json) => User(
      NamaBankSampah: json['NamaBankSampah'],
      NamaPetugas: json['NamaPetugas'],
      NamaNasbah: json['NamaNasbah']);
}
