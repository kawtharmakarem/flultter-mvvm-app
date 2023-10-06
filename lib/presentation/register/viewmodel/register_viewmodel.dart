import 'dart:async';
import 'dart:io';

import 'package:flutter_application_test/app/functions.dart';
import 'package:flutter_application_test/domain/usecase/register_usecase.dart';
import 'package:flutter_application_test/presentation/base/baseviewmodel.dart';
import 'package:flutter_application_test/presentation/common/freezed_data_classes.dart';
import 'package:flutter_application_test/presentation/common/state_renderer/state_renderer.dart';
import 'package:flutter_application_test/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:flutter_application_test/presentation/resources/strings_manager.dart';

class RegisterViewModel extends BaseViewModel implements RegisterViewModelInput,RegisterViewModelOutput{
StreamController userNameStreamController=StreamController<String>.broadcast();
StreamController mobileNumberStreamController=StreamController<String>.broadcast();
StreamController emailStreamController=StreamController<String>.broadcast();
StreamController passwordStreamController=StreamController<String>.broadcast();
StreamController profilePictureStreamController=StreamController<File>.broadcast();
StreamController areAllInputsValidStreamController=StreamController<void>.broadcast();
StreamController isUserRegisteredInSuccessfullyStreamController=StreamController<bool>.broadcast();

final RegisterUseCase _registerUseCase;
RegisterViewModel(this._registerUseCase);
var registerObject=RegisterObject("","", "","","", "");

  @override
  Sink get inputAllInputsValid => areAllInputsValidStreamController.sink;

  @override
  Sink get inputEmail => emailStreamController.sink;

  @override
  Sink get inputMobileNumber => mobileNumberStreamController.sink;

  @override
  Sink get inputPassword => passwordStreamController.sink;

  @override
  Sink get inputProfilePicture => profilePictureStreamController.sink;

  @override
  Sink get inputUserName => userNameStreamController.sink;

  @override
  Stream<bool> get outputAreAllInputsValid => areAllInputsValidStreamController.stream.map((_) => _areAllInputsValid());
@override
  Stream<File> get outputProfilePicture => profilePictureStreamController.stream.map((file) => file);

   @override
  Stream<bool> get outputIsPasswordValid => passwordStreamController.stream.map((password) => _isPasswordValid(password));
  @override
  Stream<String?> get outputErrorPassword => outputIsPasswordValid.map((isPasswordValid) => isPasswordValid? null:AppStrings.passwordInvalid);



  @override
  Stream<bool> get outputIsUserNameValid => userNameStreamController.stream.map((userName) => _isUserNameValid(userName));
  @override
  Stream<String?> get outputErrorUserName => outputIsUserNameValid.map((isUserName) => isUserName ? null :AppStrings.userNameInvalid);
 

  @override
  Stream<bool> get outputIsEmailValid => emailStreamController.stream.map((email) => isEmailValid(email));
   @override
  Stream<String?> get outputErrorEmail => outputIsEmailValid.map((isEmailValid) => isEmailValid? null :AppStrings.invalidEmail);

  
@override
  Stream<bool> get outputIsMobileNumberValid => mobileNumberStreamController.stream.map((mobileNumber) => _isMobileNumberValid(mobileNumber));
  @override
  Stream<String?> get outputErrorMobileNumber => outputIsMobileNumberValid.map((isMobileNumberValid) => isMobileNumberValid? null :AppStrings.mobileNumberInvalid);
  


  @override
  register() async {
    inputState.add(LoadingState(stateRendererType: StateRendererType.popupLoadingtate));
    (await _registerUseCase.execute(RegisterUseCaseInput(
      userName: registerObject.userName,
       countryMobileCode: registerObject.mobileCountryCode,
        mobileNumber: registerObject.mobileNumber,
         email: registerObject.email,
          password: registerObject.password,
           profilePicture: registerObject.profilePicture)))
           .fold((failure) => {
               inputState.add(ErrorState(stateRendererType:StateRendererType.popupErrorState, message: failure.message))
           }, (data) => {
              inputState.add(ContentState()),
              //navigate to main screen
              isUserRegisteredInSuccessfullyStreamController.add(true)
           });
  }

