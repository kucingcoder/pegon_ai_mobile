import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pegon_ai_mobile/app/data/reusable_ad_banner_widget.dart';
import 'package:pegon_ai_mobile/app/data/variabels.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    final nameFieldController = TextEditingController();
    final dobFieldController = TextEditingController();

    return GlobalLoaderOverlay(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'Settings',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          backgroundColor: Variabels.orange,
        ),
        body: LoaderOverlay(
          child: SafeArea(
            child: Obx(() {
              nameFieldController.text = controller.name.value;
              dobFieldController.text = controller.dateOfBirth.value;

              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 40,
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Variabels.orange,
                            width: 4.0,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 36,
                          backgroundImage:
                              controller.profilePicture.value.isNotEmpty
                                  ? AssetImage(controller.profilePicture.value)
                                  : const AssetImage(
                                        'assets/images/avatar_boy.webp',
                                      )
                                      as ImageProvider,
                          backgroundColor: Colors.grey[300],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        controller.id.value.isNotEmpty
                            ? 'ID: ${controller.id.value}'
                            : 'ID: Not available',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      const SizedBox(height: 28),
                      TextFormField(
                        controller: nameFieldController,
                        decoration: const InputDecoration(
                          labelText: 'Full Name',
                          hintText: 'Joko Widodo',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          prefixIcon: Icon(Icons.person),
                        ),
                        onChanged: (val) => controller.name.value = val,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your full name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        value:
                            controller.gender.value.isEmpty
                                ? null
                                : controller.gender.value,
                        decoration: const InputDecoration(
                          labelText: 'Gender',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          prefixIcon: Icon(Icons.person_outline),
                        ),
                        items: const [
                          DropdownMenuItem(value: 'male', child: Text('Male')),
                          DropdownMenuItem(
                            value: 'female',
                            child: Text('Female'),
                          ),
                          DropdownMenuItem(
                            value: 'other',
                            child: Text('Other'),
                          ),
                        ],
                        onChanged: (value) {
                          if (value != null) controller.gender.value = value;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: dobFieldController,
                        onTap: () async {
                          FocusScope.of(context).unfocus();
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime(2000),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );
                          if (picked != null) {
                            final selectedDate =
                                picked.toIso8601String().split('T').first;
                            controller.dateOfBirth.value = selectedDate;
                          }
                        },
                        decoration: const InputDecoration(
                          labelText: 'Date of Birth',
                          hintText: 'YYYY-MM-DD',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          prefixIcon: Icon(Icons.calendar_today),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Date of birth is required';
                          }
                          return null;
                        },
                      ),
                      controller.isPro.value
                          ? const SizedBox.shrink()
                          : Column(
                            children: [
                              const SizedBox(height: 16),
                              const ReusableAdBannerWidget(),
                            ],
                          ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState?.validate() ?? false) {
                              await controller.updateProfile();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 4,
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            backgroundColor: Variabels.orange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(36),
                            ),
                          ),
                          child: Text(
                            'Save',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Get.toNamed('/activity');
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 4,
                                textStyle: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                backgroundColor: Variabels.orange,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(36),
                                ),
                              ),
                              child: Text(
                                'Activities',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Get.toNamed('/payment-history');
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 4,
                                textStyle: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                backgroundColor: Variabels.orange,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(36),
                                ),
                              ),
                              child: Text(
                                'Payments',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            await controller.logout();
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 4,
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(36),
                            ),
                          ),
                          child: Text(
                            'Logout',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
        bottomNavigationBar: Obx(() {
          return controller.isPro.value
              ? const SizedBox.shrink()
              : const ReusableAdBannerWidget();
        }),
      ),
    );
  }
}
