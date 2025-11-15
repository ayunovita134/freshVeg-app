import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'hasil_page.dart';
import 'camera_page.dart';
import 'home_page.dart';
import 'tips_page.dart';
import 'riwayat_page.dart';
import 'services/api_service.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  int _selectedIndex = 1;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      try {
        final prediction = await ApiService.predictPotato(image.path);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => HasilPage(
              imagePath: image.path,
              result: prediction['result'],
              confidence: prediction['confidence'],
            ),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  void _onNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });

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
                  // Back Button
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

                  // Logo
                  Image.asset(
                    'assets/logo.png',
                    width: 55,
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // ------------ TITLE ------------
              Text(
                "Upload Sayurmu dan\nLihat Seberapa Segar",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.teal.shade900,
                  height: 1.3,
                ),
              ),

              const SizedBox(height: 25),

              // ------------ UPLOAD FRAME ------------
              Container(
                height: 230,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.teal.shade900,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.upload_rounded,
                    size: 70,
                    color: Colors.teal.shade900,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // ------------ UPLOAD BUTTON ------------
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.teal.shade900,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Upload",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.teal.shade900,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // ------------ BOTTOM ACTION BUTTONS ------------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Blitz (dummy)
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border:
                          Border.all(color: Colors.teal.shade900, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Icon(Icons.flash_on,
                        size: 28, color: Colors.teal.shade900),
                  ),

                  // Camera Button
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const CameraPage()));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(color: Colors.teal.shade900, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Icon(Icons.camera_alt_outlined,
                          size: 28, color: Colors.teal.shade900),
                    ),
                  ),
                ],
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
