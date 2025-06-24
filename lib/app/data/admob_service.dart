import 'package:get/get_utils/src/platform/platform.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobService {
  static String? get bannerAdUnitId {
    if (GetPlatform.isAndroid) {
      return 'ca-app-pub-1144248073011584/4891199134';
    }

    return null;
  }

  static String? get interstitialAdUnitId {
    if (GetPlatform.isAndroid) {
      return 'ca-app-pub-1144248073011584/6907670570';
    }

    return null;
  }

  static final BannerAdListener bannerAdListener = BannerAdListener(
    onAdLoaded: (ad) => print('Ad loaded.'),
    onAdFailedToLoad: (ad, error) {
      ad.dispose();
      print('Ad failed to load: $error');
    },
    onAdOpened: (Ad ad) => print('Ad opened.'),
    onAdClosed: (Ad ad) => print('Ad closed.'),
  );
}
