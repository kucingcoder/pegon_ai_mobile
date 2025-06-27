import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:get_storage/get_storage.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pegon_ai_mobile/app/data/api_service.dart';
import 'package:pegon_ai_mobile/app/data/variabels.dart';

class PhotoController extends GetxController {
  late CameraController cameraController;
  RxBool isCameraReady = false.obs;

  final dio = Get.find<ApiService>().dio;
  final storage = GetStorage();
  final isPro = false.obs;

  Future<void> startCamera() async {
    final cameras = await availableCameras();
    cameraController = CameraController(
      cameras[0],
      ResolutionPreset.high,
      enableAudio: false,
    );
    try {
      await cameraController.initialize();
      isCameraReady.value = true;
    } catch (e) {
      print("Camera init error: $e");
    }
  }

  Future<void> stopCamera() async {
    isPro.value = storage.read('category') == 'pro';
    if (cameraController.value.isInitialized) {
      await cameraController.dispose();
      isCameraReady.value = false;
    }
  }

  Future<void> transliterate(String path) async {
    Get.context?.loaderOverlay.show();
    try {
      final file = await MultipartFile.fromFile(
        path,
        filename: path.split('/').last,
      );

      final formData = FormData.fromMap({'image': file});

      final response = await dio.post(
        '/api/transliterate/image-to-text',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            'X-API-Key': storage.read('api_key'),
            'Authorization': 'Bearer ${storage.read('token')}',
            'Device': Variabels.device,
          },
        ),
      );

      if (response.statusCode == 201) {
        final data = response.data['data'];
        Get.toNamed('/read-history', parameters: {"id": data['id']});
      } else {
        Get.snackbar(
          "Failed",
          response.data['message'] ?? 'Failed to transliterate',
          colorText: Colors.white,
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.TOP,
          dismissDirection: DismissDirection.horizontal,
          duration: const Duration(seconds: 4),
        );
      }
    } catch (e) {
      Get.snackbar(
        "Failed",
        "Unexpected error occurred",
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.TOP,
        dismissDirection: DismissDirection.horizontal,
        duration: const Duration(seconds: 4),
      );
    }
    Get.context?.loaderOverlay.hide();
  }

  @override
  void onInit() {
    super.onInit();
    startCamera();
  }

  @override
  void onClose() {
    cameraController.dispose();
    super.onClose();
  }
}
