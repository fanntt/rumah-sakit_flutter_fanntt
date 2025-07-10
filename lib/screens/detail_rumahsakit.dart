import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rumah_sakit_flutter_fanntt/model/rumahsakit_model.dart';
import 'package:rumah_sakit_flutter_fanntt/screens/update_rumahsakit.dart';
import '../services/api_service.dart';

class DetailRumahSakitPage extends StatelessWidget {
  final RumahSakit rs;
  final ApiService api = ApiService();

  DetailRumahSakitPage({required this.rs});

  @override
  Widget build(BuildContext context) {
    final LatLng lokasi = LatLng(rs.latitude, rs.longitude);

    return Scaffold(
      appBar: AppBar(title: Text(rs.nama)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: lokasi,
                  zoom: 16,
                ),
                markers: {
                  Marker(
                    markerId: MarkerId('lokasi_rs'),
                    position: lokasi,
                    infoWindow: InfoWindow(title: rs.nama),
                  )
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Nama: ${rs.nama}", style: TextStyle(fontSize: 16)),
                  SizedBox(height: 8),
                  Text("Alamat: ${rs.alamat}", style: TextStyle(fontSize: 16)),
                  SizedBox(height: 8),
                  Text("No. Telepon: ${rs.noTelpon}", style: TextStyle(fontSize: 16)),
                  SizedBox(height: 8),
                  Text("Tipe: ${rs.tipe}", style: TextStyle(fontSize: 16)),
                  SizedBox(height: 8),
                  Text("Latitude: ${rs.latitude}", style: TextStyle(fontSize: 16)),
                  Text("Longitude: ${rs.longitude}", style: TextStyle(fontSize: 16)),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        icon: Icon(Icons.edit),
                        label: Text("Edit"),
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => UpdateRumahSakitPage(rs: rs),
                            ),
                          );

                          if (result == true) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Data berhasil diperbarui')),
                            );
                            Navigator.pop(context, true); // kembali dan trigger refresh
                          }
                        },
                      ),
                      ElevatedButton.icon(
                        icon: Icon(Icons.delete),
                        label: Text("Delete"),
                        onPressed: () async {
                          bool confirm = await showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: Text('Konfirmasi Hapus'),
                              content: Text('Apakah Anda yakin ingin menghapus data ini?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(ctx, false),
                                  child: Text('Batal'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(ctx, true),
                                  child: Text('Hapus', style: TextStyle(color: Colors.red)),
                                ),
                              ],
                            ),
                          );

                          if (confirm) {
                            await api.deleteRumahSakit(rs.no);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Data berhasil dihapus')),
                            );
                            Navigator.pop(context, true); // kembali dan trigger refresh
                          }
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
