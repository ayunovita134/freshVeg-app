import 'package:flutter/material.dart';
import 'logo_page.dart';
import 'home_page.dart';
import 'camera_page.dart';
import 'upload_page.dart';
import 'hasil_page.dart';
import 'tips_page.dart';
import 'riwayat_page.dart';

void main() {
  runApp(const FreshVegApp());
}

class FreshVegApp extends StatelessWidget {
  const FreshVegApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FreshVeg',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Poppins',
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LogoPage(),
        '/home': (context) => const HomePage(),
        '/camera': (context) => const CameraPage(),
        '/upload': (context) => const UploadPage(),
        '/hasil': (context) => const HasilPage(),
        '/tips': (context) => const TipsPage(),
        '/riwayat': (context) => const RiwayatPage(),
        
      },
    );
  }
}
