import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Models/AppCubit/AppCubit.dart';
import '../../Models/AppCubit/AppStates.dart';
import 'HomeScreen.dart';



class Profile extends StatelessWidget {


  DateTime dateTime = DateTime.now();
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
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
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

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text('Posts',
                                      style: TextStyle(
                                        fontSize: 30.0,
                                        color: Colors.white
                                      ),),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.only(top:50.0),
                                  child: ConditionalBuilder(
                                    condition: cubit.userPosts != null,
                                    builder: (BuildContext context) {
                                      return Container(
                                        child: ListView.separated(
                                          physics: NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemBuilder: (context , index){

                                              String dateTimeString = cubit.userPosts!.content[index].created_at!;


                                              String year = dateTimeString.substring(0, 4);
                                              String month = dateTimeString.substring(5, 7);
                                              String day = dateTimeString.substring(8, 10);
                                              String hour = dateTimeString.substring(11, 13);
                                              String minute = dateTimeString.substring(14, 16);
                                              return Column(
                                                children: [
                                                  cubit.flag? Center(child: CircularProgressIndicator()):SizedBox(),
                                                  cubit.flag?SizedBox(height: 10.0,):SizedBox(),
                                                  CreateItem(
                                                      cubit: cubit,
                                                      postsAllContent: cubit.userPosts!.content[index],
                                                      dateTime: dateTime,
                                                      day: day,
                                                      hour: hour,
                                                      minute: minute,
                                                      month: month,
                                                      year: year
                                                  ),
                                                ],
                                              );
                                            },
                                            separatorBuilder: (context , index)=> Padding(
                                              padding: const EdgeInsetsDirectional.symmetric(horizontal: 20.0),
                                              child: Container(
                                                width: double.infinity,
                                                height: 1.0,
                                                color: Colors.grey[800],
                                              ),
                                            ),
                                            itemCount: cubit.userPosts!.content.length),
                                      );
                                    },
                                    fallback: (BuildContext context) {
                                      return Center(
                                        child: CircularProgressIndicator()
                                        ,);
                                    },

                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),


                      
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
