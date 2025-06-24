import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../../data/variabels.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;

    void onTabTapped(int index) {
      currentIndex = index;
      if (menuItems[index].route == '/realtime' &&
          controller.profile.value?.name != 'Pro') {
        Get.toNamed('/upgrade');
        return;
      }
      Get.toNamed(menuItems[index].route);
    }

    return GlobalLoaderOverlay(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 0,
          backgroundColor: Variabels.orange,
          elevation: 0,
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Variabels.orange,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          currentIndex: currentIndex,
          onTap: onTabTapped,
          type: BottomNavigationBarType.fixed,
          items:
              menuItems
                  .map(
                    (item) => BottomNavigationBarItem(
                      icon: Icon(item.icon),
                      label: item.text,
                    ),
                  )
                  .toList(),
        ),
        floatingActionButton: Obx(() {
          return Align(
            alignment: Alignment.bottomRight,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                FloatingActionButton(
                  heroTag: 'refresh',
                  onPressed: () async {
                    Get.offAllNamed('/dashboard');
                  },
                  backgroundColor: Variabels.orange,
                  child: const Icon(Icons.refresh),
                ),
                const SizedBox(height: 8),
                if (controller.profile.value?.name != 'Pro')
                  FloatingActionButton.extended(
                    heroTag: 'upgrade',
                    onPressed: () {
                      Get.toNamed('/upgrade');
                    },
                    backgroundColor: Variabels.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    label: Row(
                      children: [
                        Icon(Icons.workspace_premium, color: Colors.white),
                        const SizedBox(width: 8),
                        Text(
                          'Upgrade',
                          style: TextStyle(
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
                  ),
              ],
            ),
          );
        }),
        body: DoubleBackToCloseApp(
          snackBar: SnackBar(
            backgroundColor: Variabels.orange.withAlpha(150),
            content: Text('Tap back again to leave'),
          ),
          child: SafeArea(
            child: Obx(() {
              return RefreshIndicator(
                onRefresh: () async {
                  Get.offAllNamed('/dashboard');
                },
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Variabels.orange,
                        borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(36),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 18,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.profile.value?.name ??
                                          'Nama Lengkap',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      controller.profile.value?.id ?? '-',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () => Get.toNamed('/settings'),
                                  child: Container(
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 4.0,
                                      ),
                                    ),
                                    child: CircleAvatar(
                                      radius: 36,
                                      backgroundImage:
                                          Image.asset(
                                            controller.profile.value?.avatar ??
                                                'assets/images/avatar_boy.webp',
                                          ).image,
                                      backgroundColor: Colors.grey[300],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            SizedBox(
                              width: double.infinity,
                              child: Row(
                                children: [
                                  Container(
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black26,
                                          spreadRadius: 3,
                                          blurRadius: 5,
                                          offset: Offset(3, 3),
                                        ),
                                      ],
                                    ),
                                    padding: const EdgeInsets.all(16),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_month,
                                          size: 24,
                                          color: Variabels.orange,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Container(
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          const BorderRadius.horizontal(
                                            left: Radius.circular(8),
                                            right: Radius.circular(32),
                                          ),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black26,
                                          spreadRadius: 3,
                                          blurRadius: 5,
                                          offset: Offset(3, 3),
                                        ),
                                      ],
                                    ),
                                    padding: const EdgeInsets.all(16),
                                    child: Row(
                                      children: [
                                        Icon(Icons.workspace_premium, size: 24),
                                        const SizedBox(width: 8),
                                        Text(
                                          controller.profile.value?.category ??
                                              'free',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 18,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'History',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28),
                        child: Obx(() {
                          if (controller.histories.isEmpty &&
                              !controller.isLoading.value) {
                            return SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
                                child: const Center(
                                  child: Text("No history available."),
                                ),
                              ),
                            );
                          }

                          return GridView.builder(
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
                                      () =>
                                          controller.deleteHistory(history.id),
                                );
                              } else {
                                return controller.isLoading.value
                                    ? const Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(16),
                                        child: CircularProgressIndicator(),
                                      ),
                                    )
                                    : const SizedBox();
                              }
                            },
                          );
                        }),
                      ),
                    ),
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
