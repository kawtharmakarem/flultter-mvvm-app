import 'dart:async';

import 'package:flutter_application_test/domain/usecase/login_usecase.dart';
import 'package:flutter_application_test/presentation/base/baseviewmodel.dart';
import 'package:flutter_application_test/presentation/common/freezed_data_classes.dart';

class LoginViewModel extends BaseViewModel implements LoginViewModelInputs,LoginViewModelOutputs{
  
  final StreamController _userNameStreamController=StreamController<String>.broadcast();
  final StreamController _passwordStreamController=StreamController<String>.broadcast();
  final StreamController _areAllInputsValidStreamController=StreamController<void>.broadcast();
  var loginObject=LoginObject("", "");
 final LoginUseCase _loginUseCase;
  LoginViewModel(this._loginUseCase);


  @override
  void dispose() {
    _userNameStreamController.close();
    _passwordStreamController.close();
    _areAllInputsValidStreamController.close();
  }

  @override
  void start() {}
  
@override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject=loginObject.copyWith(password: password);
    inputAreAllInputsValid.add(null);
  }
  
  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    loginObject=loginObject.copyWith(userName: userName);
    inputAreAllInputsValid.add(null);
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
  Sink get inputAreAllInputsValid => _areAllInputsValidStreamController.sink;
  
  @override
  Stream<bool> get outIsPasswordValid => _passwordStreamController.stream.map((passwod) => _isPasswordValid(passwod));
  
  @override
  Stream<bool> get outIsUserNameValid => _userNameStreamController.stream.map((userName) => _isUserNameValid(userName));
   

  @override
  Stream<bool> get outAreAllInputsValid =>_areAllInputsValidStreamController.stream.map((_) => _areAllInputsValid());
  
//functions
bool _isPasswordValid(String password){
  return password.isNotEmpty;
}  
bool _isUserNameValid(String userName){
  return userName.isNotEmpty;
}
bool _areAllInputsValid(){
  return _isPasswordValid(loginObject.password) && _isUserNameValid(loginObject.userName);
}

 

}




abstract class LoginViewModelInputs{
setUserName(String userName);
setPassword(String password);
login();
Sink get inputUserName;
Sink get inputPassword;
Sink get inputAreAllInputsValid;

}
abstract class LoginViewModelOutputs{
Stream<bool> get outIsUserNameValid;
Stream<bool> get outIsPasswordValid;
Stream<bool> get outAreAllInputsValid;
}