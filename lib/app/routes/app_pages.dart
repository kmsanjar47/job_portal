import 'package:get/get.dart';
import 'package:job_portal/app/views/navigation_view.dart';

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
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.NAVIGATION,
      page: () => const NavigationView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => const AuthView(),
      binding: HomeBinding(),
    ),
  ];
}
