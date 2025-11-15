import 'package:flutter/material.dart';
import 'dart:io';
import 'camera_page.dart';
import 'home_page.dart';
import 'tips_page.dart';
import 'riwayat_page.dart';
import 'models/history_item.dart';
import 'services/history_service.dart';

class HasilPage extends StatefulWidget {
  final String? imagePath;
  final String? result;
  final double? confidence;
  const HasilPage({super.key, this.imagePath, this.result, this.confidence});

  @override
  State<HasilPage> createState() => _HasilPageState();
}

class _HasilPageState extends State<HasilPage> {
  int _selectedIndex = 1;

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
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const RiwayatPage()));
    }
  }

  @override
  void initState() {
    super.initState();
    _saveToHistory();
  }

  Future<void> _saveToHistory() async {
    if (widget.imagePath != null && widget.result != null && widget.confidence != null) {
      final historyItem = HistoryItem(
        imagePath: widget.imagePath!,
        result: widget.result!,
        confidence: widget.confidence!,
        timestamp: DateTime.now(),
      );
      await HistoryService.saveHistoryItem(historyItem);
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          )
                        ],
                      ),
                      child: Icon(Icons.arrow_back_rounded,
                          color: Colors.teal.shade900, size: 26),
                    ),
                  ),
                  Image.asset('assets/logo.png', width: 55),
                ],
              ),

              const SizedBox(height: 25),

              // ------------ TITLE ------------
              Text(
                "Hasil Deteksi Kentang",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.teal.shade900,
                ),
              ),

              const SizedBox(height: 15),

              // ------------ IMAGE PREVIEW BOX ------------
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.teal.shade900, width: 1.8),
                ),
                child: widget.imagePath != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          File(widget.imagePath!),
                          fit: BoxFit.cover,
                        ),
                      )
                    : const Center(
                        child: Text("No image"),
                      ),
              ),

              const SizedBox(height: 20),

              // ------------ RESULT TEXT ------------
              Text.rich(
                TextSpan(
                  text: "Kentang",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Colors.black),
                  children: [
                    TextSpan(
                        text: " - ${widget.result == 'FreshPotato' ? 'Segar' : 'Busuk'}",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: widget.result == 'FreshPotato' ? Colors.teal : Colors.red,
                            fontSize: 16)),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "Confidence: ${(widget.confidence ?? 0.0 * 100).toStringAsFixed(1)}%",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontStyle: FontStyle.italic,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                widget.result == 'FreshPotato'
                    ? "Simpan kentang di tempat sejuk dan kering agar tetap segar lebih lama"
                    : "Kentang busuk sebaiknya dibuang untuk menghindari risiko kesehatan",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontStyle: FontStyle.italic,
                  height: 1.3,
                ),
              ),

              const SizedBox(height: 35),

              // ------------ BUTTON LAKUKAN PEMINDAIAN ------------
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const CameraPage()));
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.teal.shade900,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.camera_alt_rounded,
                          color: Colors.white, size: 22),
                      SizedBox(width: 8),
                      Text(
                        "Lakukan Pemindaian",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // ------------ BUTTON SIMPAN HASIL (dummy) ------------
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.teal.shade900, width: 1.8),
                ),
                child: const Center(
                  child: Text(
                    "Simpan Hasil",
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
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
              icon: Icon(Icons.camera_alt_rounded), label: "Scan"),
          BottomNavigationBarItem(
              icon: Icon(Icons.info_outline), label: "Tips"),
          BottomNavigationBarItem(
              icon: Icon(Icons.history), label: "Riwayat"),
        ],
      ),
    );
  }
}
