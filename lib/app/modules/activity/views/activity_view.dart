import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pegon_ai_mobile/app/data/variabels.dart';

import '../controllers/activity_controller.dart';

class ActivityView extends GetView<ActivityController> {
  const ActivityView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Activity History',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Variabels.orange,
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.activities.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.activities.isEmpty) {
          return const Center(
            child: Text('No activity found', style: TextStyle(fontSize: 18)),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            await controller.activityList(refresh: true);
          },
          child: ListView.builder(
            itemCount: controller.activities.length,
            itemBuilder: (context, index) {
              final activity = controller.activities[index];
              final isSystemDevice = activity.device.toLowerCase().contains(
                'system',
              );

              final badgeColor =
                  isSystemDevice ? Colors.grey : Variabels.orange;

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  title: Text(
                    activity.action,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: badgeColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          activity.device,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        activity.time,
                        style: const TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
