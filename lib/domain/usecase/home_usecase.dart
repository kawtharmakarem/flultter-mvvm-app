import 'package:dartz/dartz.dart';
import 'package:flutter_application_test/data/network/failure.dart';
import 'package:flutter_application_test/domain/repository/repository.dart';
import 'package:flutter_application_test/domain/usecase/base_usecase.dart';

import '../models/models.dart';

class HomeUseCase implements BaseUseCase<void,HomeObject>{
  final Repository _repository;
  HomeUseCase(this._repository);
  
  @override
  Future<Either<Failure, HomeObject>> execute(void input) {
    return _repository.getHomeData();
  }
 
  
}