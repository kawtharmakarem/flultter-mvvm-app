import 'package:dio/dio.dart';
import 'package:flutter_application_test/app/app_prefs.dart';
import 'package:flutter_application_test/data/data_source/remote_data_source.dart';
import 'package:flutter_application_test/data/network/app_api.dart';
import 'package:flutter_application_test/data/network/dio_factory.dart';
import 'package:flutter_application_test/data/network/network_info.dart';
import 'package:flutter_application_test/data/repository/repository_impl.dart';
import 'package:flutter_application_test/domain/repository/repository.dart';
import 'package:flutter_application_test/domain/usecase/forgotpassword_usecase.dart';
import 'package:flutter_application_test/domain/usecase/login_usecase.dart';
import 'package:flutter_application_test/presentation/forgot_password/forgot_password_viewmodel.dart';
import 'package:flutter_application_test/presentation/login/viewmodel/login_viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

//for all app
Future<void> initAppModule() async {
//shared preferences
  final sharedPrefs = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
  //app prefs
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));
  //net work info
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));
  //dio factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));
  //app service client
  Dio dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));
  //remote data source
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(instance()));
  //repository
  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance()));
}

initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
  
}
initForgotPasswordModule(){
  if(!GetIt.I.isRegistered<ForgotPasswordUseCase>()){
    instance.registerFactory<ForgotPasswordUseCase>(() => ForgotPasswordUseCase(instance()));
    instance.registerFactory<ForgotPasswordViewModel>(() => ForgotPasswordViewModel(instance()));
  }
}
