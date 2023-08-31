import 'package:flutter/material.dart';
import 'package:flutter_application_test/presentation/resources/routes_manager.dart';
import 'package:flutter_application_test/presentation/resources/theme_manager.dart';

class MyApp extends StatefulWidget {

//named constructor
MyApp._internal();
static final MyApp _instance=MyApp._internal();
factory MyApp()=>_instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getApplicationTheme(),
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
    );
  }
}