import 'package:get/get.dart';
import 'package:pegon_ai_mobile/app/data/api_service.dart';
import '../controllers/upgrade_controller.dart';

class UpgradeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiService>(() => ApiService());
    Get.lazyPut<UpgradeController>(() => UpgradeController());
  }
}
