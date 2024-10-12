import 'package:ayni_mobile_app/iam/screens/login_view.dart';
import 'package:ayni_mobile_app/iam/screens/register_view.dart';
import 'package:go_router/go_router.dart';

final routes = GoRouter(
  initialLocation: "/login",
  routes: <GoRoute>[
    GoRoute(
      path: '/login',
      name: "login_view",
      builder: (context, state) => const LoginView(),
    ),
    GoRoute(
      path: '/register',
      name: "register_view",
      builder: (context, state) => const RegisterView(),
    ),
  ],
);
