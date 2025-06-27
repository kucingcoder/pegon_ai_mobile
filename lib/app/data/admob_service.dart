import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:get_storage/get_storage.dart';

class AdmobService extends GetxService {
  final box = GetStorage();

  Future<AdmobService> init() async {
    await MobileAds.instance.initialize();
    return this;
  }

  String get bannerAdUnitId {
    if (GetPlatform.isAndroid) {
      return 'ca-app-pub-1144248073011584/4891199134';
    }
    return '';
  }

  bool get isProUser => box.read('category') == 'pro';

  BannerAdListener get defaultBannerListener => BannerAdListener(
    onAdFailedToLoad: (ad, error) {
      ad.dispose();
    },
  );
}
