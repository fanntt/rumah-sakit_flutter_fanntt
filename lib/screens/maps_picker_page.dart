import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsPickerPage extends StatefulWidget {
  @override
  _MapsPickerPageState createState() => _MapsPickerPageState();
}

class _MapsPickerPageState extends State<MapsPickerPage> {
  LatLng? pickedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pilih Lokasi Rumah Sakit')),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(-6.200000, 106.816666), // Jakarta (default)
          zoom: 14,
        ),
        onTap: (LatLng latLng) {
          setState(() {
            pickedLocation = latLng;
          });
        },
        markers: pickedLocation != null
            ? {
          Marker(
            markerId: MarkerId('picked'),
            position: pickedLocation!,
          )
        }
            : {},
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: pickedLocation != null
            ? () {
          Navigator.pop(context, pickedLocation);
        }
            : null,
        child: Icon(Icons.check),
      ),
    );
  }
}
