import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextController extends GetxController {
  final latinTextController = TextEditingController();
  final pegonTextController = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    latinTextController.addListener(() {
      final latin = latinTextController.text;
      pegonTextController.text = _convertToPegon(latin);
    });
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
