import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../const/components.dart';
import '../../Models/AppCubit/AppCubit.dart';
import '../../Models/AppCubit/AppStates.dart';
import 'PhotoScreen.dart';

class NotifyScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      builder: (BuildContext context, AppStates state) {
        var cubit= AppCubit.ACubit(context);
        return Stack(
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
            Padding(
              padding: const EdgeInsetsDirectional.only(top: 10.0,start: 10.0,end: 10.0 ),
              child: Row(
                children: [

                  Text('Good Morning, Mostafa',
                    style: TextStyle(
                        decoration:TextDecoration.none,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[300]
                    ),),
                  Spacer(),
                  //CircleAvatar(radius: 22.0, backgroundImage: AssetImage('images/desktop-wallpaper-aesthetic-green-green.jpg'),),

                ],
              ),
            ),


            ConditionalBuilder(
              condition: cubit.notificationData != null,
              builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsetsDirectional.only(top:70.0),
                  child: ListView.separated(

                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context , index)=>


                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              width: double.infinity,

                              child: InkWell(
                                onTap:(){
                                  navigatTo(context, PhotoScreen(id: cubit.notificationData!.nData[index].post!,notificationData: cubit.notificationData!.nData[index],));
                                },
                                child: Row(
                                  children: [

                                    Icon(Icons.warning_amber_rounded,color: Colors.red,size: 35,),
                                    SizedBox(width: 10,),
                                    Expanded(
                                      child: Text(
                                        'Someone Shared a photo of yours tap to see detailes',
                                        style:TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.grey
                                        ) ,maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ),



                      separatorBuilder: (context , index)=> Padding(
                        padding: const EdgeInsetsDirectional.symmetric(horizontal: 20.0),
                        child: Container(
                          width: double.infinity,
                          height: 1.0,
                          color: Colors.grey[800],
                        ),
                      ),
                      itemCount: cubit.notificationData!.nData.length),
                );
              },
              fallback: (BuildContext context) {
                return SizedBox();
              },

            ),
          ],
        );
      },
      listener: (BuildContext context, AppStates state) {  },

    );
  }
}
