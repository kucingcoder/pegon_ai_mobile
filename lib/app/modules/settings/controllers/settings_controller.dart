import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pegon_ai_mobile/app/data/variabels.dart';
import '../../../data/api_service.dart';

class SettingsController extends GetxController {
  final dio = Get.find<ApiService>().dio;
  final storage = GetStorage();
  final GoogleSignIn googleSignIn = GoogleSignIn();

  var id = ''.obs;
  var name = ''.obs;
  var dateOfBirth = ''.obs;
  var gender = ''.obs;
  var profilePicture = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    try {
      final response = await dio.get(
        '/api/user/profile',
        options: Options(
          headers: {
            'X-API-Key': storage.read('api_key'),
            'Authorization': 'Bearer ${storage.read('token')}',
            'Device': Variabels.device,
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data['data'];

        id.value = data['id'] ?? '';
        name.value = data['name'] ?? '';
        dateOfBirth.value = data['date_of_birth'] ?? '';
        gender.value = data['sex'] ?? '';

        if (data['sex'] == 'female') {
          profilePicture.value = 'assets/images/avatar_girl.webp';
        } else {
          profilePicture.value = 'assets/images/avatar_boy.webp';
        }
      } else {
        Get.snackbar(
          "Failed",
          response.data['message'] ?? 'Failed to fetch profile',
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
  }

  Future<void> updateProfile() async {
    Get.context?.loaderOverlay.show();
    try {
      final payload = <String, dynamic>{'name': name.value.trim()};

      if (gender.value.isNotEmpty) {
        payload['sex'] = gender.value;
      }

      if (dateOfBirth.value.trim().isNotEmpty) {
        payload['date_of_birth'] = dateOfBirth.value.trim();
      }

      final response = await dio.post(
        '/api/user/profile-update',
        options: Options(
          headers: {
            'X-API-Key': storage.read('api_key'),
            'Authorization': 'Bearer ${storage.read('token')}',
            'Device': Variabels.device,
          },
        ),
        data: payload,
      );

      if (response.statusCode == 200) {
        Get.snackbar(
          'Success',
          'Profile updated successfully',
          colorText: Colors.white,
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.TOP,
          dismissDirection: DismissDirection.horizontal,
          duration: const Duration(seconds: 4),
        );
      } else {
        Get.snackbar(
          'Failed',
          response.data['message'] ?? 'Failed to update profile',
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
    fetchProfile();
    Get.context?.loaderOverlay.hide();
  }

  Future<void> logout() async {
    Get.context?.loaderOverlay.show();
    await storage.remove('token');
    await storage.remove('api_key');
    await googleSignIn.signOut();
    Get.context?.loaderOverlay.hide();
    Get.offAllNamed('/login');
  }
}
