import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:midtrans_snap/midtrans_snap.dart';
import 'package:midtrans_snap/models.dart';
import 'package:pegon_ai_mobile/app/data/variabels.dart';

import '../controllers/pay_controller.dart';

class PayView extends GetView<PayController> {
  const PayView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Pay Upgrade to Pro',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Variabels.orange,
      ),
      body: MidtransSnap(
        mode: MidtransEnvironment.production,
        token: controller.snapToken!,
        midtransClientKey: Variabels.midtransClientKey,
        onResponse: (result) {
          Get.offAllNamed('/dashboard');
        },
      ),
    );
  }
}
