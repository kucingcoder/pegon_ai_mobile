import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pegon_ai_mobile/app/data/api_service.dart';
import 'package:pegon_ai_mobile/app/data/variabels.dart';

class OtpController extends GetxController {
  final dio = Get.find<ApiService>().dio;
  final storage = GetStorage();

  Future<void> otpVerification({required String code}) async {
    Get.context?.loaderOverlay.show();
    try {
      final response = await dio.post(
        '/api/otp/verification',
        data: {"code": code},
        options: Options(
          headers: {
            'X-API-Key': storage.read('api_key'),
            'Device': Variabels.device,
          },
        ),
      );

      if (response.statusCode == 200) {
        final token = response.data['access_token'];
        await storage.write('token', token);

        Get.offAllNamed('/dashboard');
      } else {
        Get.snackbar(
          "Failed",
          response.data['message'] ?? 'Failed to verify OTP',
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

  Future<void> otpResend() async {
    Get.context?.loaderOverlay.show();
    try {
      final response = await dio.get(
        '/api/otp/resent',
        options: Options(headers: {'X-API-Key': storage.read('api_key')}),
      );

      if (response.statusCode == 200) {
        Get.snackbar(
          "Success",
          response.data['message'] ?? 'OTP resent successfully',
          colorText: Colors.white,
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.TOP,
          dismissDirection: DismissDirection.horizontal,
          duration: const Duration(seconds: 4),
        );
      } else {
        Get.snackbar(
          "Failed",
          response.data['message'] ?? 'Failed to resend OTP',
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
}
