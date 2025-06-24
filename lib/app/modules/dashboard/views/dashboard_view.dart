import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../../data/variabels.dart';
import '../controllers/dashboard_controller.dart';

class _FeatureData {
  final String title;
  final IconData icon;
  final Color color;
  final int id;

  _FeatureData(this.title, this.icon, this.color, this.id);
}

class DashboardView extends GetView<DashboardController> {
  DashboardView({super.key});

  final List<_FeatureData> features = [
    _FeatureData("Text Transliterate", Icons.translate, Colors.green, 2),
    _FeatureData("Pair Plugins", Icons.extension, Colors.purple, 6),
    _FeatureData("Video Tutorials", Icons.play_circle_fill, Colors.pink, 3),
    _FeatureData("Big Data", Icons.bar_chart, Colors.blue, 5),
  ];

  void onTabTapped(int index) {
    if (menuItems[index].route == '/realtime' &&
        controller.profile.value?.name != 'Pro') {
      Get.toNamed('/upgrade');
      return;
    }
    Get.toNamed(menuItems[index].route);
  }

  Widget _buildCard(_FeatureData data) {
    return GestureDetector(
      onTap: () => onTabTapped(data.id),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: data.color,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(data.icon, color: Colors.white, size: 24),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  data.title,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      child: Scaffold(
        appBar: AppBar(backgroundColor: Variabels.orange, toolbarHeight: 20),
        floatingActionButton: Obx(() {
          if (controller.profile.value?.name != 'Pro') {
            return FloatingActionButton.extended(
              heroTag: 'upgrade',
              onPressed: () {
                Get.toNamed('/upgrade');
              },
              backgroundColor: Variabels.orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.workspace_premium, color: Colors.white),
                  const SizedBox(width: 8),
                  Text(
                    'Upgrade',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'PRO',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox.shrink(); // untuk kondisi name == 'Pro'
          }
        }),
        body: DoubleBackToCloseApp(
          snackBar: SnackBar(
            backgroundColor: Variabels.orange.withAlpha(150),
            content: const Text('Tap back again to leave'),
          ),
          child: SafeArea(
            child: Obx(() {
              return RefreshIndicator(
                onRefresh: () async {
                  Get.offAllNamed('/dashboard');
                },
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        GestureDetector(
                          onTap: () {
                            onTabTapped(4);
                          },
                          child: Container(
                            width: double.infinity,
                            color: Variabels.orange,
                            padding: const EdgeInsets.fromLTRB(24, 0, 24, 150),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white.withAlpha(150),
                                      width: 4,
                                    ),
                                  ),
                                  child: Container(
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 4,
                                      ),
                                    ),
                                    child: CircleAvatar(
                                      backgroundImage:
                                          Image.asset(
                                            controller.profile.value?.avatar ??
                                                'assets/images/avatar_boy.webp',
                                          ).image,
                                      backgroundColor: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.profile.value?.name ??
                                          'Full Name',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      controller
                                              .profile
                                              .value
                                              ?.expired
                                              .capitalize ??
                                          'Has No Expiration Date',
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(36),
                                  ),
                                  child: Text(
                                    controller
                                            .profile
                                            .value
                                            ?.category
                                            .capitalize ??
                                        'Free',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Variabels.orange,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: -80,
                          left: 16,
                          right: 16,
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => onTabTapped(0),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    elevation: 4,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 24,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.camera_alt,
                                            size: 64,
                                            color: Variabels.orange,
                                          ),
                                          const Text(
                                            'Realtime',
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          const Text(
                                            'Point camera to\ntransliterate instantly',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => onTabTapped(1),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    elevation: 4,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 24,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: const [
                                          Icon(
                                            Icons.image,
                                            size: 64,
                                            color: Colors.blue,
                                          ),
                                          Text(
                                            'Image',
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            'Upload or take photo to\ntransliterate',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 100),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children:
                            features.map((data) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 0),
                                child: _buildCard(data),
                              );
                            }).toList(),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 20,
                      ),
                      child: Text(
                        'History',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Obx(() {
                        if (controller.histories.isEmpty &&
                            !controller.isLoading.value) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height * 0.4,
                            child: const Center(
                              child: Text("No history available."),
                            ),
                          );
                        }

                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.histories.length + 1,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                childAspectRatio: 2 / 3.1,
                              ),
                          itemBuilder: (context, index) {
                            if (index < controller.histories.length) {
                              final history = controller.histories[index];
                              return HistoryCard(
                                history: history,
                                onDelete:
                                    () => controller.deleteHistory(history.id),
                              );
                            } else {
                              return controller.isLoading.value
                                  ? const Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                  : const SizedBox();
                            }
                          },
                        );
                      }),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class MenuItem {
  final IconData icon;
  final String text;
  final String route;

  MenuItem({required this.icon, required this.text, required this.route});
}

final List<MenuItem> menuItems = [
  MenuItem(icon: Icons.photo_camera, text: 'Realtime', route: '/realtime'),
  MenuItem(icon: Icons.image, text: 'Photo', route: '/photo'),
  MenuItem(icon: Icons.text_fields, text: 'Text', route: '/text'),
  MenuItem(icon: Icons.video_library, text: 'Tutorials', route: '/tutorials'),
  MenuItem(icon: Icons.tune, text: 'Settings', route: '/settings'),
  MenuItem(icon: Icons.history, text: 'History', route: '/big-data'),
  MenuItem(icon: Icons.workspace_premium, text: 'Plugins', route: '/plugins'),
];

class HistoryCard extends StatelessWidget {
  final History history;
  final VoidCallback onDelete;

  const HistoryCard({super.key, required this.history, required this.onDelete});

  void _confirmDelete(BuildContext context) {
    Get.defaultDialog(
      title: "Confirm Delete",
      middleText: "Are you sure you want to delete this history?",
      textCancel: "No",
      textConfirm: "Delete",
      confirmTextColor: Colors.white,
      cancelTextColor: Colors.black,
      onConfirm: () {
        Get.back();
        onDelete();
      },
      buttonColor: Colors.red,
    );
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl =
        history.image.isNotEmpty
            ? history.image
            : 'https://via.placeholder.com/150';

    return GestureDetector(
      onTap: () => Get.toNamed('/read-history', parameters: {"id": history.id}),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      placeholder:
                          (context, url) => const SizedBox(
                            child: Center(child: CircularProgressIndicator()),
                          ),
                      errorWidget:
                          (context, url, error) => const SizedBox(
                            child: Center(child: Icon(Icons.broken_image)),
                          ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  history.date,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => _confirmDelete(context),
                  icon: const Icon(Icons.delete),
                  label: const Text('Delete'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    textStyle: const TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
