import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../data/api_service.dart';

class Tutorial {
  final String id;
  final String title;
  final String description;
  final String link;
  final String date;

  Tutorial({
    required this.id,
    required this.title,
    required this.description,
    required this.link,
    required this.date,
  });
}

class WatchTutorialController extends GetxController {
  final dio = Get.find<ApiService>().dio;
  final storage = GetStorage();
  var tutorial =
      Tutorial(
        id: '6816f86f07bab8b9c44b48e8',
        title: 'Title',
        description: 'Description',
        link: 'https://www.youtube.com/watch?v=vMqZkdcLzj4&list=RDvMqZkdcLzj4',
        date: '00 Jan 2025',
      ).obs;

  @override
  void onInit() {
    super.onInit();
    tutorialInfo();
  }

  Future<void> tutorialInfo() async {
    final id = Get.parameters['id'];
    try {
      final response = await dio.get('/api/tutorial/detail/$id');

      if (response.statusCode == 200) {
        final data = response.data['data'];
        tutorial.value = Tutorial(
          id: data['id'].toString(),
          title: data['name'],
          description: data['description'],
          link: data['link'],
          date: data['date'],
        );
      } else {
        Get.snackbar(
          "Failed",
          response.data['message'] ?? 'Failed to fetch tutorial',
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
    } finally {}
  }
}
