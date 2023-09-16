import 'package:flutter/material.dart';
import 'package:flutter_application_test/presentation/resources/color_manager.dart';
import 'package:flutter_application_test/presentation/resources/font_manager.dart';
import 'package:flutter_application_test/presentation/resources/styles_manager.dart';
import 'package:flutter_application_test/presentation/resources/values_manager.dart';

ThemeData getApplicationTheme(){
  return ThemeData(
    //main colors
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.lighPrimary,
    primaryColorDark: ColorManager.darkPrimary,
    disabledColor: ColorManager.grey1,

    //cardview theme
    cardTheme: CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.grey,
      elevation: AppSize.s4
    ),

    //appbar theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManager.primary,
      elevation: AppSize.s4,
      shadowColor: ColorManager.lighPrimary,
      titleTextStyle: getRegularStyle(fontSize: FontSize.s16,color: ColorManager.white)
    ),

    // button theme
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorManager.grey1,
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.lighPrimary

    ),
    //elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularStyle(color: ColorManager.white,fontSize: FontSize.s17),
        backgroundColor:ColorManager.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s12)
        ),
      ),
    ),

    //text theme
    textTheme: TextTheme(
      displayLarge: getSemiBoldStyle(color: ColorManager.darkGrey,fontSize: FontSize.s16),//for onboarding title
      headlineLarge: getSemiBoldStyle(color: ColorManager.darkGrey,fontSize: FontSize.s16),
      titleMedium: getMediumStyle(color: ColorManager.primary,fontSize: FontSize.s16),//for skip button
      bodyLarge: getRegularStyle(color: ColorManager.grey1),
      bodySmall: getRegularStyle(color: ColorManager.grey),
      headlineMedium: getRegularStyle(color: ColorManager.darkGrey,fontSize: FontSize.s14),//for onboarding subtitle
     
    ),
    
    //input decoration theme(for text form field)
     inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      hintStyle: getRegularStyle(color: ColorManager.grey,fontSize: FontSize.s14),
      labelStyle: getMediumStyle(color: ColorManager.grey,fontSize: FontSize.s14),
      errorStyle: getRegularStyle(color: ColorManager.error),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
        color: ColorManager.grey,width: AppSize.s1_5
        ),
        borderRadius:const BorderRadius.all(Radius.circular(AppSize.s8),
        ),
        
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.primary,width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.error,width: AppSize.s1_5),
        borderRadius:const BorderRadius.all(Radius.circular(AppSize.s8))
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.primary,width: AppSize.s1_5),
        borderRadius:const BorderRadius.all(Radius.circular(AppSize.s8))
      )
     ),
     
  );
}