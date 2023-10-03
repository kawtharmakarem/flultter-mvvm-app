// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_application_test/app/constants.dart';
import 'package:flutter_application_test/presentation/common/state_renderer/state_renderer.dart';
import 'package:flutter_application_test/presentation/resources/strings_manager.dart';

abstract class FlowState{
  StateRendererType getStateRendererType();
  String getMessage();
}

//loading state (popup,fullscreen)
class LoadingState extends FlowState{
StateRendererType stateRendererType;
String? message;

LoadingState({required this.stateRendererType,this.message=AppStrings.loading});

  @override
  String getMessage() =>message ?? AppStrings.loading;

  @override
  StateRendererType getStateRendererType()=>stateRendererType;

}
//error state
class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;
  ErrorState({
    required this.stateRendererType,
    required this.message,
  });
  

  @override
  String getMessage() =>message;

  @override
  StateRendererType getStateRendererType() =>stateRendererType;
}

//content state
class ContentState extends FlowState{
  ContentState();
  @override
  String getMessage()=>Constants.empty;

  @override
  StateRendererType getStateRendererType()=>StateRendererType.contentState;

}
//success state
class SuccessState extends FlowState{
  String message;
  SuccessState(this.message);
  
  @override
  String getMessage() =>message;
  
  @override
  StateRendererType getStateRendererType()=>StateRendererType.popupSuccess;
}

//Empty state
class EmptyState extends FlowState {
  String message;
  EmptyState({
    required this.message,
  });
  
  @override
  String getMessage() =>message;
  
  @override
  StateRendererType getStateRendererType() =>StateRendererType.fullScreenEmptyState;

}

extension FlowStateExtension on FlowState{
  Widget getScreenWidget(BuildContext context,Widget contentScreenWidget,Function retryActionFunction){
    switch(runtimeType){
      case LoadingState:
      {
        if(getStateRendererType()==StateRendererType.popupLoadingtate){
            showPopup(context, getStateRendererType(), getMessage());
            return contentScreenWidget;
        }
        else
        {
         return StateRenderer(
          message: getMessage(),
          stateRendererType: getStateRendererType(),
           retryActionfunction: retryActionFunction);
        }
      }
      case ErrorState:
      {
        dismissDialog(context);
       if(getStateRendererType()==StateRendererType.popupErrorState){
         showPopup(context,
          getStateRendererType(), getMessage());
         return contentScreenWidget;
       }else{
        return StateRenderer(
          stateRendererType: getStateRendererType(),
          message: getMessage(),
           retryActionfunction:retryActionFunction);
       }
      }
      case ContentState:
      {
        dismissDialog(context);
        return contentScreenWidget;
      }
      case EmptyState:
      {
        return StateRenderer(
          stateRendererType: getStateRendererType(),
          message: getMessage(),
           retryActionfunction: (){});
      }
      
      default:
      {
        dismissDialog(context);
        return contentScreenWidget;
      }
    }
  }
  _isCurrentDialogShowing(BuildContext context)=>ModalRoute.of(context)?.isCurrent!=true;

dismissDialog(BuildContext context){
  if(_isCurrentDialogShowing(context)){
    Navigator.of(context,rootNavigator: true).pop(true);
  }
}

  showPopup(BuildContext context,StateRendererType stateRendererType,String message,{String title=Constants.empty}) {
WidgetsBinding.instance.addPostFrameCallback((_)=>showDialog(
  context: context,
   builder: (BuildContext context)=>StateRenderer(
    stateRendererType: stateRendererType, 
    message: message,
    retryActionfunction: (){})));
}
}