  @override
  setCountryCode(String countryCode) {
    if(countryCode.isNotEmpty){
      registerObject=registerObject.copyWith(mobileCountryCode: countryCode);
    }else{
      registerObject=registerObject.copyWith(mobileCountryCode: "");
    }
    validate();
  }

  @override
  setEmail(String email) {
   inputEmail.add(email);
   if(isEmailValid(email))
   {
    registerObject=registerObject.copyWith(email:email);
   }else{
    registerObject=registerObject.copyWith(email:"");
   }
   validate();
  }

  @override
  setMobileNumber(String mobileNumber) {
    inputMobileNumber.add(mobileNumber);
    if(_isMobileNumberValid(mobileNumber))
    {
      registerObject=registerObject.copyWith(mobileNumber: mobileNumber);
    }else{
      registerObject=registerObject.copyWith(mobileNumber: "");
    }
    validate();
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    if(_isPasswordValid(password)){
      registerObject=registerObject.copyWith(password: password);
    }else{
      registerObject=registerObject.copyWith(password: "");
    }
    validate();
  }

  @override
  setProfilePicture(File profilePicture) {
    inputProfilePicture.add(profilePicture);
    if(profilePicture.path.isNotEmpty)
    {
      registerObject=registerObject.copyWith(profilePicture: profilePicture.path);
    }else{
      registerObject=registerObject.copyWith(profilePicture: "");
    }
    validate();
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    if(_isUserNameValid(userName))
    {
      registerObject=registerObject.copyWith(userName: userName);
    }else{
      registerObject=registerObject.copyWith(userName: "");
    }
    validate();
  }
  @override
  void dispose() {
    userNameStreamController.close();
    mobileNumberStreamController.close();
    emailStreamController.close();
    passwordStreamController.close();
    profilePictureStreamController.close();
    areAllInputsValidStreamController.close();
    isUserRegisteredInSuccessfullyStreamController.close();
    super.dispose();
  }

  @override
  void start() {
    inputState.add(ContentState());
  }

  //functions
  bool _isUserNameValid(String userName){
    return userName.length>=8;
  }
  bool _isPasswordValid(String password)
  {
    return password.length>=6;
  }
  bool _isMobileNumberValid(String mobileNumber)
  {
    return mobileNumber.length>=10;
  }
  bool _areAllInputsValid()
  {
    return registerObject.mobileCountryCode.isNotEmpty &&
    registerObject.mobileNumber.isNotEmpty &&
    registerObject.userName.isNotEmpty &&
    registerObject.email.isNotEmpty &&
    registerObject.password.isNotEmpty &&
    registerObject.profilePicture.isNotEmpty;
  }
  validate(){
    inputAllInputsValid.add(null);
  }

}
abstract class RegisterViewModelInput{
  Sink get inputUserName;
  Sink get inputMobileNumber;
  Sink get inputEmail;
  Sink get inputPassword;
  Sink get inputProfilePicture;
  Sink get inputAllInputsValid;
  register();
  setUserName(String userName);
  setMobileNumber(String mobileNumber);
  setCountryCode(String countryCode);
  setEmail(String email);
  setPassword(String password);
  setProfilePicture(File profilePicture);
}
abstract class RegisterViewModelOutput{
  Stream<bool> get outputIsUserNameValid;
  Stream<String?> get outputErrorUserName;
  Stream<bool> get outputIsMobileNumberValid;
  Stream<String?> get outputErrorMobileNumber;
  Stream<bool> get outputIsEmailValid;
  Stream<String?> get outputErrorEmail;
  Stream<bool> get outputIsPasswordValid;
  Stream<String?> get outputErrorPassword;
  Stream<File> get outputProfilePicture;
  Stream<bool> get outputAreAllInputsValid; 

}