import 'package:get/get.dart';

import '../modules/activity/bindings/activity_binding.dart';
import '../modules/activity/views/activity_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/otp/bindings/otp_binding.dart';
import '../modules/otp/views/otp_view.dart';
import '../modules/pay/bindings/pay_binding.dart';
import '../modules/pay/views/pay_view.dart';
import '../modules/payment_history/bindings/payment_history_binding.dart';
import '../modules/payment_history/views/payment_history_view.dart';
import '../modules/photo/bindings/photo_binding.dart';
import '../modules/photo/views/photo_view.dart';
import '../modules/read_history/bindings/read_history_binding.dart';
import '../modules/read_history/views/read_history_view.dart';
import '../modules/realtime/bindings/realtime_binding.dart';
import '../modules/realtime/views/realtime_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/text/bindings/text_binding.dart';
import '../modules/text/views/text_view.dart';
import '../modules/tutorials/bindings/tutorials_binding.dart';
import '../modules/tutorials/views/tutorials_view.dart';
import '../modules/upgrade/bindings/upgrade_binding.dart';
import '../modules/upgrade/views/upgrade_view.dart';
import '../modules/watch_tutorial/bindings/watch_tutorial_binding.dart';
import '../modules/watch_tutorial/views/watch_tutorial_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.home;

  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.REALTIME,
      page: () => RealtimeView(),
      binding: RealtimeBinding(),
    ),
    GetPage(
      name: _Paths.PHOTO,
      page: () => const PhotoView(),
      binding: PhotoBinding(),
    ),
    GetPage(
      name: _Paths.TEXT,
      page: () => const TextView(),
      binding: TextBinding(),
    ),
    GetPage(
      name: _Paths.READ_HISTORY,
      page: () => const ReadHistoryView(),
      binding: ReadHistoryBinding(),
    ),
    GetPage(
      name: _Paths.TUTORIALS,
      page: () => const TutorialsView(),
      binding: TutorialsBinding(),
    ),
    GetPage(
      name: _Paths.WATCH_TUTORIAL,
      page: () => const WatchTutorialView(),
      binding: WatchTutorialBinding(),
    ),
    GetPage(name: _Paths.OTP, page: () => OtpView(), binding: OtpBinding()),
    GetPage(
      name: _Paths.UPGRADE,
      page: () => const UpgradeView(),
      binding: UpgradeBinding(),
    ),
    GetPage(
      name: _Paths.PAY,
      page: () => const PayView(),
      binding: PayBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT_HISTORY,
      page: () => const PaymentHistoryView(),
      binding: PaymentHistoryBinding(),
    ),
    GetPage(
      name: _Paths.ACTIVITY,
      page: () => const ActivityView(),
      binding: ActivityBinding(),
    ),
  ];
}
