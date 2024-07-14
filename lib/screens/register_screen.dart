import 'package:chat_app/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../widgets/constants.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class RegisterScreen extends StatelessWidget {
  String? email;

  String? password;
  static String id = 'RegisterScreen';
  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isLoading = true;
        } else if (state is RegisterSuccess) {
          Navigator.pop(context);
          isLoading = false;
        } else if (state is RegisterError) {
          showSnackBar(context, state.errorMassage);
          isLoading = false;
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
                            'Register',
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
                              if (formKey.currentState!.validate()) {
                                BlocProvider.of<AuthBloc>(context).add(
                                    RegisterAuth(
                                        email: email!, password: password!));
                              }
                            },
                            text: 'Register',
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
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Login',
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
