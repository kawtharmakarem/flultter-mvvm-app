// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_application_test/presentation/resources/assets_manager.dart';
import 'package:flutter_application_test/presentation/resources/color_manager.dart';
import 'package:flutter_application_test/presentation/resources/font_manager.dart';
import 'package:flutter_application_test/presentation/resources/styles_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_application_test/presentation/resources/values_manager.dart';

import '../../resources/strings_manager.dart';

enum StateRendererType {
  //dialog state
  popupLoadingtate,
  popupErrorState,
  //full screen state
  fullScreenLoadingState,
  fullScreenErrorState,
  fullScreenEmptyState,
  //general state
  contentState
}

class StateRenderer extends StatelessWidget {
  StateRendererType stateRendererType;
  String message;
  String title;
  Function retryActionfunction;
  StateRenderer(
      {required this.stateRendererType,
      this.message = AppStrings.loading,
      this.title = "",
      required this.retryActionfunction});

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  Widget _getStateWidget(BuildContext context) {
    switch (stateRendererType) {
      case StateRendererType.popupLoadingtate:
        return _getPopUpDialog(
            context, [_getAnimatedImage(JsonAssets.loading)]);

      case StateRendererType.popupErrorState:
        return _getPopUpDialog(context,
            [_getAnimatedImage(JsonAssets.error), _getMessage(message),_getRetryButton(AppStrings.ok, context)]);
      case StateRendererType.fullScreenLoadingState:
        return _getItemsColumn(
            [_getAnimatedImage(JsonAssets.loading), _getMessage(message)]);
      case StateRendererType.fullScreenErrorState:
        return _getItemsColumn([_getAnimatedImage(JsonAssets.error),_getMessage(message),_getRetryButton(AppStrings.retryAgain, context)]);
      case StateRendererType.fullScreenEmptyState:
      return _getItemsColumn([_getAnimatedImage(JsonAssets.empty),_getMessage(message)]);
      case StateRendererType.contentState:
      return Container();
      default:
      return Container();
    }
  }

  Widget _getPopUpDialog(BuildContext context, List<Widget> children) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s14)),
      elevation: AppSize.s1_5,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(AppSize.s14),
          boxShadow: const [BoxShadow(color: Colors.black26)],
        ),
        child: _getDialogContent(context, children),
      ),
    );
  }

  Widget _getDialogContent(BuildContext context, List<Widget> children) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _getItemsColumn(List<Widget> children) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }

  Widget _getAnimatedImage(String animationName) {
    return SizedBox(
      height: AppSize.s100,
      width: AppSize.s100,
      child: Lottie.asset(animationName),
    );
  }

  Widget _getMessage(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Text(
          message,
          style: getRegularStyle(
              color: ColorManager.black, fontSize: FontSize.s18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _getRetryButton(String buttonTitle,BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(onPressed: () {
            if(stateRendererType==StateRendererType.fullScreenErrorState){
              retryActionfunction.call();
            }else{
              Navigator.of(context).pop();
            }
          },
           child: Text(buttonTitle)),
        ),
      ),
    );
  }
}
