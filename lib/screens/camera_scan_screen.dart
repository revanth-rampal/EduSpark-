import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraScanScreen extends StatefulWidget {
  const CameraScanScreen({Key? key}) : super(key: key);

  @override
  _CameraScanScreenState createState() => _CameraScanScreenState();
}

class _CameraScanScreenState extends State<CameraScanScreen> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;

  // State variables for initialization and location
  bool _isCameraReady = false;
  String _statusMessage = 'Initializing Camera...';
  Color _statusColor = Colors.orange;
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _initializeServices();
  }

  // A single function to handle all initializations.
  Future<void> _initializeServices() async {
    // 1. Request Camera Permission
    final cameraStatus = await Permission.camera.request();
    if (!cameraStatus.isGranted) {
      setState(() {
        _statusMessage = 'Camera Permission Denied';
        _statusColor = Colors.red;
      });
      return;
    }

    // 2. Initialize Camera Controller
    final cameras = await availableCameras();
    final frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first);

    _controller = CameraController(frontCamera, ResolutionPreset.high);
    _initializeControllerFuture = _controller!.initialize().then((_) {
      if (!mounted) return;
      setState(() {
        _isCameraReady = true;
        _statusMessage = 'Checking Location...';
      });
      // 3. Request Location after camera is ready
      _getCurrentLocation();
    });
  }

  // Function to get the device's current location.
  Future<void> _getCurrentLocation() async {
    final locationStatus = await Permission.location.request();
    if (!locationStatus.isGranted) {
      setState(() {
        _statusMessage = 'Location Permission Denied';
        _statusColor = Colors.red;
      });
      return;
    }

    try {
      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      if (!mounted) return;
      setState(() {
        _currentPosition = position;
        // In a real app, you would compare this to school coordinates.
        // For this demo, we assume success.
        _statusMessage = 'Location Verified ✓';
        _statusColor = Colors.green;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _statusMessage = 'Could not get location';
        _statusColor = Colors.red;
      });
    }
  }

  // Function to handle taking a picture.
  Future<void> _onTakePicture() async {
    if (_currentPosition == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cannot capture: Location not verified.')),
      );
      return;
    }
    try {
      await _initializeControllerFuture;
      final image = await _controller!.takePicture();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Image captured! Ready for analysis.')),
      );
      
      // Here, you would send the image and location to your backend/ML service.
      print('Picture saved to ${image.path}');
      print('Location: ${_currentPosition!.latitude}, ${_currentPosition!.longitude}');

    } catch (e) {
      print("Error taking picture: $e");
    }
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is removed.
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan Student Face')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done && _isCameraReady) {
            // If the Future is complete, display the preview.
            return Stack(
              fit: StackFit.expand,
              children: [
                CameraPreview(_controller!),
                _buildOverlayUI(),
              ],
            );
          } else {
            // Otherwise, display a loading indicator.
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 20),
                Text(_statusMessage),
              ],
            ));
          }
        },
      ),
    );
  }

  // Helper widget for building the UI on top of the camera preview.
  Widget _buildOverlayUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Top status bar
        Container(
          width: double.infinity,
          color: _statusColor.withOpacity(0.8),
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            _statusMessage,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        // Bottom action bar
        Container(
          color: Colors.black.withOpacity(0.5),
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Center(
            child: FloatingActionButton.large(
              onPressed: _onTakePicture,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.camera,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
