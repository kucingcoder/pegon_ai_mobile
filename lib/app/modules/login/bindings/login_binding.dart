import 'package:get/get.dart';
import 'package:pegon_ai_mobile/app/data/api_service.dart';
import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiService>(() => ApiService());
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
