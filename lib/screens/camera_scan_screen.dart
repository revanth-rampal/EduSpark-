import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraScanScreen extends StatefulWidget {
  const CameraScanScreen({Key? key}) : super(key: key);

  @override
  _CameraScanScreenState createState() => _CameraScanScreenState();
}

class _CameraScanScreenState extends State<CameraScanScreen> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    // 1. Request permission
    final status = await Permission.camera.request();
    if (status.isGranted) {
      // 2. Get available cameras
      final cameras = await availableCameras();
      // 3. Select the front camera
      final frontCamera = cameras.firstWhere(
          (camera) => camera.lensDirection == CameraLensDirection.front,
          orElse: () => cameras.first);

      // 4. Create and initialize the controller
      _controller = CameraController(
        frontCamera,
        ResolutionPreset.medium,
      );

      _initializeControllerFuture = _controller!.initialize();
      setState(() {
        _isCameraInitialized = true;
      });
    } else {
      // Handle permission denial
      print('Camera permission denied');
    }
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Student Faces'),
      ),
      body: _isCameraInitialized
          ? FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // If the Future is complete, display the preview.
                  return Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      CameraPreview(_controller!),
                      // Add an overlay or buttons here
                      Container(
                        color: Colors.black.withOpacity(0.5),
                        padding: const EdgeInsets.all(20.0),
                        child: FloatingActionButton(
                          onPressed: () async {
                            try {
                              // Ensure the controller is initialized
                              await _initializeControllerFuture;
                              // Take the picture
                              final image = await _controller!.takePicture();
                              // In a real app, you would now send this image
                              // to your facial recognition service.
                              print('Picture saved to ${image.path}');
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        'Image captured! Ready for analysis.')),
                              );
                            } catch (e) {
                              print(e);
                            }
                          },
                          child: const Icon(Icons.camera),
                        ),
                      )
                    ],
                  );
                } else {
                  // Otherwise, display a loading indicator.
                  return const Center(child: CircularProgressIndicator());
                }
              },
            )
          : const Center(
              child: Text('Requesting camera permission...'),
            ),
    );
  }
}
