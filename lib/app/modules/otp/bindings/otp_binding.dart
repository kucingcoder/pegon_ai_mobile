import 'package:get/get.dart';
import 'package:pegon_ai_mobile/app/data/api_service.dart';
import '../controllers/otp_controller.dart';

class OtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiService>(() => ApiService());
    Get.lazyPut<OtpController>(() => OtpController());
  }
}
