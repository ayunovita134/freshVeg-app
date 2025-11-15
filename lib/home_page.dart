import 'package:flutter/material.dart';
import 'camera_page.dart';
import 'upload_page.dart';
import 'tips_page.dart';
import 'riwayat_page.dart';
import 'models/history_item.dart';
import 'services/history_service.dart';
import 'dart:io';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<HistoryItem> _historyList = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final history = await HistoryService.getHistoryList();
    setState(() {
      _historyList = history.reversed.take(3).toList(); // Show latest 3
    });
  }

  // Navigation handler
  void _onNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      // Already on Home Page
    } else if (index == 1) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const CameraPage()));
    } else if (index == 2) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const TipsPage()));
    } else if (index == 3) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const RiwayatPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ---------------- BODY ----------------
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo kanan atas
              Align(
                alignment: Alignment.topRight,
                child: Image.asset(
                  'assets/logo.png',
                  width: 55,
                ),
              ),

              const SizedBox(height: 15),

              // Judul
              Text(
                "Ayo Cek Tingkat\nKesegaran Sayurmu\nHari ini !",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.teal.shade900,
                  fontWeight: FontWeight.w800,
                  height: 1.2,
                ),
              ),

              const SizedBox(height: 30),

              // Tombol Kamera
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const CameraPage()));
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.teal.shade900,
                    borderRadius: BorderRadius.circular(35)
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.camera_alt_outlined,
                          color: Colors.white),
                      const SizedBox(width: 12),
                      const Text(
                        "Mulai Pemindaian Kamera",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // Tombol Upload
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const UploadPage()));
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(35),
                    border: Border.all(color: Colors.teal.shade900, width: 2),
                    boxShadow: [
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.photo_library_outlined,
                          color: Colors.teal.shade900),
                      const SizedBox(width: 12),
                      Text(
                        "Unggah Gambar Dari Galeri",
                        style: TextStyle(
                          color: Colors.teal.shade900,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 35),

              // Riwayat title
              const Text(
                "Riwayat",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 12),

              // Riwayat List
              for (var item in _historyList)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _historyItem(
                    image: item.imagePath,
                    title: "Kentang",
                    status: item.result == 'FreshPotato' ? 'Segar' : 'Busuk',
                    desc: "${item.timestamp.day}/${item.timestamp.month}/${item.timestamp.year}",
                  ),
                ),
            ],
          ),
        ),
      ),

      // ---------------- NAV BAR ----------------
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavTap,
        selectedItemColor: Colors.teal.shade900,
        unselectedItemColor: Colors.grey.shade600,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: "Beranda"),
          BottomNavigationBarItem(
              icon: Icon(Icons.camera_alt_outlined), label: "Scan"),
          BottomNavigationBarItem(
              icon: Icon(Icons.info_outline), label: "Tips"),
          BottomNavigationBarItem(
              icon: Icon(Icons.history), label: "Riwayat"),
        ],
      ),
    );
  }

  // ================= HISTORY ITEM WIDGET =================

  Widget _historyItem({
    required String image,
    required String title,
    required String status,
    required String desc,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Image.file(File(image), width: 55, height: 55, fit: BoxFit.cover),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  text: "$title ",
                  style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: Colors.black),
                  children: [
                    TextSpan(
                      text: "- $status",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: status == 'Segar' ? Colors.teal : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                desc,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.teal,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
