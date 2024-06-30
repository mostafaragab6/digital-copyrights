import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../Models/AppCubit/AppCubit.dart';
import '../../Models/AppCubit/AppStates.dart';
import '../../Models/NotificationModel.dart';


class PhotoScreen extends StatelessWidget {

  int id;
  NData notificationData;
  PhotoScreen({required this.id , required this.notificationData});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      builder: (BuildContext context, AppStates state) {
        var cubit = AppCubit.ACubit(context);
        
        cubit.GetNotifiedPostData(id: id);
        return Scaffold(
          body:

        Stack(
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
              padding: const EdgeInsetsDirectional.only(top: 50.0,start: 10.0,end: 10.0 ),
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

            Padding(
              padding: const EdgeInsetsDirectional.only(top: 90.0),
              child: ConditionalBuilder(
                condition: cubit.notifiedPostData != null, 
                builder: (BuildContext context) { 
                  String date = cubit.notifiedPostData!.created_at!.substring(0,10);
                  String time = cubit.notifiedPostData!.created_at!.substring(11,16);

                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('* Violation Report*\n'
                              ' *Date:* [${notificationData.created_at!.substring(0,16)}] \n'
                              '*Content Owner:* [Owner\'s Name/ ${cubit.profileData!.first_name} ${cubit.profileData!.last_name}] \n'
                              '*Reported Content:* \n'
                              '- *Type:* [Photo] \n'
                              '- *Description:* [Someone uploaded photo of you]\n'
                              '- *Date and Time:* [$date  $time] \n'
                              '*Evidence:*\n'
                              '- *Visual Proof:* [Screenshots] \n'
                              '*Actions:*\n'
                              '- *Moderation Decision:* [Delete/remove] \n'
                              '*Contact:*\n'
                              'Thank you,\n'
                              'DigitalCopyRight Team',
                              maxLines: 20,
                              style:TextStyle(
                                  fontSize: 12.0,
                                  decoration: TextDecoration.none,
                                color: Colors.red
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.symmetric(horizontal: 15.0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0)
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image(image: NetworkImage('${cubit.notifiedPostData!.image_url}'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                  onPressed: (){

                                    cubit.UpdatePost(id: notificationData.id!, action: 'keep');
                                    cubit.GetNotification();

                                    Fluttertoast.showToast(
                                        msg: 'Photo kept',
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 5,
                                        backgroundColor: Colors.green,
                                        textColor: Colors.white,
                                        fontSize: 16.0
                                    );
                                  },
                                  child: Text('Keep'
                                    ,style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w300
                                    ),)),
                            ),
                            Container(
                              height: 20.0,
                              width: 1.0,
                              color: Colors.grey,
                            ),
                            Expanded(
                              child: TextButton(
                                  onPressed: (){

                                    cubit.UpdatePost(id: notificationData.id!, action: 'delete');
                                    cubit.GetPostsAllData();
                                    cubit.GetNotification();
                                    Fluttertoast.showToast(
                                      msg: 'Photo deleted successfully',
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 5,
                                      backgroundColor: Colors.green,
                                      textColor: Colors.white,
                                      fontSize: 16.0,

                                    );
                                  },
                                  child: Text('Delete'
                                    ,style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w300
                                    ),)),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
                
                fallback: (BuildContext context) { 
                  return Center(child: CircularProgressIndicator(),);
                },
                
              ),
            )

          ],
        ));
      },
      listener: (BuildContext context, AppStates state) {  },

    );
  }
}
