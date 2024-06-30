import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Models/AppCubit/AppCubit.dart';
import '../../Models/AppCubit/AppStates.dart';



class Profile extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      builder: (BuildContext context, AppStates state) {
        var cubit=AppCubit.ACubit(context);
        return
          ConditionalBuilder(
            condition: cubit.profileData != null,
            builder: (BuildContext context) {
              return SafeArea(
                child: Stack(
                    alignment: Alignment.topLeft,
                    children: [
                      Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                transform:GradientRotation(44) ,
                                begin:Alignment.topRight ,
                                end: Alignment.bottomLeft,
                                colors: [
                                  MaterialColor(0xFF1B0810, {}),

                                  Colors.black,
                                  //Colors.black,

                                  MaterialColor(0xFF021222, {})
                                ])),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(top: 30.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 70.0,
                                child:cubit.profileData!.image_url != null ?
                                ClipOval(child: Image(image: AssetImage("${cubit.profileData!.image_url}"),width: 300.0,fit: BoxFit.cover,)):
                                ClipOval(child: Image(image: AssetImage("images/user.png"),width: 300.0,fit: BoxFit.cover,)),
                              ),
                              SizedBox(height: 30.0,),
                              Text('${cubit.profileData!.first_name} ${cubit.profileData!.last_name}',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white
                                  )),
                              Text('${cubit.profileData!.email}',style:
                              TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white
                              )),
                              SizedBox(height: 10.0,),
                            ],
                          ),
                        ),
                      )
                    ]
                ),
              );
            },
            fallback: (BuildContext context) {
              return Center(child: CircularProgressIndicator());
            },

          );




      },
      listener: (BuildContext context, AppStates state) {  },

    );
  }
}
