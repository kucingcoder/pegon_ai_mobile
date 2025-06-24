import 'package:get/get.dart';
import 'package:pegon_ai_mobile/app/data/api_service.dart';
import '../controllers/tutorials_controller.dart';

class TutorialsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiService>(() => ApiService());
    Get.lazyPut<TutorialsController>(() => TutorialsController());
  }
}
