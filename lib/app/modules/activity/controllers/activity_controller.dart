import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pegon_ai_mobile/app/data/api_service.dart';

class Activity {
  final String action;
  final String device;
  final String time;
  Activity({required this.action, required this.device, required this.time});
}

class ActivityController extends GetxController {
  final dio = Get.find<ApiService>().dio;
  final storage = GetStorage();
  final isPro = false.obs;

  var activities = <Activity>[].obs;

  var currentPage = 1.obs;
  var isLoading = false.obs;
  var isLastPage = false.obs;

  @override
  void onInit() {
    super.onInit();
    activityList();
  }

  Options _buildOptions() {
    return Options(
      headers: {
        'X-API-Key': storage.read('api_key'),
        'Authorization': 'Bearer ${storage.read('token')}',
      },
    );
  }

  Future<void> activityList({bool refresh = false}) async {
    if (isLoading.value || isLastPage.value) return;

    if (refresh) {
      currentPage.value = 1;
      isLastPage.value = false;
      activities.clear();
    }

    isLoading.value = true;
    try {
      isPro.value = storage.read('category') == 'pro';
      final response = await dio.get(
        '/api/user/activity',
        queryParameters: {'page': currentPage.value},
        options: _buildOptions(),
      );

      if (response.statusCode == 200) {
        final List newData = response.data['data'];

        if (newData.isEmpty) {
          isLastPage.value = true;
        } else {
          activities.addAll(
            newData.map(
              (item) => Activity(
                action: item['activity'],
                device: item['device'],
                time: item['timestamp'],
              ),
            ),
          );
          currentPage.value += 1;
        }
      } else {
        _showSnackbar(
          "Failed",
          response.data['message'] ?? 'Failed to fetch activities',
          Colors.red,
        );
      }
    } on DioException catch (e) {
      _showSnackbar("Error", _dioErrorMessage(e), Colors.red);
    } catch (e) {
      _showSnackbar("Error", "Unexpected error occurred", Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  void _showSnackbar(String title, String message, Color color) {
    Get.snackbar(
      title,
      message,
      colorText: Colors.white,
      backgroundColor: color,
      snackPosition: SnackPosition.TOP,
      dismissDirection: DismissDirection.horizontal,
      duration: const Duration(seconds: 4),
    );
  }

  String _dioErrorMessage(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout) {
      return 'connection timeout';
    } else if (e.type == DioExceptionType.receiveTimeout) {
      return 'receive timeout';
    } else if (e.type == DioExceptionType.badResponse) {
      return 'Bad response: ${e.response?.statusCode}';
    } else if (e.type == DioExceptionType.cancel) {
      return 'Request was cancelled';
    } else {
      return 'Unexpected error occurred';
    }
  }
}
