import 'package:flutter/material.dart';
import 'package:flutter_application_test/app/di.dart';
import 'package:flutter_application_test/presentation/forgot_password/forgot_password_view.dart';
import 'package:flutter_application_test/presentation/login/view/login_view.dart';
import 'package:flutter_application_test/presentation/main/main_view.dart';
import 'package:flutter_application_test/presentation/onboarding/view/onboarding_view.dart';
import 'package:flutter_application_test/presentation/register/view/register_view.dart';
import 'package:flutter_application_test/presentation/resources/strings_manager.dart';
import 'package:flutter_application_test/presentation/splash/splash_view.dart';
import 'package:flutter_application_test/presentation/store_details/store_details_view.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onBoarding="/onboarding";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgotPasswordRoute = "/forgotpassword";
  static const String mainRoute = "/main";
  static const String storeDetailsRoute = "/storedetails";
}
class RouteGenerator{
  static Route<dynamic> getRoute(RouteSettings settings){
    switch(settings.name){
      case Routes.splashRoute:
      return MaterialPageRoute(builder:(_)=> const SplashView());
      case Routes.onBoarding:
      return MaterialPageRoute(builder: (_)=>const OnBoardingView());
      case Routes.loginRoute:
      initLoginModule();
      return MaterialPageRoute(builder: (_)=>const LoginView());
      case Routes.registerRoute:
      initRegisterModule();
      return MaterialPageRoute(builder: (_)=>const RegisterView());
      case Routes.forgotPasswordRoute:
      initForgotPasswordModule();
        return MaterialPageRoute(builder: (_)=> const ForgotPasswordView());
      case Routes.mainRoute:
      return MaterialPageRoute(builder: (_)=>const MainView());
      case Routes.storeDetailsRoute:
      return MaterialPageRoute(builder: (_)=>const StoreDetailsView());
      default:
      return unDefinedRoute();
    }
  }
  
  static Route<dynamic> unDefinedRoute()
   {
    return MaterialPageRoute(builder: (_)=>Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.noRouteFound),
      ),
      body: const Center(child: Text(AppStrings.noRouteFound)),
    ));
   }
}