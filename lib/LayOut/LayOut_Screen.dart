import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Const/Components.dart';
import '../../Models/AppCubit/AppCubit.dart';
import '../../Models/AppCubit/AppStates.dart';

class SocialAppLayout extends StatelessWidget {

  var postController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit , AppStates>(
      builder: (BuildContext context, AppStates state) {
        var Cubit = AppCubit.ACubit(context);

        return Scaffold(
          appBar: AppBar(

            leading: Padding(
              padding: const EdgeInsetsDirectional.only(start: 20.0),
              child: Icon(Cubit.icons[Cubit.currentIndex],size: 40.0,color: Colors.white,),
            ),
            title: Text('${Cubit.Titles[Cubit.currentIndex]}',),
            actions: [
              IconButton(onPressed: (){
                Cubit.FollowUser(id: 9);
              }, icon: Icon(Icons.notifications)),
              Cubit.Titles[Cubit.currentIndex]=='Home' ? IconButton(
                  onPressed: (){
                    showModalBottomSheet(
                        shape:OutlineInputBorder(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0),topRight: Radius.circular(20.0))
                        ) ,
                        context: context,
                        builder: (context){
                          return Container(
                              height:MediaQuery.sizeOf(context).height * 2/3
                              ,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20.0),
                                      topLeft: Radius.circular(20.0)
                                  )
                              ),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.only(top: 10.0,start: 10.0 , end: 10.0),
                                child: Column(
                                  children: [
                                    TextFormField(

                                      maxLines: 10,
                                      minLines: 4,
                                      keyboardType: TextInputType.text,
                                      controller: postController,
                                      decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color:Colors.grey),
                                              borderRadius: BorderRadius.circular(20.0)
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color:Colors.black),
                                              borderRadius: BorderRadius.circular(20.0)
                                          ),
                                          label: Text('Write your post')

                                      ),
                                    ),
                                    SizedBox(height: 10.0,),
                                    Row(
                                      children: [
                                        Spacer(),
                                        Text('Add image'),
                                        MaterialButton(
                                          onPressed: (){
                                            Cubit.pickImage();
                                          },
                                          child: Icon(Icons.add_box_rounded,color: Colors.blue,),

                                        )
                                      ],
                                    ),
                                    SizedBox(height: 10.0,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Cubit.image != null ?
                                        Padding(
                                          padding: const EdgeInsetsDirectional.only(bottom: 10.0,end: 15.0),
                                          child: Container(
                                            width: 70.0,
                                            height: 90.0,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10.0)
                                            ),
                                            child: ClipRRect(
                                                borderRadius: BorderRadius.circular(10.0),
                                                child: Image.file(Cubit.image!,fit: BoxFit.cover,)),
                                          ),
                                        )
                                            :SizedBox(),
                                        defaultButton(
                                            color: Colors.black,
                                            text: 'Post',
                                            function: (){
                                              print(postController.text);
                                              Cubit.SetPost(content: postController.text,imagePath: Cubit.image!.path);
                                              Cubit.image = null;
                                              Cubit.flag?Navigator.pop(context):null;
                                            }),
                                      ],
                                    )
                                  ],
                                ),
                              )
                          );
                        });
                  },
                  icon: Icon(Icons.add_circle_outline)) : SizedBox()
            ],
          ),
          body: Cubit.Screens[Cubit.currentIndex],

          bottomNavigationBar: BottomNavigationBar(

            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
              BottomNavigationBarItem(icon: Stack(
                alignment: Alignment.topRight,
                children: [
                  Icon(Icons.notifications),
                  CircleAvatar(
                    radius: 7.0,
                    backgroundColor: Colors.red,
                    child: Text('${Cubit.Counter}'),

                  ),
                ],
              ),label: "Notifications"),
              BottomNavigationBarItem(icon: Icon(Icons.person),label: "Profile"),
            ],
            currentIndex: Cubit.currentIndex,
            onTap: (index){
              Cubit.CahngeNavBar(index);
            },
          ),
        );
      },
      listener: (BuildContext context, AppStates state) {  },

    );
  }
}
