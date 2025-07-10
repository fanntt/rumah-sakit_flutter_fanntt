import 'package:flutter/material.dart';
import 'package:rumah_sakit_flutter_fanntt/screens/detail_rumahsakit.dart';
import 'package:rumah_sakit_flutter_fanntt/screens/tambah_rumahsakit.dart';
import '/services/api_service.dart';
import 'package:rumah_sakit_flutter_fanntt/model/rumahsakit_model.dart';

class ListRumahSakitPage extends StatefulWidget {
  @override
  _ListRumahSakitPageState createState() => _ListRumahSakitPageState();
}

class _ListRumahSakitPageState extends State<ListRumahSakitPage> {
  final apiService = ApiService();
  late Future<List<RumahSakit>> _futureRumahSakit;

  @override
  void initState() {
    super.initState();
    _loadRumahSakit();
  }

  void _loadRumahSakit() {
    _futureRumahSakit = apiService.getAllRumahSakit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Daftar Rumah Sakit")),
      body: FutureBuilder<List<RumahSakit>>(
        future: _futureRumahSakit,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Terjadi kesalahan: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Data rumah sakit kosong.'));
          } else {
            List<RumahSakit> data = snapshot.data!;
            return RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  _loadRumahSakit();
                });
              },
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (_, i) => ListTile(
                  title: Text(data[i].nama),
                  subtitle: Text(data[i].alamat),
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailRumahSakitPage(rs: data[i]),
                      ),
                    );
                    setState(() {
                      _loadRumahSakit();
                    });
                  },
                ),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => TambahRumahSakitPage()),
          );
          setState(() {
            _loadRumahSakit();
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
