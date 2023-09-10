import 'package:dartz/dartz.dart';
import 'package:flutter_application_test/data/data_source/remote_data_source.dart';
import 'package:flutter_application_test/data/mapper/mapper.dart';

import 'package:flutter_application_test/data/network/failure.dart';
import 'package:flutter_application_test/data/network/network_info.dart';

import 'package:flutter_application_test/data/network/requests.dart';

import 'package:flutter_application_test/domain/models/models.dart';

import '/domain/repository/repository.dart';

class RepositoryImpl implements Repository{
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;
  RepositoryImpl(this._remoteDataSource,this._networkInfo);
  @override
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest) async {
    if(await _networkInfo.isConnected)
    {
     final response=await _remoteDataSource.login(loginRequest);
     if(response.status==0){
      //success
      return Right(response.toDomain());
     }else{
     //return failure bussiness
     return Left(Failure(409, response.message ?? "business error"));
     }
    }else
    {
      //return internet connection error
      return Left(Failure(501,"Please check your internet connection"));
    }
  }

}