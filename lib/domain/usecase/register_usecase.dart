// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:flutter_application_test/data/network/failure.dart';
import 'package:flutter_application_test/data/network/requests.dart';
import 'package:flutter_application_test/domain/models/models.dart';
import 'package:flutter_application_test/domain/repository/repository.dart';
import 'package:flutter_application_test/domain/usecase/base_usecase.dart';

class RegisterUseCase implements BaseUseCase<RegisterUseCaseInput,Authentication>{
  final Repository _repository;
  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(RegisterUseCaseInput input) async{
    return await _repository.register(RegisterRequest(
     input.userName,
       input.countryMobileCode,
        input.mobileNumber,
         input.email,
          input.password,
           input.profilePicture));
    
  }

}
class RegisterUseCaseInput {
  String userName;
  String countryMobileCode;
  String mobileNumber;
  String email;
  String password;
  String profilePicture;
  RegisterUseCaseInput({
    required this.userName,
    required this.countryMobileCode,
    required this.mobileNumber,
    required this.email,
    required this.password,
    required this.profilePicture,
  });
}
