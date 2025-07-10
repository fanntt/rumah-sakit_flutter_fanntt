class RumahSakit {
  final int no;
  final String nama;
  final String alamat;
  final String noTelpon;
  final String tipe;
  final double latitude;
  final double longitude;

  RumahSakit({
    required this.no,
    required this.nama,
    required this.alamat,
    required this.noTelpon,
    required this.tipe,
    required this.latitude,
    required this.longitude,
  });

  factory RumahSakit.fromJson(Map<String, dynamic> json) {
    return RumahSakit(
      no: json['no'],
      nama: json['nama'],
      alamat: json['alamat_lengkap'],
      noTelpon: json['no_telepon'],
      tipe: json['tipe'],
      latitude: double.parse(json['latitude'].toString()),
      longitude: double.parse(json['longitude'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'alamat_lengkap': alamat,
      'no_telepon': noTelpon,
      'tipe': tipe,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
