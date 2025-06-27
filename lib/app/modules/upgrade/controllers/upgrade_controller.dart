import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pegon_ai_mobile/app/data/api_service.dart';
import 'package:pegon_ai_mobile/app/data/variabels.dart';

class UpgradeController extends GetxController {
  final dio = Get.find<ApiService>().dio;
  final storage = GetStorage();

  Future<void> upgrade() async {
    Get.context?.loaderOverlay.show();
    try {
      final response = await dio.post(
        '/api/payment/payment',
        options: Options(
          headers: {
            'X-API-Key': storage.read('api_key'),
            'Authorization': 'Bearer ${storage.read('token')}',
            'Device': Variabels.device,
          },
        ),
      );
      if (response.statusCode == 201) {
        final data = response.data['data'];
        Get.toNamed('/pay', parameters: {"snap_token": data['snap_token']});
      } else {
        Get.snackbar(
          'Failed',
          response.data['message'] ?? 'Failed to create payment',
          colorText: Colors.white,
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.TOP,
          dismissDirection: DismissDirection.horizontal,
          duration: const Duration(seconds: 4),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Failed',
        'Unexpected error occurred',
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.TOP,
        dismissDirection: DismissDirection.horizontal,
        duration: const Duration(seconds: 4),
      );
    }
    Get.context?.loaderOverlay.hide();
  }
}
