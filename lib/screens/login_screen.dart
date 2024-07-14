

import 'package:chat_app/screens/register_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../bloc/auth_bloc.dart';
import '../cubits/chat/chat_cubit.dart';
import '../widgets/constants.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import 'chat_screen.dart';



class LoginScreen extends StatefulWidget {
   static String id ='LoginScreen';

  const LoginScreen({super.key,});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
   String? email,password;

  bool isLoading=false;

   GlobalKey<FormState> formKey=GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
  listener: (context, state) {
    if(state is LoginLoading){
      isLoading=true;
    }else if(state is LoginSuccess){
      BlocProvider.of<ChatCubit>(context).getMessage();
      Navigator.pushNamed(context, ChatScreen.id,arguments: email);
      isLoading=false;
    }else if(state is LoginError){
      showSnackBar(context, state.errorMassage);
      isLoading=false;
    }
  },
  builder: (context, state) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Image.asset(
                    kLogo,
                    height: 100,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Scholar Chat',
                        style: TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 150,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'LOGIN',
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        onChange: (data) {
                          email = data;
                        },
                        hintText: 'Email',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        obscureText: true,
                        onChange: (data) {
                          password = data;
                        },
                        hintText: 'Password',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomButton(
                        ontap: () async {
                          if(formKey.currentState!.validate()){
                            BlocProvider.of<AuthBloc>(context).add(LoginAuth(email: email!, password: password!));
                          }

                        },
                        text: 'Login',
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'already have an account',
                            style: TextStyle(color: Colors.white),
                          ),
                          TextButton(
                              onPressed: () {
                               Navigator.pushNamed(context, RegisterScreen.id);
                              },
                              child: const Text(
                                'register',
                                style: TextStyle(
                                  color: Color(0xffE7EDE6),
                                ),
                              ))
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  },
);
  }
}
