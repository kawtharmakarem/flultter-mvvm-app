import 'dart:async';

import 'package:flutter_application_test/domain/models/models.dart';
import 'package:flutter_application_test/presentation/base/baseviewmodel.dart';

import '../../resources/assets_manager.dart';
import '../../resources/strings_manager.dart';

class OnBoardingViewModel extends BaseViewModel
    implements OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
 final StreamController _streamController=StreamController<SliderViewObject>();
   late final List<SliderObject> _list;
     int _currentIndex=0;



  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _list=_getSliderData();
    _postDatatoview();
  }
  
  @override
  int goNext() {
    int nextIndex=++_currentIndex;
    if(nextIndex==_list.length){
      nextIndex=0;
    }
    return nextIndex;
  }

  
  
  @override
  int goPrevious() {
    int previousIndex=--_currentIndex;
    if(previousIndex==-1){
previousIndex=_list.length-1;
    }
    return previousIndex;

  }
  

  
  @override
  void onPageChanged(index) {
    _currentIndex=index;
    _postDatatoview();
  }

    @override
  Sink get inputSliderViewObject => _streamController.sink;

  @override
        Stream<SliderViewObject> get outputSliderViewObject => _streamController.stream.map((sliderViewObject) => sliderViewObject);
  
 

  //functions
  void _postDatatoview(){
    inputSliderViewObject.add(SliderViewObject(sliderObject: _list[_currentIndex], numOfSlides: _list.length, currentIndex: _currentIndex));
  }
  List<SliderObject> _getSliderData() => [
        SliderObject(AppStrings.onBoardingTitle1,
            AppStrings.onBoardingSubTitle1, ImageAssets.onboardingLogo1),
        SliderObject(AppStrings.onBoardingTitle2,
            AppStrings.onBoardingSubTitle2, ImageAssets.onboardingLogo2),
        SliderObject(AppStrings.onBoardingTitle3,
            AppStrings.onBoardingSubTitle3, ImageAssets.onboardingLogo3),
        SliderObject(AppStrings.onBoardingTitle4,
            AppStrings.onBoardingSubTitle4, ImageAssets.onboardingLogo1),
      ];
      
        
}

abstract class OnBoardingViewModelInputs {
  int goNext();
  int goPrevious();
  void onPageChanged(index);
  Sink get inputSliderViewObject;
}

abstract class OnBoardingViewModelOutputs {
  Stream<SliderViewObject> get outputSliderViewObject;
}
