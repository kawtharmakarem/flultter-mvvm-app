import 'package:json_annotation/json_annotation.dart';
part 'responses.g.dart';
@JsonSerializable()
class BaseResponse {
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'message')
  String? message;
}

@JsonSerializable()
class CustomerResponse{
@JsonKey(name:'id')
String? id;
@JsonKey(name:'name')
String? name;
@JsonKey(name:'numOfNotifications')
int? numOfNotifications;
CustomerResponse(this.id,this.name,this.numOfNotifications);
//from json
factory CustomerResponse.fromJson(Map<String,dynamic> json)=>_$CustomerResponseFromJson(json);
//to json
Map<String,dynamic> toJson()=>_$CustomerResponseToJson(this);
}

@JsonSerializable()
class ContactsResponse{
  @JsonKey(name:'phone')
  String? phone;
  @JsonKey()
  String? email;
  @JsonKey()
  String? link;
  ContactsResponse(this.phone,this.email,this.link);
  //from json
  factory ContactsResponse.fromJson(Map<String,dynamic> json)=>_$ContactsResponseFromJson(json);
  //to json
  Map<String,dynamic> toJson()=>_$ContactsResponseToJson(this);
}

@JsonSerializable()
class AuthenticationResponse extends BaseResponse{
  @JsonKey(name:'customer')
  CustomerResponse? customer;
  @JsonKey(name:'contacts')
  ContactsResponse? contacts;
  AuthenticationResponse(this.customer,this.contacts);

//from json
factory AuthenticationResponse.fromJson(Map<String,dynamic> json)=>_$AuthenticationResponseFromJson(json);
//to json
Map<String,dynamic> toJson()=>_$AuthenticationResponseToJson(this);

}

//forgot password
@JsonSerializable()
class ForgotPasswordResponse extends BaseResponse{
@JsonKey(name:'support')
String? support;
ForgotPasswordResponse(this.support);
//from json
factory ForgotPasswordResponse.fromJson(Map<String,dynamic> json)=>_$ForgotPasswordResponseFromJson(json);
Map<String,dynamic> toJson()=>_$ForgotPasswordResponseToJson(this);
}

//main
@JsonSerializable()
class ServicesResponse{
  @JsonKey(name:'id')
  int? id;
  @JsonKey(name:'title')
  String? title;
  @JsonKey(name:'image')
  String? image;
  ServicesResponse(this.id,this.title,this.image);
  factory ServicesResponse.fromJson(Map<String,dynamic> json)=>_$ServicesResponseFromJson(json);
  Map<String,dynamic> toJson()=>_$ServicesResponseToJson(this);
}
@JsonSerializable()
class BannersResponse{
  @JsonKey(name:'id')
  int? id;
  @JsonKey(name:'title')
  String? title;
  @JsonKey(name:'image')
  String? image;
  @JsonKey(name:'link')
  String? link;
  BannersResponse(this.id,this.title,this.image,this.link);
  factory BannersResponse.fromJson(Map<String,dynamic> json)=>_$BannersResponseFromJson(json);
  Map<String,dynamic> toJson()=>_$BannersResponseToJson(this);
}
@JsonSerializable()
class StoresResponse{
  @JsonKey(name:'id')
  int? id;
  @JsonKey(name:'title')
  String? title;
  @JsonKey(name:'image')
  String? image;
  StoresResponse(this.id,this.title,this.image);
  factory StoresResponse.fromJson(Map<String,dynamic> json)=>_$StoresResponseFromJson(json);
  Map<String,dynamic> toJson()=>_$StoresResponseToJson(this);
}
@JsonSerializable()
class HomeDataResponse{
  @JsonKey(name:'services')
  List<ServicesResponse>? services;

  @JsonKey(name:'banners')
  List<BannersResponse>? banners;

  @JsonKey(name:'stores')
  List<StoresResponse>? stores;
  
  HomeDataResponse(this.services,this.banners,this.stores);
  factory HomeDataResponse.fromJson(Map<String,dynamic> json)=>_$HomeDataResponseFromJson(json);
  Map<String,dynamic> toJson()=>_$HomeDataResponseToJson(this);
}

@JsonSerializable()
class HomeResponse extends BaseResponse{
  @JsonKey(name:'data')
  HomeDataResponse? data;
  HomeResponse(this.data);

  factory HomeResponse.fromJson(Map<String,dynamic> json)=>_$HomeResponseFromJson(json);
  Map<String,dynamic> toJson()=>_$HomeResponseToJson(this);
}