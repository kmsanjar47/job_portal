import 'package:get/get.dart';
import 'package:job_portal/app/bindings/navigation_binding.dart';
import 'package:job_portal/app/views/navigation_view.dart';
import 'package:job_portal/app/views/navigation_view_publisher.dart';

import '../bindings/auth_binding.dart';
import '../bindings/home_binding.dart';
import '../views/auth_view.dart';
import '../views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.AUTH;


  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.NAVIGATION,
      page: () => const NavigationView(),
      binding: NavigationBinding(),
    ),
    GetPage(
      name: _Paths.NAVIGATION_PUBLISHER,
      page: () => const NavigationViewPublisher(),
      binding: NavigationBinding(),
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => const AuthView(),
      binding: AuthBinding(),
    ),
  ];
}
