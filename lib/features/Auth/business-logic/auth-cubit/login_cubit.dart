import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'login_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);
  bool ispasswordshow = true;
  IconData suffixicon = Icons.visibility_off;

  void showLoginpassword() {
    ispasswordshow = !ispasswordshow;
    suffixicon = ispasswordshow ? Icons.visibility : Icons.visibility_off;
    emit(PasswordIconChangestate());
  }
}
