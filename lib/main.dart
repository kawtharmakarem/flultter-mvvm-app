import 'package:flutter/material.dart';
import 'package:flutter_application_test/app/di.dart';

import 'app/app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  initAppModule();
  runApp( MyApp());
}

//https://minafarid246.wiremockapi.cloud/

//flutter pub run build_runner build --delete-conflicting-outputs