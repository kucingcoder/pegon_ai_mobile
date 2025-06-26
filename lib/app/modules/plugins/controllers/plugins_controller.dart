import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pegon_ai_mobile/app/data/api_service.dart';

class Plugins {
  final String id;
  final String device;

  Plugins({required this.id, required this.device});
}

class PluginsController extends GetxController {
  final dio = Get.find<ApiService>().dio;
  final storage = GetStorage();
  final pluginsList = <Plugins>[].obs;

  @override
  void onInit() {
    super.onInit();
    listPlugins();
  }

  Future<void> listPlugins() async {
    try {
      final response = await dio.get(
        '/api/plugins/list',
        options: Options(
          headers: {
            'X-API-Key': storage.read('api_key'),
            'Authorization': 'Bearer ' + storage.read('token'),
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data['data'];
        if (data != null) {
          pluginsList.value = List<Plugins>.from(
            data.map((item) => Plugins(id: item['id'], device: item['device'])),
          );
        } else {
          pluginsList.clear();
        }
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to fetch plugins",
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.TOP,
        dismissDirection: DismissDirection.horizontal,
        duration: const Duration(seconds: 4),
      );
    }
  }

  Future<void> unpairPlugins(String plugin_id) async {
    try {
      final response = await dio.post(
        '/api/plugins/unpair',
        options: Options(
          headers: {
            'X-API-Key': storage.read('api_key'),
            'Authorization': 'Bearer ' + storage.read('token'),
          },
        ),
        data: {"plugin_id": plugin_id},
      );

      if (response.statusCode == 200) {
        Get.back();
        Get.snackbar(
          "Success",
          "Successfully to unpair plugins",
          colorText: Colors.white,
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.TOP,
          dismissDirection: DismissDirection.horizontal,
          duration: const Duration(seconds: 4),
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to unpair plugins",
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.TOP,
        dismissDirection: DismissDirection.horizontal,
        duration: const Duration(seconds: 4),
      );
    }
  }

  Future<void> pairPlugins(String plugin_id) async {
    try {
      final response = await dio.post(
        '/api/plugins/verify',
        options: Options(
          headers: {
            'X-API-Key': storage.read('api_key'),
            'Authorization': 'Bearer ' + storage.read('token'),
          },
        ),
        data: {"plugin_id": plugin_id},
      );

      if (response.statusCode == 200) {
        Get.snackbar(
          "Success",
          "Successfully to pair plugins",
          colorText: Colors.white,
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.TOP,
          dismissDirection: DismissDirection.horizontal,
          duration: const Duration(seconds: 4),
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to pair plugins",
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.TOP,
        dismissDirection: DismissDirection.horizontal,
        duration: const Duration(seconds: 4),
      );
    }
  }
}
