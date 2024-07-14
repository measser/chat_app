part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class LoginAuth extends AuthEvent{
  final String email , password;

  LoginAuth({required this.email, required this.password});
}

class RegisterAuth extends AuthEvent{
  final String email , password;

  RegisterAuth({required this.email, required this.password});
}


