import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';
import 'hasil_page.dart';
import 'upload_page.dart';
import 'home_page.dart';
import 'tips_page.dart';
import 'riwayat_page.dart';
import 'services/api_service.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  int _selectedIndex = 1;
  CameraController? _controller;
  List<CameraDescription>? cameras;
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _initializeCamera() async {
    var status = await Permission.camera.request();
    if (status.isGranted) {
      cameras = await availableCameras();
      if (cameras != null && cameras!.isNotEmpty) {
        _controller = CameraController(cameras![0], ResolutionPreset.high);
        await _controller!.initialize();
        if (mounted) {
          setState(() {
            _isCameraInitialized = true;
          });
        }
      }
    } else {
      // Handle permission denied
      print('Camera permission denied');
    }
  }

  Future<void> _takePhoto() async {
    if (_controller != null && _controller!.value.isInitialized) {
      try {
        final directory = await getApplicationDocumentsDirectory();
        final imagePath = path.join(directory.path, '${DateTime.now()}.png');
        await _controller!.takePicture().then((XFile file) async {
          await file.saveTo(imagePath);
          final prediction = await ApiService.predictPotato(imagePath);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => HasilPage(
                imagePath: imagePath,
                result: prediction['result'],
                confidence: prediction['confidence'],
              ),
            ),
          );
        });
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
      // Already on Camera Page
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
                "Potret Sayurmu dan\nLihat Seberapa Segar",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.teal.shade900,
                  height: 1.3,
                ),
              ),

              const SizedBox(height: 25),

              // ------------ CAMERA FRAME ------------
              // ------------ CAMERA FRAME (KOTAK) ------------
Center(
  child: Container(
    height: 300, // ukuran kotak (bisa kamu ubah misalnya 250 atau 350)
    width: 300,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: Colors.teal.shade900,
        width: 2,
      ),
    ),
    child: _isCameraInitialized && _controller != null
        ? ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: AspectRatio(
              aspectRatio: 1, // rasio kotak
              child: CameraPreview(_controller!),
            ),
          )
        : const Center(
            child: CircularProgressIndicator(),
          ),
  ),
),
const SizedBox(height: 20),
              // ------------ TAKE PHOTO BUTTON ------------
              GestureDetector(
                onTap: _takePhoto,
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
                      "Ambil Foto",
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

              // ------------ BOTTOM CAMERA ACTION BUTTONS ------------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Blitz Button
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
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

                  // Gallery Button
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const UploadPage()));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
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
                      child: Icon(Icons.photo_library_outlined,
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
