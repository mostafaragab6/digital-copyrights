import 'package:flutter/material.dart';

import '../Login/LoginScreen.dart';
class signUp extends StatefulWidget {
  @override
  State<signUp> createState() => _TestState();
}

class _TestState extends State<signUp> {
  var fNameController = TextEditingController();

  var lNameController = TextEditingController();

  var emailController = TextEditingController();

  var passController = TextEditingController();

  var phoneController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool isPass = true ;

  IconData icon = Icons.visibility_off;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          alignment: Alignment.topCenter,
          children:[ Container(
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
                      ])
              )),
            Padding(
              padding: const EdgeInsetsDirectional.only(top:35.0),
              child: Text('Sign Up',style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.w600,color: Colors.white),),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(top: 90.0, end: 220.0),
              child: Text('Sign Up with',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w400,color: Colors.white),),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 35.0,top: 130.0),
              child: Row(
                children: [
                  InkWell(
                    onTap: (){

                    },

                    child: Container(
                      height: 60.0,
                      width: 150.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.grey[900]
                      ),
                      child: Icon(Icons.g_mobiledata,size: 60.0,color: Colors.white,),
                    ),
                  ),
                  SizedBox(width: 40.0,),
                  InkWell(
                    onTap: (){},
                    child: Container(
                      height: 60.0,
                      width: 150.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.grey[900]
                      ),
                      child: Icon(Icons.apple,size: 40.0,color: Colors.white,),
                    ),
                  ),
                ],
              ),
            ),
            Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsetsDirectional.only(start: 40.0,end: 40.0, top: 215.0,bottom:30.0),
                child: Container(

                  decoration: BoxDecoration(

                      borderRadius: BorderRadius.circular(20.0)
                  ),
                  height: 650.0,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        SizedBox(height: 5.0,),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(start: 9.0,bottom: 2.0),
                          child: Text('First Name',style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.w600, color: Colors.white),),
                        ),
                        BiuldForm(
                            controller: fNameController,
                            type: TextInputType.text,
                            label: '',
                            validate: (value){
                              if(value!.isEmpty){
                                return ' please enter your first name';
                              }
                            },
                            suffix: Icons.person


                        ),
                        SizedBox(height: 30.0,),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(start: 9.0,bottom: 2.0),
                          child: Text('Last Name',style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.w600, color: Colors.white),),
                        ),
                        BiuldForm(
                            controller: lNameController,
                            type: TextInputType.text,
                            label: '',
                            validate: (value){
                              if(value!.isEmpty){
                                return ' please enter your last name';
                              }
                            },
                            suffix: Icons.person
                        ),
                        SizedBox(height: 30.0,),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(start: 9.0,bottom: 2.0),
                          child: Text('Email Address',style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.w600, color: Colors.white),),
                        ),
                        BiuldForm(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            label: '',
                            validate: (value){
                              if(value!.isEmpty){
                                return ' please enter your email address';
                              }
                            },
                            suffix: Icons.email_outlined
                        ),
                        SizedBox(height: 30.0,),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(start: 9.0,bottom: 2.0),
                          child: Text('Password',style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.w600, color: Colors.white),),
                        ),
                        BiuldForm(
                            isPassword: isPass,
                            controller: passController,
                            type: TextInputType.visiblePassword,
                            label: '',
                            validate: (value){
                              if(value!.isEmpty){
                                return ' short password';
                              }
                            },
                            suffix: isPass ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                            onClick: (){
                              setState(() {
                                isPass = !isPass;
                              });
                            }
                        ),
                        SizedBox(height:30.0,),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(start: 9.0,bottom: 2.0),
                          child: Text('Phone Number',style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.w600, color: Colors.white),),
                        ),
                        BiuldForm(
                            controller: phoneController,
                            type: TextInputType.phone,
                            label: '',
                            validate: (value){
                              if(value!.isEmpty){
                                return ' please enter your phone';
                              }
                            },
                            suffix: Icons.phone
                        ),

                        SizedBox(height: 30.0,),
                        BiuldtButton(
                            color: MaterialColor(0xFF760D3F, {}),
                            text: 'Sign Up',
                            function: () {
                              if(formKey.currentState!.validate()){
                                print('Successfully');
                              }
                            }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Already have an account?',style: TextStyle(color: Colors.white54),),
                            TextButton(onPressed: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:(context)=>Login(),
                                  )
                              );
                            }, child: Text('Log in',style: TextStyle(color: Colors.white),))
                          ],),
                      ],
                    ),
                  ),
                ),
              ),
            ),


          ]),
    );
  }
}

Widget BiuldForm (
    {
      required TextEditingController controller,
      IconData? suffix,
      required TextInputType type ,
      String? Function(String?)? validate,
      required String label,
      void Function()? onClick ,
      bool isPassword = false ,
    }
    )=>TextFormField(
    obscureText:isPassword? true : false ,

    style: TextStyle(
        color: Colors.white54
    ),
    controller: controller,
    keyboardType: type,
    validator: validate,
    decoration: InputDecoration(

        suffixIcon: IconButton( onPressed: onClick, icon: Icon(suffix,color: Colors.white54,),),
        focusedBorder:OutlineInputBorder(

            borderRadius: BorderRadius.circular(50.0),
            borderSide: BorderSide(color:  MaterialColor(0xFF6E3652, {}),)
        ),

        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color:  MaterialColor(0xFF6E3652, {}),
            ),
            borderRadius: BorderRadius.circular(50.0)
        ),
        label: Text(label,
          style: TextStyle(
              color: Colors.white
          ),)
    ));

Widget BiuldtButton (
    {
      double width = double.infinity,
      bool upper = false,
      Color color = Colors.blue,
      required String text,
      required void Function() function
    }
    )=> Container(
  decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(50.0),
      color: color

  ),
  height: 40.0,
  width: width,
  child:   MaterialButton(
    onPressed: function,
    child: Text( upper? text.toUpperCase() : text,
      style: TextStyle(
          color: Colors.white
      ),),

  ),
);