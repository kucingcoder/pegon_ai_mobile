import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../data/api_service.dart';

class History {
  final String date;
  final String image;
  final String text;

  History({required this.date, required this.image, required this.text});
}

class ReadHistoryController extends GetxController {
  final dio = Get.find<ApiService>().dio;
  final storage = GetStorage();
  var history =
      History(
        date: '00 Jan 2025',
        image: '',
        text:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed felis dui, accumsan sit amet ornare aliquam, convallis at nunc. Suspendisse nibh elit, molestie ac mi et, ullamcorper sagittis elit. Maecenas et lacinia lectus. Aliquam sodales accumsan massa, nec sodales urna euismod quis. Pellentesque quis dolor id ex egestas porttitor tristique quis massa. Nam et quam congue, scelerisque urna ut, faucibus urna. Nam dignissim libero quis quam suscipit porta. Sed suscipit interdum ligula, at tempus metus condimentum non. Pellentesque dolor ex, varius quis nunc at, dapibus dictum turpis. Ut vehicula scelerisque quam, sed convallis elit. Duis ut venenatis augue, a auctor leo. Ut bibendum mi eu magna malesuada, sit amet interdum tortor accumsan.',
      ).obs;
  var id_history = ''.obs;
  var banner = Rx<BannerAd?>(null);
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    historyInfo();
  }

  Future<void> historyInfo() async {
    isLoading.value = true;
    final id = Get.parameters['id'];
    id_history.value = id!;
    try {
      final response = await dio.get(
        '/api/transliterate/history/$id',
        options: Options(
          headers: {
            'X-API-Key': storage.read('api_key'),
            'Authorization': 'Bearer ' + storage.read('token'),
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data['data'];
        history.value = History(
          date: data['date'],
          image: data['image'],
          text: data['text'],
        );
      } else {
        Get.snackbar(
          "Failed",
          response.data['message'] ?? 'Failed to fetch history',
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
    } finally {
      isLoading.value = false;
    }
  }
}
