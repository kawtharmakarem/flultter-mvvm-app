import 'package:dartz/dartz.dart';
import 'package:flutter_application_test/data/data_source/remote_data_source.dart';
import 'package:flutter_application_test/data/mapper/mapper.dart';
import 'package:flutter_application_test/data/network/error_handler.dart';

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

     try{
       final response=await _remoteDataSource.login(loginRequest);
     if(response.status==ApiInternalStatus.SUCCESS){
      //success
      return Right(response.toDomain());
     }else{
     //return failure bussiness
     return Left(Failure(ApiInternalStatus.FAILURE, response.message ?? ResponseMessage.DEFAULT));
     }
     }catch(error){
      return Left(ErrorHandler.handle(error).failure);
     }

     
    }else
    {
      //return internet connection error
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

}