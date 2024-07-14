part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class LoginSuccess extends AuthState {}

final class LoginLoading extends AuthState {}

final class LoginError extends AuthState {
  final String errorMassage;

  LoginError({required this.errorMassage});
}

final class RegisterSuccess extends AuthState {}

final class RegisterLoading extends AuthState {}

final class RegisterError extends AuthState {
  final String errorMassage;

  RegisterError({required this.errorMassage});
}

