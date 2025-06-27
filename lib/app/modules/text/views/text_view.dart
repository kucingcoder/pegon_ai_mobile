import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:pegon_ai_mobile/app/data/reusable_ad_banner_widget.dart';
import 'package:pegon_ai_mobile/app/data/variabels.dart';
import '../controllers/text_controller.dart';

class TextView extends GetView<TextController> {
  const TextView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Text Transliteration',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Variabels.orange,
      ),
      body: Column(
        children: [
          Expanded(
            child: LanguageCard(
              language: 'Latin',
              backgroundColor: Colors.grey.shade300,
              controller: controller.latinTextController,
              readOnly: false,
            ),
          ),
          controller.isPro.value
              ? const SizedBox.shrink()
              : Column(
                children: [
                  const ReusableAdBannerWidget(),
                  const SizedBox(height: 8),
                ],
              ),
          Expanded(
            child: LanguageCard(
              language: 'Pegon',
              backgroundColor: Variabels.orange.withAlpha(200),
              controller: controller.pegonTextController,
              readOnly: true,
            ),
          ),
        ],
      ),
      bottomNavigationBar: Obx(() {
        return controller.isPro.value
            ? const SizedBox.shrink()
            : const ReusableAdBannerWidget();
      }),
    );
  }
}

class LanguageCard extends StatelessWidget {
  final String language;
  final Color backgroundColor;
  final TextEditingController controller;
  final bool readOnly;

  const LanguageCard({
    super.key,
    required this.language,
    required this.backgroundColor,
    required this.controller,
    required this.readOnly,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                language,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: TextField(
              controller: controller,
              readOnly: readOnly,
              maxLines: null,
              expands: true,
              textAlignVertical: TextAlignVertical.top,
              decoration: const InputDecoration.collapsed(
                hintText: 'Enter text here...',
              ),
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
              icon: const Icon(Icons.copy),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: controller.text));
                Get.snackbar('Disalin', 'Teks berhasil disalin');
              },
            ),
          ),
        ],
      ),
    );
  }
}
