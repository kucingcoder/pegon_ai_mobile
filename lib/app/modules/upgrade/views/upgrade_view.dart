import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pegon_ai_mobile/app/data/variabels.dart';
import '../controllers/upgrade_controller.dart';

class UpgradeView extends GetView<UpgradeController> {
  const UpgradeView({super.key});
  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      child: Scaffold(
        appBar: AppBar(title: const Text('Upgrade to Pro')),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        const Spacer(),
                        Image.asset(
                          'assets/images/upgrade.webp',
                          width: 200,
                          height: 200,
                        ),
                        const Text(
                          'Upgrade to Pro',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const Text(
                          'Get full access & unlimited usage',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Icon(
                              Icons.check_box_rounded,
                              color: Colors.green,
                              size: 32,
                            ),
                            const SizedBox(width: 16),
                            Text(
                              'No Ads',
                              style: TextStyle(
                                color: Variabels.orange,
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.check_box_rounded,
                              color: Colors.green,
                              size: 32,
                            ),
                            const SizedBox(width: 16),
                            Text(
                              'Unlimited Usage',
                              style: TextStyle(
                                color: Variabels.orange,
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.check_box_rounded,
                              color: Colors.green,
                              size: 32,
                            ),
                            const SizedBox(width: 16),
                            Text(
                              'Realtime Transliteration',
                              style: TextStyle(
                                color: Variabels.orange,
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.check_box_rounded,
                              color: Colors.green,
                              size: 32,
                            ),
                            const SizedBox(width: 16),
                            Text(
                              'MS Word Integration',
                              style: TextStyle(
                                color: Variabels.orange,
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'PRO',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Rp. 25.000',
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    '/ month',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              controller.upgrade();
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
                              'Upgrade Now'.toUpperCase(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
