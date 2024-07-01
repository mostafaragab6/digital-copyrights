import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Models/RegisterCubit/RegisterCubit.dart';
import '../../Models/RegisterCubit/RegisterStates.dart';
import '../Login/LoginScreen.dart';

class signUp extends StatefulWidget {
  @override
  State<signUp> createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  var fNameController = TextEditingController();
  var lNameController = TextEditingController();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var usernameController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isPass = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (BuildContext context, state) {
          if (state is RegisterSuccessState) {
            print('Registration Successful');
          } else if (state is RegisterErrorState) {
            print('Error: ${state.error}');
          }
        },
        builder: (BuildContext context, state) {
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
                        MaterialColor(0xFF021222, {})
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(top: 35.0),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                      top: 90.0, end: 220.0),
                  child: Text(
                    'Sign Up with',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                      start: 35.0, top: 130.0),
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
                        start: 40.0, end: 40.0, top: 215.0, bottom: 30.0),
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
                            SizedBox(height: 5.0),
                            Padding(
                              padding: const EdgeInsetsDirectional.only(
                                  start: 9.0, bottom: 2.0),
                              child: Text(
                                'First Name',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            BuildForm(
                              controller: fNameController,
                              type: TextInputType.text,
                              label: '',
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return ' please enter your first name';
                                }
                              },
                              suffix: Icons.person,
                            ),
                            SizedBox(height: 30.0),
                            Padding(
                              padding: const EdgeInsetsDirectional.only(
                                  start: 9.0, bottom: 2.0),
                              child: Text(
                                'Last Name',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            BuildForm(
                              controller: lNameController,
                              type: TextInputType.text,
                              label: '',
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return ' please enter your last name';
                                }
                              },
                              suffix: Icons.person,
                            ),
                            SizedBox(height: 30.0),
                            Padding(
                              padding: const EdgeInsetsDirectional.only(
                                  start: 9.0, bottom: 2.0),
                              child: Text(
                                'Email Address',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            BuildForm(
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              label: '',
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return ' please enter your email address';
                                }
                              },
                              suffix: Icons.email_outlined,
                            ),
                            SizedBox(height: 30.0),
                            Padding(
                              padding: const EdgeInsetsDirectional.only(
                                  start: 9.0, bottom: 2.0),
                              child: Text(
                                'Password',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            BuildForm(
                              isPassword: isPass,
                              controller: passController,
                              type: TextInputType.visiblePassword,
                              label: '',
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return ' short password';
                                }
                              },
                              suffix: isPass
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              onClick: () {
                                setState(() {
                                  isPass = !isPass;
                                });
                              },
                            ),
                            SizedBox(height: 30.0),
                            Padding(
                              padding: const EdgeInsetsDirectional.only(
                                  start: 9.0, bottom: 2.0),
                              child: Text(
                                'Username',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            BuildForm(
                              controller: usernameController,
                              type: TextInputType.text,
                              label: '',
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return ' please enter your username';
                                }
                              },
                              suffix: Icons.phone,
                            ),
                            SizedBox(height: 30.0),
                            Padding(
                              padding: const EdgeInsetsDirectional.only(
                                  start: 9.0, bottom: 2.0),
                              child: Text(
                                'Profile photo',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Center(
                              child: IconButton(
                                icon: Icon(Icons.photo_camera),
                                color: Colors.white,
                                onPressed: () {
                                  RegisterCubit.get(context).pickImage();
                                },
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Center(
                              child: BlocBuilder<RegisterCubit, RegisterState>(
                                builder: (context, state) {
                                  final imageFile = RegisterCubit.get(context).image;
                                  return imageFile == null
                                      ? Text(
                                    'No image selected.',
                                    style: TextStyle(color: Colors.white54),
                                  )
                                      : Image.file(
                                    imageFile,
                                    height: 100,
                                    width: 100,
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 30.0),
                            ConditionalBuilder(
                              condition: state is! RegisterLoadingState,
                              builder: (context) => BuildButton(
                                color: MaterialColor(0xFF760D3F, {}),
                                text: 'Sign Up',
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    RegisterCubit.get(context).userRegister(
                                      email: emailController.text,
                                      password: passController.text,
                                      firstname: fNameController.text,
                                      lastname: lNameController.text,
                                      username: usernameController.text,
                                      imagePath: RegisterCubit.get(context).image!.path,

                                    );

                                    print(emailController.text);
                                    print(passController.text);
                                    print(fNameController.text);
                                    print(lNameController.text);
                                    print(usernameController.text);

                                    print(RegisterCubit.get(context).image!.path);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Login(),
                                      ),
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
                                  'Already have an account?',
                                  style: TextStyle(color: Colors.white54),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Login(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Log in',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
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

Widget BuildForm({
  required TextEditingController controller,
  IconData? suffix,
  required TextInputType type,
  String? Function(String?)? validate,
  required String label,
  void Function()? onClick,
  bool isPassword = false,
}) =>
    TextFormField(
      obscureText: isPassword,
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
          borderSide: BorderSide(
            color: MaterialColor(0xFF6E3652, {}),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: MaterialColor(0xFF6E3652, {}),
          ),
          borderRadius: BorderRadius.circular(50.0),
        ),
        label: Text(
          label,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );

Widget BuildButton({
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