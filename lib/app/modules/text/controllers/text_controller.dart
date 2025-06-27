import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TextController extends GetxController {
  final latinTextController = TextEditingController();
  final pegonTextController = TextEditingController();
  final storage = GetStorage();
  final isPro = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfile();

    latinTextController.addListener(() {
      final latin = latinTextController.text;
      pegonTextController.text = _convertToPegon(latin);
    });
  }

  Future<void> fetchProfile() async {
    try {
      isPro.value = storage.read('category') == 'pro';
    } catch (e) {
      Get.snackbar(
        "Failed",
        "Failed to fetch profile",
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }

  String _convertToPegon(String input) {
    // Dummy conversion - ganti sesuai logikamu
    return 'تَـحْوِيل: $input';
  }

  @override
  void onClose() {
    latinTextController.dispose();
    pegonTextController.dispose();
    super.onClose();
  }
}
