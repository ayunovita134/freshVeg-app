import 'package:flutter/material.dart';
import 'home_page.dart';
import 'camera_page.dart';
import 'riwayat_page.dart';

class TipsPage extends StatefulWidget {
  const TipsPage({super.key});

  @override
  State<TipsPage> createState() => _TipsPageState();
}

class _TipsPageState extends State<TipsPage> {
  int _selectedIndex = 2;

  void _onNavTap(int index) {
    setState(() => _selectedIndex = index);
    if (index == 0) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const HomePage()));
    } else if (index == 1) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const CameraPage()));
    } else if (index == 2) {
      // stay on TipsPage
    } else if (index == 3) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const RiwayatPage()));
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
              // ------------ BACK BUTTON ------------
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
                "Tips Buat Kentangmu\nTetap Segar",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.teal.shade900,
                ),
              ),

              const SizedBox(height: 20),

              // ------------ LIST TIPS (DUMMY) ------------
              Expanded(
                child: ListView(
                  children: [
                    _buildTipsItem(
                      "Memilih Kentang Segar",
                      "Segar",
                      "Pilih kentang yang kulitnya halus, bebas dari bintik-bintik hijau atau hitam, dan tidak lembek saat ditekan.",
                    ),
                    _buildTipsItem(
                      "Menyimpan Kentang",
                      "Segar",
                      "Simpan kentang di tempat gelap, sejuk, dan kering, jauh dari cahaya matahari untuk mencegah pertumbuhan tunas.",
                    ),
                    _buildTipsItem(
                      "Ciri-ciri Kentang Busuk",
                      "Busuk",
                      "Kentang busuk ditandai dengan bau tidak sedap, kulit berkerut, atau munculnya bintik-bintik hijau dan lunak.",
                    ),
                    _buildTipsItem(
                      "Merawat Kentang Agar Tahan Lama",
                      "Segar",
                      "Jaga kentang tetap kering, hindari pencucian sebelum penyimpanan, dan simpan di suhu 7-10°C.",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // ------------ NAVBAR ------------
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

  // ------------ TIPS ITEM WIDGET ------------
  Widget _buildTipsItem(String sayur, String status, String tips) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.teal.shade900, width: 1.8),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    text: "$sayur ",
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: Colors.black),
                    children: [
                      TextSpan(
                        text: "- $status",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.teal.shade800,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  tips,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.teal,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
