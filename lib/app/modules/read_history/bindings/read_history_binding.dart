import 'package:get/get.dart';
import 'package:pegon_ai_mobile/app/data/api_service.dart';
import '../controllers/read_history_controller.dart';

class ReadHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiService>(() => ApiService());
    Get.lazyPut<ReadHistoryController>(() => ReadHistoryController());
  }
}
