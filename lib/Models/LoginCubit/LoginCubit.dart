
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Remote/DioHelper.dart';
import '../LoginModel.dart';
import 'LoginStates.dart';
class LoginCubit extends Cubit<LoginState>
{
  LoginCubit(): super(LoginInitialState());
  static LoginCubit get(context)=> BlocProvider.of(context);
  loginModel ?loginmodel;
  void userLogin(
      @required String email,
      @required String password,

      )
  {
    emit(LoginLoadingState());
    DioHelper.PostData(
      url: '/user/login/',
      data:{
        'email':email,
        'password':password,
      },

    ).then((value){
      print(value.data);
      loginmodel= loginModel.fromJson(value.data);

      emit(LoginSuccessState(loginmodel  !));
    }).catchError((error)
    {
      emit(LoginErrorState(error.toString()));
    });
    IconData suffix=Icons.visibility_outlined;
    bool isPass=true;
    void ChangePasswordVisibility(){
      isPass=!isPass;
      suffix=isPass?Icons.visibility_outlined:Icons.visibility_off;
      emit(PassVisibilityState());
    }
  }
}
