import 'package:flutter/material.dart';
import 'package:rumah_sakit_flutter_fanntt/model/rumahsakit_model.dart';
import '/services/api_service.dart';

class UpdateRumahSakitPage extends StatefulWidget {
  final RumahSakit rs;
  UpdateRumahSakitPage({required this.rs});

  @override
  _UpdateRumahSakitPageState createState() => _UpdateRumahSakitPageState();
}

class _UpdateRumahSakitPageState extends State<UpdateRumahSakitPage> {
  final _formKey = GlobalKey<FormState>();
  final _apiService = ApiService();

  late TextEditingController namaController;
  late TextEditingController alamatController;
  late TextEditingController noTelponController;
  late TextEditingController tipeController;
  late TextEditingController latitudeController;
  late TextEditingController longitudeController;

  @override
  void initState() {
    super.initState();
    namaController = TextEditingController(text: widget.rs.nama);
    alamatController = TextEditingController(text: widget.rs.alamat);
    noTelponController = TextEditingController(text: widget.rs.noTelpon);
    tipeController = TextEditingController(text: widget.rs.tipe);
    latitudeController = TextEditingController(text: widget.rs.latitude.toString());
    longitudeController = TextEditingController(text: widget.rs.longitude.toString());
  }

  void _update() async {
    if (_formKey.currentState!.validate()) {
      final updatedRs = RumahSakit(
        no: widget.rs.no,
        nama: namaController.text,
        alamat: alamatController.text,
        noTelpon: noTelponController.text,
        tipe: tipeController.text,
        latitude: double.parse(latitudeController.text),
        longitude: double.parse(longitudeController.text),
      );

      await _apiService.updateRumahSakit(widget.rs.no, updatedRs);
      Navigator.pop(context); // kembali ke detail/list
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update Rumah Sakit')),
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
                onPressed: _update,
                child: Text('Update'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
