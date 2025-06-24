import 'package:get/get.dart';

class PayController extends GetxController {
  final snapToken = Get.parameters['snap_token'];
  final paymentId = Get.parameters['payment_id'];
}
