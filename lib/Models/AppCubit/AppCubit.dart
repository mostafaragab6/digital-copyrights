import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:digital_copy_rights/Models/AppCubit/AppStates.dart';
import 'package:digital_copy_rights/Models/NotifiedPostData.dart';
import 'package:digital_copy_rights/Models/NotificationModel.dart';
import 'package:digital_copy_rights/Modules/Screens/ProfileScreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../Const/Components.dart';
import '../../Modules/Screens/HomeScreen.dart';
import '../../Modules/Screens/NotifyScreen.dart';
import '../../Remote/DioHelper.dart';
import '../AllPostsModel.dart';
import '../FollowUserModel.dart';
import '../ProfileData.dart';


class AppCubit extends Cubit<AppStates>{

  AppCubit() :super (AppInitialState());


  static AppCubit ACubit(context) => BlocProvider.of(context);


  int Counter =0;

  List<int> list =[1] ;
  List<IconData> icons =[
    Icons.home,
    Icons.notifications,
    Icons.person
  ];

  List<String> Titles = [
    'Home',
    'Notifications',
    'Profile'
  ];

  List<Widget> Screens =[
    HomeScreen(),
    NotifyScreen(),
    Profile()
  ];

  PostsAllData? postsAllData;
  void GetPostsAllData(){

    emit(GetPostsAllDataLoading());

    DioHelper.GetData(
      url: "/posts/all/",
      token: 'Token $token',
    ).then((value) {
      postsAllData = PostsAllData.fromJson(value.data);

      flag = false ;
      print(postsAllData!.content[0].title);
      print(postsAllData!.content[0].image_url);
      emit(GetPostsAllDataSuccess());

    }).catchError((onError){
      print(onError.toString());

      emit(GetPostsAllDataError());
    });

  }

  PostsAllData? userPosts;
  void GetUserPostsData(){

    emit(GetUserPostsAllDataLoading());

    DioHelper.GetData(
      url: "/posts/",
      token: 'Token $token',
    ).then((value) {
      userPosts = PostsAllData.fromJson(value.data);

      print(userPosts!.content[0].title);
      print(userPosts!.content[0].image_url);
      emit(GetUserPostsAllDataSuccess());

    }).catchError((onError){
      print(onError.toString());

      emit(GetUserPostsAllDataError());
    });

  }

  ProfileData? profileData;
  void GetProfileData(){
    emit(GetProfileDataLoading());

    DioHelper.GetData(
        url: "/user/profile/",
        token: "Token $token").
    then((value){

      profileData = ProfileData.fromJson(value.data);
      print(profileData!.email);
      print('this is my image >>>>>>>> $profileData!.image_url');

      emit(GetProfileDataSuccess());
    }).
    catchError((onError){
          emit(GetProfileDataError());
    });
  }


  bool flag = false ;

  Future<void> SetPost({required String content ,required String imagePath} ) async {

    emit(SetPostLoading());

    File imageFile = File(imagePath);
    String fileName = imageFile.path.split('/').last;

    FormData formData = FormData.fromMap({
      'title': content,
      'description': 'Test',
      'image_url': await MultipartFile.fromFile(imagePath, filename: fileName),
    });


    DioHelper.PostCreate(
      url: "/post/create/",
      data:formData,
      token: 'Token $token',

    ).then((value) {

      flag = true;
      print('added successfully');
      GetPostsAllData();
      GetUserPostsData();
      emit(SetPostSuccess());

    }).catchError((onError){
      print(onError.toString());

      emit(SetPostError());
    });

  }


  FollowUserData? followUserData;
  void FollowUser({required int id }){
    emit(FollowUserLoading());

    DioHelper.PostData(
        url: "/user/follow/$id/",
        token: "Token $token"
    ).then((value) {

      followUserData = FollowUserData.fromJson(value.data);


      emit(FollowUserSuccess());

    }).catchError((onError){
      print(onError.toString());
      emit(FollowUserError());
    });

  }

  int notificationNumber = 0;
  NotificationData? notificationData;

  void GetNotification(){
    emit(GetNotificationLoading());

    DioHelper.GetData(
        url: "/notifications/",
        token: "Token $token"
    ).then((value){

      notificationData = NotificationData.fromJson(value.data);

      notificationNumber = notificationData!.nData.length;
      emit(GetNotificationSuccess());
    }
    ).catchError((error){
      print(error.toString());
      emit(GetNotificationError());
    });
  }


  void UpdatePost({ required int id , required String action}){

    emit(UpdatePostLoading());

    DioHelper.PutData(
        url: "/notifications/$id/",
        token: "Token $token",
        data: {
          'action_taken' : action
        }).then((value){
      emit(UpdatePostSuccess());
    }).catchError((error){

      print(error.toString());
      emit(UpdatePostError());
    });

  }


  NotifiedPostData? notifiedPostData;
  void GetNotifiedPostData({required int id}){
    emit(GetNotifiedPostDataLoading());

    DioHelper.GetData(
        url: "/post/$id/",
        token: "Token $token"
    ).then((value){

      notifiedPostData = NotifiedPostData.fromJson(value.data);

      emit(GetNotifiedPostDataSuccess());
    }).catchError((error){
      print(error.toString());
      emit(GetNotifiedPostDataError());
    });
  }




  int currentIndex = 0;
  void CahngeNavBar(int index){

    currentIndex = index;
    emit(ChangeNavBar());

  }








  void ChangeCounter(){
    Counter++;
    emit(ChangeCounterState());

  }


  File? image;
  final ImagePicker picker = ImagePicker();

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      emit(UploadedImageState());
    } else {
      print('No image selected.');
    }
  }
}

