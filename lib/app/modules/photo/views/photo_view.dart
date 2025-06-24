import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pegon_ai_mobile/app/data/variabels.dart';

import '../controllers/photo_controller.dart';

class PhotoView extends GetView<PhotoController> {
  const PhotoView({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'Photo Transliteration',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          backgroundColor: Variabels.orange,
        ),
        body: Obx(() {
          if (!controller.isCameraReady.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return Stack(
            alignment: Alignment.center,
            children: [
              Positioned.fill(
                child: AspectRatio(
                  aspectRatio: controller.cameraController.value.aspectRatio,
                  child: CameraPreview(controller.cameraController),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                child: FloatingActionButton(
                  onPressed: () async {
                    controller.stopCamera();

                    final picker = ImagePicker();
                    final file = await picker.pickImage(
                      source: ImageSource.gallery,
                    );

                    if (file != null) {
                      controller.transliterate(file.path);
                    }

                    controller.startCamera();
                  },
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  heroTag: 'galery',
                  child: Icon(
                    Icons.photo_library,
                    size: 32,
                    color: Variabels.orange,
                  ),
                ),
              ),
              Positioned(
                bottom: 16,
                child: FloatingActionButton(
                  heroTag: 'photo',
                  backgroundColor: Variabels.orange,
                  onPressed: () async {
                    final file =
                        await controller.cameraController.takePicture();
                    controller.transliterate(file.path);
                  },
                  child: const Icon(Icons.camera, color: Colors.white),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
