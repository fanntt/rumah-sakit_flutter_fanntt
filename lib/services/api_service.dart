import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rumah_sakit_flutter_fanntt/model/rumahsakit_model.dart';

class ApiService {
  final String baseUrl = 'http://192.168.242.234:8000/api';

  Future<List<RumahSakit>> getAllRumahSakit() async {
    final response = await http.get(Uri.parse('$baseUrl/rumah-sakit'));
    print("STATUS: ${response.statusCode}");
    print("BODY: ${response.body}");
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((e) => RumahSakit.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }



  }

  Future<void> tambahRumahSakit(RumahSakit rs) async {
    await http.post(
      Uri.parse('$baseUrl/rumah-sakit'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(rs.toJson()),
    );
  }

  Future<void> updateRumahSakit(int no, RumahSakit rs) async {
    await http.put(
      Uri.parse('$baseUrl/rumah-sakit/$no'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(rs.toJson()),
    );
  }

  Future<void> deleteRumahSakit(int no) async {
    await http.delete(Uri.parse('$baseUrl/rumah-sakit/$no'));
  }
}
