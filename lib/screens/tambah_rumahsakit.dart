import 'package:flutter/material.dart';
import 'package:rumah_sakit_flutter_fanntt/model/rumahsakit_model.dart';
import '/services/api_service.dart';

class TambahRumahSakitPage extends StatefulWidget {
  @override
  _TambahRumahSakitPageState createState() => _TambahRumahSakitPageState();
}

class _TambahRumahSakitPageState extends State<TambahRumahSakitPage> {
  final _formKey = GlobalKey<FormState>();
  final _apiService = ApiService();

  final namaController = TextEditingController();
  final alamatController = TextEditingController();
  final noTelponController = TextEditingController();
  final tipeController = TextEditingController();
  final latitudeController = TextEditingController();
  final longitudeController = TextEditingController();

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      final rs = RumahSakit(
        no: 0, // id biasanya auto increment di backend
        nama: namaController.text,
        alamat: alamatController.text,
        noTelpon: noTelponController.text,
        tipe: tipeController.text,
        latitude: double.parse(latitudeController.text),
        longitude: double.parse(longitudeController.text),
      );

      await _apiService.tambahRumahSakit(rs);
      Navigator.pop(context); // kembali ke list
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tambah Rumah Sakit')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: namaController,
                decoration: InputDecoration(labelText: 'Nama Rumah Sakit'),
                validator: (value) => value!.isEmpty ? 'Tidak boleh kosong' : null,
              ),
              TextFormField(
                controller: alamatController,
                decoration: InputDecoration(labelText: 'Alamat Lengkap'),
                validator: (value) => value!.isEmpty ? 'Tidak boleh kosong' : null,
              ),
              TextFormField(
                controller: noTelponController,
                decoration: InputDecoration(labelText: 'No Telepon'),
                keyboardType: TextInputType.phone,
                validator: (value) => value!.isEmpty ? 'Tidak boleh kosong' : null,
              ),
              TextFormField(
                controller: tipeController,
                decoration: InputDecoration(labelText: 'Tipe Rumah Sakit'),
                validator: (value) => value!.isEmpty ? 'Tidak boleh kosong' : null,
              ),
              TextFormField(
                controller: latitudeController,
                decoration: InputDecoration(labelText: 'Latitude'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Masukkan angka' : null,
              ),
              TextFormField(
                controller: longitudeController,
                decoration: InputDecoration(labelText: 'Longitude'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Masukkan angka' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: Text('Simpan'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
