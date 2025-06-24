import 'package:get/get.dart';
import 'package:pegon_ai_mobile/app/data/api_service.dart';

import '../controllers/watch_tutorial_controller.dart';

class WatchTutorialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiService>(() => ApiService());
    Get.lazyPut<WatchTutorialController>(() => WatchTutorialController());
  }
}
