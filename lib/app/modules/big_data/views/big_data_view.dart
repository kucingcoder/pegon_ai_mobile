import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pegon_ai_mobile/app/data/variabels.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../controllers/big_data_controller.dart';

class BigDataView extends GetView<BigDataController> {
  const BigDataView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Big Data Analytics',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Variabels.orange,
      ),
      body: WebViewSection(url: '${Variabels.baseUrl}/statistic'),
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
