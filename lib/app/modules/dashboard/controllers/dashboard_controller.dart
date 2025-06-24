import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pegon_ai_mobile/app/data/api_service.dart';
import 'package:pegon_ai_mobile/app/data/variabels.dart';

class History {
  final String id;
  final String image;
  final String date;

  History({required this.id, required this.image, required this.date});
}

class Profile {
  final String id;
  final String name;
  final String sex;
  final String avatar;
  final String category;

  Profile({
    required this.id,
    required this.name,
    required this.sex,
    required this.avatar,
    required this.category,
  });
}

class DashboardController extends GetxController {
  final dio = Get.find<ApiService>().dio;
  final storage = GetStorage();

  var histories = <History>[].obs;
  var profile = Rx<Profile?>(null);

  var currentPage = 1.obs;
  var isLoading = false.obs;
  var isLastPage = false.obs;

  @override
  void onInit() {
    super.onInit();
    profileGet();
    historyList();
  }

  Options _buildOptions() {
    return Options(
      headers: {
        'X-API-Key': storage.read('api_key'),
        'Authorization': 'Bearer ${storage.read('token')}',
        'Device': Variabels.device,
      },
    );
  }

  Future<void> profileGet() async {
    try {
      final response = await dio.get(
        '/api/user/profile',
        options: _buildOptions(),
      );

      if (response.statusCode == 200) {
        final data = response.data['data'];
        final String avatar;

        if (data['sex'] == 'female') {
          avatar = 'assets/images/avatar_girl.webp';
        } else {
          avatar = 'assets/images/avatar_boy.webp';
        }

        profile.value = Profile(
          id: data['id'],
          name: data['name'],
          sex: data['sex'],
          avatar: avatar,
          category: data['category'],
        );

        storage.write('category', data['category']);
      } else {
        _showSnackbar(
          "Failed",
          response.data['message'] ?? 'Failed to fetch profile',
          Colors.red,
        );
      }
    } on DioException catch (e) {
      _showSnackbar("Error", _dioErrorMessage(e), Colors.red);
    } catch (e) {
      _showSnackbar("Error", "Terjadi kesalahan tak terduga", Colors.red);
    }
  }

  Future<void> historyList({bool refresh = false}) async {
    if (isLoading.value || isLastPage.value) return;

    if (refresh) {
      currentPage.value = 1;
      isLastPage.value = false;
      histories.clear();
    }

    isLoading.value = true;
    try {
      final response = await dio.get(
        '/api/transliterate/history',
        queryParameters: {'page': currentPage.value},
        options: _buildOptions(),
      );

      if (response.statusCode == 200) {
        final List newData = response.data['data'];

        if (newData.isEmpty) {
          isLastPage.value = true;
        } else {
          histories.addAll(
            newData.map(
              (item) => History(
                id: item['id'],
                image: item['image'],
                date: item['date'],
              ),
            ),
          );
          currentPage.value += 1;
        }
      } else {
        _showSnackbar(
          "Failed",
          response.data['message'] ?? 'Failed to fetch history',
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

  Future<void> deleteHistory(String id) async {
    Get.context?.loaderOverlay.show();
    try {
      final response = await dio.delete(
        '/api/transliterate/history/$id',
        options: _buildOptions(),
      );

      if (response.statusCode == 200) {
        histories.removeWhere((h) => h.id == id);
      } else {
        _showSnackbar(
          'Failed',
          response.data['message'] ?? 'Failed to delete history',
          Colors.red,
        );
      }
    } on DioException catch (e) {
      _showSnackbar("Error", _dioErrorMessage(e), Colors.red);
    } catch (e) {
      _showSnackbar("Error", "Unexpected error occurred", Colors.red);
    }
    Get.context?.loaderOverlay.hide();
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
