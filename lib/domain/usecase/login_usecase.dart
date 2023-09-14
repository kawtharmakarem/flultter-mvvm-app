import 'package:dartz/dartz.dart';
import 'package:flutter_application_test/data/network/failure.dart';
import 'package:flutter_application_test/data/network/requests.dart';
import 'package:flutter_application_test/domain/models/models.dart';
import 'package:flutter_application_test/domain/repository/repository.dart';
import 'package:flutter_application_test/domain/usecase/base_usecase.dart';

class LoginUseCase implements BaseUseCase<LoginInputUseCaseInput,Authentication>{
  final Repository _repository;
  LoginUseCase(this._repository);
  @override
  Future<Either<Failure, Authentication>> execute(LoginInputUseCaseInput input) async{
   return await _repository.login(LoginRequest(input.email, input.password));
   
  }

}

class LoginInputUseCaseInput{
  String email;
  String password;
  LoginInputUseCaseInput(this.email,this.password);
}