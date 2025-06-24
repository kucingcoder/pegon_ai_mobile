import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pegon_ai_mobile/app/data/api_service.dart';
import 'package:pegon_ai_mobile/app/data/variabels.dart';

class RegisterController extends GetxController {
  final dio = Get.find<ApiService>().dio;
  final storage = GetStorage();

  Future<void> registerUser({
    required String name,
    required String sex,
    required String dateOfBirth,
    required String phoneCode,
    required String phoneNumber,
  }) async {
    Get.context?.loaderOverlay.show();
    try {
      final response = await dio.post(
        '/api/user/register',
        options: Options(headers: {'Device': Variabels.device}),
        data: {
          "name": name,
          "sex": sex,
          "date_of_birth": dateOfBirth,
          "phone_code": phoneCode,
          "phone_number": phoneCode + phoneNumber,
        },
      );

      if (response.statusCode == 201) {
        final apiKey = response.data['api_key'];
        await storage.write('api_key', apiKey);

        Get.toNamed('/otp');
      } else {
        Get.snackbar(
          "Failed",
          response.data['message'] ?? 'Failed to register',
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

  Future<void> googleLogin() async {
    Get.context?.loaderOverlay.show();
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        serverClientId:
            '927004603318-j5vmd61138dd0nt4qifi5bb7mjasqs6o.apps.googleusercontent.com',
      );

      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        Get.context?.loaderOverlay.hide();
        return;
      }

      final googleAuth = await googleUser.authentication;
      final idToken = googleAuth.idToken;
      final tokenId = idToken;

      log('token id google auth : $tokenId');

      if (idToken == null || tokenId!.isEmpty) {
        Get.context?.loaderOverlay.hide();
        Get.snackbar(
          "Failed",
          'Failed to login with Google',
          colorText: Colors.white,
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.TOP,
          dismissDirection: DismissDirection.horizontal,
          duration: const Duration(seconds: 4),
        );
        return;
      }

      final response = await dio.post(
        '/api/user/login-with-google',
        options: Options(headers: {'Device': Variabels.device}),
        data: {"token_id": tokenId},
      );

      if (response.statusCode == 200) {
        final apiKey = response.data['api_key'];
        final token = response.data['access_token'];
        await storage.write('api_key', apiKey);
        await storage.write('token', token);

        Get.offAllNamed('/dashboard');
      } else {
        Get.snackbar(
          "Failed",
          response.data['message'] ?? 'Failed to login with Google',
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
        'Failed to login with Google',
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
