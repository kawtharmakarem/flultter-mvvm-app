import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_test/presentation/resources/assets_manager.dart';
import 'package:flutter_application_test/presentation/resources/color_manager.dart';
import 'package:flutter_application_test/presentation/resources/constants_manager.dart';
import 'package:flutter_application_test/presentation/resources/routes_manager.dart';
import 'package:flutter_application_test/app/di.dart';

import '../../app/app_prefs.dart';


class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final AppPreferences _appPreferences=instance<AppPreferences>();
  Timer? _timer;
  _startDelay() {
    _timer = Timer(const Duration(seconds: AppConstants.splashDelay), _goNext);
  }

_goNext() async{
  _appPreferences.isUserLoggedIn().then((isUserLoggedIn) => {
    if(isUserLoggedIn)
    {
     Navigator.pushReplacementNamed(context, Routes.mainRoute)
    }else
    {
      _appPreferences.isOnBoardingScreenViewed().then((isOnBoardingViewed) => {
        if(isOnBoardingViewed)
        {
           Navigator.pushReplacementNamed(context, Routes.loginRoute)
        }
        else
        {
      Navigator.pushReplacementNamed(context, Routes.mainRoute)
        }
      })
    }

  });
}
@override
  void initState() {
    super.initState();
    _startDelay();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body:
          const Center(child: Image(image: AssetImage(ImageAssets.splashLogo))),
    );
  }
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
