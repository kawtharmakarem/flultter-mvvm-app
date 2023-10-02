import 'package:dartz/dartz.dart';
import 'package:flutter_application_test/data/network/failure.dart';
import 'package:flutter_application_test/domain/models/models.dart';

import '/data/network/requests.dart';

abstract class Repository{
Future<Either<Failure,Authentication>> login(LoginRequest loginRequest);
//forgot password
Future<Either<Failure,String>> forgotPassword(String email);
}