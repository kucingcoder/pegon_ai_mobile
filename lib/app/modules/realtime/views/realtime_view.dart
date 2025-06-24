import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pegon_ai_mobile/app/data/variabels.dart';
import 'package:ultralytics_yolo/yolo_task.dart';
import 'package:ultralytics_yolo/yolo_view.dart';
import '../controllers/realtime_controller.dart';

class RealtimeView extends GetView<RealtimeController> {
  const RealtimeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          'Reltime Transliteration',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Variabels.orange,
      ),
      body: const Center(
        child: YOLOView(modelPath: 'pegon', task: YOLOTask.detect),
      ),
    );
  }
}
