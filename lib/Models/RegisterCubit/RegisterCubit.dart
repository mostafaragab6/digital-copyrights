import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:image_picker/image_picker.dart';

import '../../Remote/DioHelper.dart';
import 'RegisterStates.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);


  File? image;
  final ImagePicker picker = ImagePicker();

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image = File(pickedFile.path);

    } else {
      print('No image selected.');
    }
  }

  Future<void> userRegister({
    required String email,
    required String password,
    required String firstname,
    required String lastname,
    required String username,
    required String imagePath
  }) async {
    emit(RegisterLoadingState());
    File imageFile = File(imagePath);
    String fileName = imageFile.path.split('/').last;
    FormData formData = FormData.fromMap({
      'email': email,
      'password': password,
      'first_name': firstname,
      'last_name': lastname,
      'username': username,
      'bio': 'ssss',
      'image_url': await MultipartFile.fromFile(imagePath, filename: fileName),
    });

    DioHelper.userCreate(
      url: '/user/create/',
      data: formData,
    ).then((value) {
      print(value.data);
      emit(RegisterSuccessState());
    }).catchError((error) {
      emit(RegisterErrorState(error.toString()));
    });
  }
}