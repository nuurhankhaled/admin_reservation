part of 'login_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class PasswordIconChangestate extends AuthState {}

class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {}

class LoginErrorState extends AuthState {}
