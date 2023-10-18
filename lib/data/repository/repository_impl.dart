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
   
   //forgotPassword
  @override
  Future<Either<Failure, String>> forgotPassword(String email) async {
    if(await _networkInfo.isConnected)
    {
      try{
        final response=await _remoteDataSource.forgotPassword(email);
        if(response.status==ApiInternalStatus.SUCCESS){
          return Right(response.toDomain());
        }else{
          return Left(Failure(response.status ?? ResponseCode.DEFAULT, response.message ?? ResponseMessage.DEFAULT));
        }
      }catch(error)
      {
        return Left(ErrorHandler.handle(error).failure);
      }

    }else
    {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
  //register
  @override
  Future<Either<Failure, Authentication>> register(RegisterRequest registerRequest) async{
    if(await _networkInfo.isConnected)
    {
      try{
        final response=await _remoteDataSource.register(registerRequest);
        if(response.status==ApiInternalStatus.SUCCESS){
          return Right(response.toDomain());
        }else{
          return Left(Failure(ApiInternalStatus.FAILURE, response.message ?? ResponseMessage.DEFAULT));
        }
      }catch(error){
        return Left(ErrorHandler.handle(error).failure);
      }

    }else
    {
     return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
   
  }
  
  @override
  Future<Either<Failure, HomeObject>> getHomeData() async{
    if(await _networkInfo.isConnected)
    {
      try{
        final response=await _remoteDataSource.getHomeData();
        if(response.status==ApiInternalStatus.SUCCESS)
        {
          return Right(response.toDomain());
        }else{
          return Left(Failure(ApiInternalStatus.FAILURE, response.message ?? ResponseMessage.DEFAULT));
        }
      }
      catch(error)
      {
        return Left(ErrorHandler.handle(error).failure);
      }

    }else{
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

}