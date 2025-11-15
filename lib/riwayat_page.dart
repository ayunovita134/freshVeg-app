import 'package:flutter/material.dart';
import 'home_page.dart';
import 'camera_page.dart';
import 'tips_page.dart';
import 'models/history_item.dart';
import 'services/history_service.dart';
import 'dart:io';

class RiwayatPage extends StatefulWidget {
  const RiwayatPage({super.key});

  @override
  State<RiwayatPage> createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage> {
  int _selectedIndex = 3;
  List<HistoryItem> _historyList = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final history = await HistoryService.getHistoryList();
    setState(() {
      _historyList = history.reversed.toList(); // Latest first
    });
  }

  void _onNavTap(int index) {
    setState(() => _selectedIndex = index);
    if (index == 0) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const HomePage()));
    } else if (index == 1) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const CameraPage()));
    } else if (index == 2) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const TipsPage()));
    } else if (index == 3) {
      // stay on RiwayatPage
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ------------ TOP BAR ------------
              GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: Colors.teal.shade900, width: 2),
                      ),
                      child: Icon(Icons.arrow_back_rounded,
                          color: Colors.teal.shade900, size: 26),
                    ),
                  ),
              const SizedBox(height: 25),

              // ------------ TITLE ------------
              Text(
                "Riwayat Deteksi Kentang",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.teal.shade900,
                ),
              ),

              const SizedBox(height: 20),

              // ------------ LIST RIWAYAT ------------
              Expanded(
                child: _historyList.isEmpty
                    ? const Center(child: Text("Belum ada riwayat deteksi"))
                    : ListView(
                        children: _historyList.map((item) => _buildRiwayatItem(item)).toList(),
                      ),
              ),
            ],
          ),
        ),
      ),

      // ------------ NAV BAR ------------
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
              icon: Icon(Icons.camera_alt_rounded), label: "Scan"),
          BottomNavigationBarItem(
              icon: Icon(Icons.info_outline), label: "Tips"),
          BottomNavigationBarItem(
              icon: Icon(Icons.history), label: "Riwayat"),
        ],
      ),
    );
  }

  // ------------ ITEM WIDGET ------------
  Widget _buildRiwayatItem(HistoryItem item) {
    String status = item.result == 'FreshPotato' ? 'Segar' : 'Busuk';
    String tanggal = "${item.timestamp.day} ${item.timestamp.month} ${item.timestamp.year}";
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Image.file(File(item.imagePath), width: 55, height: 55, fit: BoxFit.cover),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  text: "Kentang ",
                  style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: Colors.black),
                  children: [
                    TextSpan(
                      text: "- $status",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: item.result == 'FreshPotato' ? Colors.teal : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                tanggal,
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
