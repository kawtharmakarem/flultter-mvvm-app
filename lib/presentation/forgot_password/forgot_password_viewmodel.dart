import 'dart:async';

import 'package:flutter_application_test/app/functions.dart';
import 'package:flutter_application_test/domain/usecase/forgotpassword_usecase.dart';
import 'package:flutter_application_test/presentation/base/baseviewmodel.dart';
import 'package:flutter_application_test/presentation/common/state_renderer/state_renderer.dart';
import 'package:flutter_application_test/presentation/common/state_renderer/state_renderer_impl.dart';
class ForgotPasswordViewModel extends BaseViewModel implements ForgotPasswordViewModelInput,ForgotPasswordViewModelOutput{
  
  final StreamController _emailStreamController=StreamController<String>.broadcast();
 final StreamController _isAllInputValidStreamController=StreamController<void>.broadcast();

final ForgotPasswordUseCase _forgotPasswordUseCase;
ForgotPasswordViewModel(this._forgotPasswordUseCase);
var email="";

@override
  void dispose() {
    _emailStreamController.close();
    _isAllInputValidStreamController.close();
  }
  
  @override
  forgotPassword() async{
   inputState.add(LoadingState(stateRendererType: StateRendererType.popupLoadingtate));
   (await _forgotPasswordUseCase.execute(email)).fold((failure){
    inputState.add(ErrorState(stateRendererType:StateRendererType.fullScreenErrorState, message: failure.message));
   }, (supportMessage){
    inputState.add(SuccessState(supportMessage));
   });
  }

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputIsAllInputValid => _isAllInputValidStreamController.sink;

  @override
  Stream<bool> get outputIsAllInputValid => _isAllInputValidStreamController.stream.map((isAllInputValid) => _isAllInputValid());


  @override
  Stream<bool> get outputIsEmailValid => _emailStreamController.stream.map((email) => isEmailValid(email));

  @override
  setEmail(String email) {
   inputEmail.add(email);
   this.email=email;
   _validate();
  }

  @override
  void start() {
    inputState.add(ContentState());
  }

  //functions
  _isAllInputValid(){
    return isEmailValid(email);
  }
  _validate(){
    inputIsAllInputValid.add(null);
  }

}
abstract class ForgotPasswordViewModelInput{
  forgotPassword();
  setEmail(String email);
  Sink get inputEmail;
  Sink get inputIsAllInputValid;
}

abstract class ForgotPasswordViewModelOutput{
  Stream<bool> get outputIsEmailValid;
  Stream<bool> get outputIsAllInputValid;
}

