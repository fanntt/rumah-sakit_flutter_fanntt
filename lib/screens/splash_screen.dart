import 'package:flutter/material.dart';
import 'list_rumahsakit.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => ListRumahSakitPage()),
      );
    });

    return Scaffold(
      body: Center(child: Text("Rumah Sakit App", style: TextStyle(fontSize: 24))),
    );
  }
}
