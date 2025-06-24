import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:pegon_ai_mobile/app/data/api_service.dart';

class Tutorial {
  final String id;
  final String title;
  final String thumbnailUrl;
  final String date;

  Tutorial({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.date,
  });
}

class TutorialsController extends GetxController {
  final dio = Get.find<ApiService>().dio;
  final storage = GetStorage();
  var tutorials = <Tutorial>[].obs;
  var currentSlide = 0.obs;

  List<Tutorial> get latestTutorials {
    final sorted = [...tutorials];
    final format = DateFormat('dd MMM yyyy', 'en_US');
    sorted.sort((a, b) => format.parse(b.date).compareTo(format.parse(a.date)));
    return sorted.take(3).toList();
  }

  @override
  void onInit() {
    super.onInit();
    tutorialList();
  }

  Future<void> tutorialList() async {
    try {
      final response = await dio.get('/api/tutorial/list');

      if (response.statusCode == 200) {
        tutorials.value =
            (response.data['data'] as List)
                .map(
                  (item) => Tutorial(
                    id: item['id'],
                    title: item['name'],
                    thumbnailUrl: item['thumbnail'],
                    date: item['date'],
                  ),
                )
                .toList();
      } else {
        Get.snackbar(
          "Failed",
          response.data['message'] ?? 'Failed to fetch tutorial list',
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
