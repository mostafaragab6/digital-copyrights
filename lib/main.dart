import 'package:digital_copy_rights/Modules/Login/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Models/AppCubit/AppCubit.dart';
import '../../Models/AppCubit/AppStates.dart';
import 'Const/Components.dart';
import 'LayOut/LayOut_Screen.dart';
import 'Remote/CacheHelper.dart';
import 'Remote/DioHelper.dart';




void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();

  await cachHelper.init();

  token = cachHelper.getData(key: 'token');
  runApp(MyApp());


}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..GetPostsAllData()..GetProfileData()..GetNotification()..GetUserPostsData(),
      child: BlocConsumer<AppCubit,AppStates>(
        builder: (BuildContext context, AppStates state) {
          return MaterialApp(

              theme: ThemeData(
                //fontFamily: 'newFont',
                  iconTheme: IconThemeData(
                      color: Colors.black
                  ),
                  cardTheme: CardTheme(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                      color: Colors.grey[200]
                  ),


                  primarySwatch: Colors.teal,
                  floatingActionButtonTheme: FloatingActionButtonThemeData(
                      backgroundColor: Colors.teal[700]
                  ),
                  scaffoldBackgroundColor: Colors.white,
                  appBarTheme: AppBarTheme(

                    iconTheme: IconThemeData(
                        color: Colors.white
                    ),
                    elevation: 0.0,
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.black,
                        statusBarIconBrightness: Brightness.light
                    ),
                    backgroundColor: Colors.black,
                    titleTextStyle: TextStyle(color: Colors.white ,fontSize: 35.0),
                    //titleSpacing: 25.0
                  ),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                      type: BottomNavigationBarType.fixed,
                      selectedItemColor: Colors.white,
                      unselectedItemColor: Colors.grey[700],
                      backgroundColor: Colors.black
                  )
              ),
              themeMode: ThemeMode.light,
              debugShowCheckedModeBanner: false,
              home:token!.isNotEmpty ? SocialAppLayout() : Login()
          );
        },
        listener: (BuildContext context, AppStates state) {  },

      ),
    );
  }
}