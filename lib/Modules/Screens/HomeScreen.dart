import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Models/AllPostsModel.dart';
import '../../Models/AppCubit/AppCubit.dart';
import '../../Models/AppCubit/AppStates.dart';



class HomeScreen extends StatelessWidget {


  DateTime dateTime = DateTime.now();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      builder: (BuildContext context, AppStates state) {
        var cubit = AppCubit.ACubit(context);
        return RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(Duration(seconds: 1));
           cubit.GetProfileData();
           cubit.GetPostsAllData();
           cubit.GetNotification();
           cubit.GetUserPostsData();
          },
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
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 10.0,start: 10.0,end: 10.0 ),
                child: Row(
                  children: [

                    Text('Good Morning, ',
                      style: TextStyle(
                          decoration:TextDecoration.none,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[300]
                      ),),
                    Spacer(),

                  ],
                ),
              ),


              Padding(
                padding: const EdgeInsetsDirectional.only(top:50.0),
                child: ConditionalBuilder(
                  condition: cubit.postsAllData != null,
                  builder: (BuildContext context) {
                    return ListView.separated(

                        itemBuilder: (context , index){

                          String dateTimeString = cubit.postsAllData!.content[index].created_at!;


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
                                postsAllContent: cubit.postsAllData!.content[index],
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
                        itemCount: cubit.postsAllData!.content.length);
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
        );

      },
      listener: (BuildContext context, AppStates state) {  },

    );
  }
}
Widget CreateItem(
    {
        required PostsAllContent postsAllContent,
      required AppCubit cubit,
      required  String year,
      required  String month,
      required  String day,
      required  String hour,
      required  String minute,
      required  DateTime dateTime})=> Container(

  child:
  Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(bottom: 10.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 19.0,
                backgroundImage:
                AssetImage('images/user.png')

                ,),
              SizedBox(width: 15.0,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                       postsAllContent.userPostInfo != null ?Text('${postsAllContent.userPostInfo!.first_name} ${postsAllContent.userPostInfo!.last_name}',
                        style: TextStyle(
                            decoration:TextDecoration.none,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[300]
                        ),):Text('Unknown User',
                         style: TextStyle(
                             decoration:TextDecoration.none,
                             fontSize: 15.0,
                             fontWeight: FontWeight.w600,
                             color: Colors.grey[300]
                         ),),
                      SizedBox(width: 5.0,),
                      Icon(Icons.check_circle, color: Colors.blue,size: 19.0,),
                    ],
                  ),

                  //15:02:20
                  //2024-06-22T15:02:20
                  dateTime.month - int.parse(month) != 0 ? Text('${dateTime.month - int.parse(month)}mon',style: TextStyle(color: Colors.grey[200]),):
                  dateTime.month - int.parse(month) == 0 && dateTime.day - int.parse(day) != 0 ? Text('${dateTime.day - int.parse(day)}d',style: TextStyle(color: Colors.grey[200])):
                  dateTime.month - int.parse(month) == 0 && dateTime.day - int.parse(day) == 0 && dateTime.hour - int.parse(hour) != 0 ? Text('${dateTime.hour - int.parse(hour)}h',style: TextStyle(color: Colors.grey[200])):
                  Text('${dateTime.minute - int.parse(minute)}min',style: TextStyle(color: Colors.grey[200]))
                  ,
                ],
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 15.0),
                child: Icon(Icons.keyboard_control,color: Colors.white,),
              )

            ],
          ),
        ),



        postsAllContent.title != null && (postsAllContent.image_url == null || postsAllContent.image_url!.endsWith("media/")) ?Text('${postsAllContent.title}',
          style:
          TextStyle(
              height: 2.0,
              fontSize: 17.0,
              fontWeight: FontWeight.w400,
              color: Colors.white,
              decoration: TextDecoration.none
          ),)
            : postsAllContent.title == null && postsAllContent.image_url != null ?  Padding(
          padding: const EdgeInsetsDirectional.only(top: 8.0),
          child: Container(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image(image: NetworkImage('${postsAllContent.image_url}'))),
          ),
        ) : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${postsAllContent.title}',
              style:
              TextStyle(
                  height: 2.0,
                  fontSize: 17.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  decoration: TextDecoration.none
              ),),
            SizedBox(height: 10.0,),

            Padding(
              padding: const EdgeInsetsDirectional.only(top: 8.0),
              child: Container(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image(image: NetworkImage('${postsAllContent.image_url}'))),
              ),
            )
          ],
        ),


        Padding(
          padding: const EdgeInsetsDirectional.only(top: 40.0, bottom: 10.0,start: 20.0,end: 20.0),
          child: Row(
            children: [
              Icon(Icons.favorite_outline,color: Colors.white,),
              Spacer(),
              Icon(Icons.question_answer_rounded,color: Colors.white,),
              Spacer(),
              Icon(Icons.reply_rounded,color: Colors.white,)
            ],
          ),
        ),
      ],
    ),
  ),
);
