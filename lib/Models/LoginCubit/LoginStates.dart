

import '../LoginModel.dart';

abstract class LoginState{}
class LoginInitialState extends LoginState{}
class LoginLoadingState extends LoginState{}
class LoginSuccessState extends LoginState{
  final loginModel loginmodel;

  LoginSuccessState(this.loginmodel);
}
class LoginErrorState extends LoginState{
  final String error;
  LoginErrorState(this.error);
}
class PassVisibilityState extends LoginState{}
