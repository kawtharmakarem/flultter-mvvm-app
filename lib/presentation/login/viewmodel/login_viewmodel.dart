import 'dart:async';

import 'package:flutter_application_test/domain/usecase/login_usecase.dart';
import 'package:flutter_application_test/presentation/base/baseviewmodel.dart';
import 'package:flutter_application_test/presentation/common/freezed_data_classes.dart';

class LoginViewModel extends BaseViewModel implements LoginViewModelInputs,LoginViewModelOutputs{
  
  final StreamController _userNameStreamController=StreamController<String>.broadcast();
  final StreamController _passwordStreamController=StreamController<String>.broadcast();
  var loginObject=LoginObject("", "");
  final LoginUseCase _loginUseCase;
  LoginViewModel(this._loginUseCase);

  @override
  void dispose() {
    _userNameStreamController.close();
    _passwordStreamController.close();
  }

  @override
  void start() {}
  
@override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject=loginObject.copyWith(password: password);
  }
  
  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    loginObject=loginObject.copyWith(userName: userName);
  }
  @override
  login() async{
   (await _loginUseCase.execute(LoginInputUseCaseInput(loginObject.userName, loginObject.password)))
   .fold((failure) => {
    print(failure.message)
   },
    (data) => {
    print(data.customer?.name)
   });
  }

  @override
  Sink get inputPassword => _passwordStreamController.sink;
  
  @override
  Sink get inputUserName => _userNameStreamController.sink;
  
  
  
  @override
  Stream<bool> get outIsPasswordValid => _passwordStreamController.stream.map((passwod) => _isPasswordValid(passwod));
  
  @override
  Stream<bool> get outIsUserNameValid => _userNameStreamController.stream.map((userName) => _isUserNameValid(userName));
  
//functions
bool _isPasswordValid(String password){
  return password.isNotEmpty;
}  
bool _isUserNameValid(String userName){
  return userName.isNotEmpty;
}

}




abstract class LoginViewModelInputs{
setUserName(String userName);
setPassword(String password);
login();
Sink get inputUserName;
Sink get inputPassword;

}
abstract class LoginViewModelOutputs{
Stream<bool> get outIsUserNameValid;
Stream<bool> get outIsPasswordValid;
}