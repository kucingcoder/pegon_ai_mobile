import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pegon_ai_mobile/app/data/variabels.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'app/routes/app_pages.dart';

Future<void> main() async {
  await GetStorage.init();

  var initroute = AppPages.initial;

  final storage = GetStorage();
  if (storage.read('api_key') != null && storage.read('token') != null) {
    initroute = Routes.DASHBOARD;
  }

  final deviceInfo = DeviceInfoPlugin();
  final androidInfo = await deviceInfo.androidInfo;
  Variabels.device = androidInfo.name;

  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.updateRequestConfiguration(
    RequestConfiguration(testDeviceIds: ['E87B0DBA8F6A2BC544CA072ED77037B9']),
  );
  MobileAds.instance.initialize();

  runApp(
    GetMaterialApp(
      title: "Pegon AI",
      initialRoute: initroute,
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
      getPages: AppPages.routes,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Variabels.orange,
          secondary: Colors.white,
          onSurface: Colors.black,
        ),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Nunito',
      ),
      debugShowCheckedModeBanner: false,
    ),
  );
}
