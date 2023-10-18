import 'dart:async';

import 'package:flutter_application_test/domain/models/models.dart';
import 'package:flutter_application_test/domain/usecase/home_usecase.dart';
import 'package:flutter_application_test/presentation/base/baseviewmodel.dart';

class HomeViewModel extends BaseViewModel {
  final StreamController _bannersStreamController =
      StreamController<List<BannerAd>>.broadcast();
  final StreamController _srevicesStreamController =
      StreamController<List<Service>>.broadcast();
  final StreamController _storesStreamController =
      StreamController<List<Store>>.broadcast();

  final HomeUseCase _homeUseCase;
  HomeViewModel(this._homeUseCase);
  @override
  void start() {}
  @override
  void dispose() {
    _bannersStreamController.close();
    _srevicesStreamController.close();
    _storesStreamController.close();
    super.dispose();
  }
}
