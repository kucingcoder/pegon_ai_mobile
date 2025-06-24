import 'package:get/get.dart';

import '../controllers/big_data_controller.dart';

class BigDataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BigDataController>(
      () => BigDataController(),
    );
  }
}
