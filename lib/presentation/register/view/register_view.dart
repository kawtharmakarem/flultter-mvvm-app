import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_application_test/app/app_prefs.dart';
import 'package:flutter_application_test/app/di.dart';
import 'package:flutter_application_test/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:flutter_application_test/presentation/register/viewmodel/register_viewmodel.dart';
import 'package:flutter_application_test/presentation/resources/color_manager.dart';
import 'package:flutter_application_test/presentation/resources/routes_manager.dart';
import 'package:flutter_application_test/presentation/resources/values_manager.dart';
import 'package:image_picker/image_picker.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
final RegisterViewModel _viewModel=instance<RegisterViewModel>();
final ImagePicker _imagePicker=instance<ImagePicker>();
final AppPreferences _appPreferences=instance<AppPreferences>();
final _formKey=GlobalKey<FormState>();

final TextEditingController _userNameEditingController=TextEditingController();
final TextEditingController _emailEditingController=TextEditingController();
final TextEditingController _passwordEditingController=TextEditingController();
final TextEditingController _mobileNumberEditingController=TextEditingController();

_bind(){
  _viewModel.start();
  _userNameEditingController.addListener(() {
    _viewModel.setUserName(_userNameEditingController.text);
   });
   _emailEditingController.addListener(() { 
    _viewModel.setEmail(_emailEditingController.text);
   });
   _passwordEditingController.addListener(() { 
    _viewModel.setPassword(_passwordEditingController.text);
   });
   _mobileNumberEditingController.addListener(() { 
    _viewModel.setMobileNumber(_mobileNumberEditingController.text);
   });
   _viewModel.isUserRegisteredInSuccessfullyStreamController.stream.listen((isLoggedIn) {
    //navigate to main screen
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _appPreferences.setUserLoggedIn();
      Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
     });
    });
}

@override
  void initState() {
    _bind();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        elevation: AppSize.s0,
        backgroundColor: ColorManager.white,
        iconTheme: IconThemeData(color: ColorManager.primary),
      ),
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
         builder: (context,snapshot){
          return snapshot.data?.getScreenWidget(context, _getContentWidget(),
          (){
            _viewModel.register();
          } ) ?? _getContentWidget();
         }
         ),
    );
  }
  
  Widget _getContentWidget() {
    return Container(
      
    );

  }
}