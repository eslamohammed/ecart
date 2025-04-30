import 'package:ecart/screens/onboarding/OnBoardingView.dart';
import 'package:ecart/screens/product_detail_screen.dart';
import 'package:ecart/screens/product_list_screen.dart';
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../screens/splash_view.dart';
import 'color_manager.dart';

class Routes {
  static const String splashRoute = "/";
  static const String homeRoute = "/main";
  static const String detailsRoute = "/details";
  static const String onBoardingRoute = "/onBoarding";

}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => const OnBoardingView());
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) => const ProductListScreen());
      case Routes.detailsRoute:
        final product = settings.arguments as Product;
        return MaterialPageRoute(
          builder: (_) => ProductDetailScreen(product: product),
        );
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder:
          (BuildContext context) => Scaffold(
            appBar: AppBar(
              title: const Text("No Route Founded!"),
              elevation: 1,
            ),
            body: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.close_rounded,
                    size: 25.0,
                    color: ColorManager.error,
                  ),
                  Text("No Route Founded!"),
                ],
              ),
            ),
          ),
    );
  }
}
