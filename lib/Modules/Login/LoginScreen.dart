import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:digital_copy_rights/Models/AppCubit/AppCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../Const/Components.dart';
import '../../LayOut/LayOut_Screen.dart';
import '../../Models/LoginCubit/LoginCubit.dart';
import '../../Models/LoginCubit/LoginStates.dart';
import '../../Remote/CacheHelper.dart';
import '../Register/RegisterScreen.dart';


class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (BuildContext context, state) {
          if (state is LoginSuccessState) {
            if (state.loginmodel.status) {
              print(state.loginmodel.token);
              Fluttertoast.showToast(
                msg: 'Logged in successfully',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0,
              );

              cachHelper.SaveData(key:'token', value: state.loginmodel.token).then((value){
                navigateAndFinish(context, SocialAppLayout());
              });
              token =state.loginmodel.token;
              AppCubit.ACubit(context).GetProfileData();
              AppCubit.ACubit(context).GetPostsAllData();
              AppCubit.ACubit(context).GetNotification();
              AppCubit.ACubit(context).GetUserPostsData();

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(

                  builder: (context) => SocialAppLayout(),
                ),
              );
            } else {
              Fluttertoast.showToast(
                msg: 'Wrong email or password',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            }
          } else if (state is LoginErrorState) {
            Fluttertoast.showToast(
              msg: state.error,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
        },
        builder: (BuildContext context, state) {
          var cubit = LoginCubit.get(context);
          return Scaffold(
            body: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      transform: GradientRotation(44),
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        MaterialColor(0xFF1B0810, {}),
                        Colors.black,
                        MaterialColor(0xFF021222, {}),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(top: 35.0),
                  child: Text(
                    'Sign in',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(top: 90.0, end: 220.0),
                  child: Text(
                    'Sign in with',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 35.0, top: 130.0),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: 60.0,
                          width: 150.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Colors.grey[900],
                          ),
                          child: Icon(
                            Icons.g_mobiledata,
                            size: 60.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: 40.0),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: 60.0,
                          width: 150.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Colors.grey[900],
                          ),
                          child: Icon(
                            Icons.apple,
                            size: 40.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(
                      start: 40.0,
                      end: 40.0,
                      top: 215.0,
                      bottom: 30.0,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      height: 650.0,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 50.0),
                            Padding(
                              padding: const EdgeInsetsDirectional.only(
                                start: 9.0,
                                bottom: 2.0,
                              ),
                              child: Text(
                                'Email Address',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            BiuldForm(
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              label: '',
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your email address';
                                }
                              },
                              suffix: Icons.email_outlined,
                            ),
                            SizedBox(height: 30.0),
                            Padding(
                              padding: const EdgeInsetsDirectional.only(
                                start: 9.0,
                                bottom: 2.0,
                              ),
                              child: Text(
                                'Password',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            BiuldForm(
                              isPassword: cubit.isPass,
                              controller: passController,
                              type: TextInputType.visiblePassword,
                              label: '',
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your password';
                                }
                              },
                              suffix: cubit.isPass
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              onClick: () {
                                cubit.ChangePasswordVisibility();
                              },
                            ),
                            SizedBox(height: 50),
                            ConditionalBuilder(
                              condition: state is! LoginLoadingState,
                              builder: (context) => BiuldtButton(
                                color: MaterialColor(0xFF760D3F, {}),
                                text: 'Sign in',
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    LoginCubit.get(context).userLogin(
                                      emailController.text,
                                      passController.text,
                                    );

                                  }
                                },
                              ),
                              fallback: (context) => Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Don\'t have an account?',
                                  style: TextStyle(color: Colors.white54),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => signUp(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Sign Up',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

Widget BiuldForm({
  required TextEditingController controller,
  IconData? suffix,
  required TextInputType type,
  String? Function(String?)? validate,
  required String label,
  void Function()? onClick,
  bool isPassword = false,
}) =>
    TextFormField(
      obscureText: isPassword ? true : false,
      style: TextStyle(color: Colors.white54),
      controller: controller,
      keyboardType: type,
      validator: validate,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: onClick,
          icon: Icon(
            suffix,
            color: Colors.white54,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0),
          borderSide: BorderSide(color: MaterialColor(0xFF6E3652, {})),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: MaterialColor(0xFF6E3652, {}),
          ),
          borderRadius: BorderRadius.circular(50.0),
        ),
        labelText: label,
        labelStyle: TextStyle(color: Colors.white),
      ),
    );

Widget BiuldtButton({
  double width = double.infinity,
  bool upper = false,
  Color color = Colors.blue,
  required String text,
  required void Function() function,
}) =>
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        color: color,
      ),
      height: 40.0,
      width: width,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          upper ? text.toUpperCase() : text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );