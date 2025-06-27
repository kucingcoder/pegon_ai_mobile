import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import '../controllers/plugins_controller.dart';

// ignore: must_be_immutable
class PluginsView extends GetView<PluginsController> {
  PluginsView({super.key});
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? qrController;
  final RxBool hasScanned = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Plugin QR'),
        centerTitle: true,
        backgroundColor: Colors.orange.shade700,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: QRView(
              key: qrKey,
              onQRViewCreated: (ctrl) {
                qrController = ctrl;
                ctrl.scannedDataStream.listen((scanData) async {
                  if (!hasScanned.value && scanData.code != null) {
                    hasScanned.value = true;
                    qrController?.pauseCamera();
                    await controller.pairPlugins(scanData.code!);
                    await controller.listPlugins();
                    qrController?.resumeCamera();
                    hasScanned.value = false;
                  }
                });
              },
              overlay: QrScannerOverlayShape(
                borderColor: Colors.orange,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 8,
                cutOutSize: MediaQuery.of(context).size.width * 0.8,
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              final list = controller.pluginsList;
              if (list.isEmpty) {
                return const Center(
                  child: Text(
                    'No paired plugins found',
                    style: TextStyle(fontSize: 16),
                  ),
                );
              }
              return ListView.separated(
                padding: const EdgeInsets.all(12),
                itemCount: list.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final plugin = list[index];
                  return ListTile(
                    leading: const Icon(Icons.extension, color: Colors.orange),
                    title: Text(
                      plugin.device,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(plugin.id),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        Get.defaultDialog(
                          title: "Unpair Plugin",
                          middleText:
                              "Are you sure you want to unpair this plugin?",
                          confirm: ElevatedButton(
                            onPressed: () async {
                              await controller.unpairPlugins(plugin.id);
                              await controller.listPlugins();
                            },
                            child: const Text("Yes"),
                          ),
                          cancel: ElevatedButton(
                            onPressed: () => Get.back(),
                            child: const Text("No"),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
