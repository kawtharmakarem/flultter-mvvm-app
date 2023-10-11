
import 'package:flutter/material.dart';
import 'package:flutter_application_test/app/app_prefs.dart';
import 'package:flutter_application_test/app/di.dart';
import 'package:flutter_application_test/presentation/resources/assets_manager.dart';
import 'package:flutter_application_test/presentation/resources/routes_manager.dart';
import 'package:flutter_application_test/presentation/resources/strings_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final AppPreferences _appPreferences=instance<AppPreferences>();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListTile(
        leading: SvgPicture.asset(ImageAssets.logoutIc),
        title: Text(AppStrings.logout,style: Theme.of(context).textTheme.bodyLarge,),
        trailing: SvgPicture.asset(ImageAssets.rightArrowIc),
          onTap: (){
            _appPreferences.logout();
    Navigator.pushReplacementNamed(context, Routes.loginRoute);


          },
      ),
    );
  }
  
  // _logout()  {
  //   // _appPreferences.logout();
  //   Navigator.pushReplacementNamed(context, Routes.loginRoute);
  // }
}