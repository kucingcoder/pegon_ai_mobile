import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pegon_ai_mobile/app/data/variabels.dart';
import 'package:pegon_ai_mobile/app/modules/read_history/controllers/read_history_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ReadHistoryView extends GetView<ReadHistoryController> {
  const ReadHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Read History',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Variabels.orange,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final history = controller.history.value;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (history.image.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: history.image,
                    width: double.infinity,
                    fit: BoxFit.contain,
                    placeholder:
                        (_, __) =>
                            const Center(child: CircularProgressIndicator()),
                    errorWidget:
                        (_, __, ___) => const Text("Image failed to load"),
                  ),
                ),
              const SizedBox(height: 16),
              Text('Date:', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    history.date,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              if (controller.banner.value != null)
                SizedBox(
                  height: 108,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: Center(
                      child: AdWidget(ad: controller.banner.value!),
                    ),
                  ),
                ),
              const SizedBox(height: 24),
              Text('Result:', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: SelectableText(
                  history.text,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(fontSize: 16, height: 1.5),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Text Analysis',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              WebViewSection(
                url:
                    '${Variabels.baseUrl}/api/visualization/transliteration/${controller.id_history.value}',
              ),
              const SizedBox(height: 32),
            ],
          ),
        );
      }),
    );
  }
}

class WebViewSection extends StatefulWidget {
  final String url;
  const WebViewSection({super.key, required this.url});

  @override
  State<WebViewSection> createState() => _WebViewSectionState();
}

class _WebViewSectionState extends State<WebViewSection> {
  late final WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    _webViewController =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setBackgroundColor(Colors.white)
          ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 900,
      child: WebViewWidget(controller: _webViewController),
    );
  }
}
