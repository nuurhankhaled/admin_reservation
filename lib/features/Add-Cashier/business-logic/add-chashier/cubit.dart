import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reservationapp_admin/core/Api/endPoints.dart';
import 'package:reservationapp_admin/core/Api/my_http.dart';
part 'state.dart';

class AddCashierCubit extends Cubit<AddCashierState> {
  AddCashierCubit() : super(AddCahierInitial());
  static const Duration timeoutDuration = Duration(seconds: 30);

  static AddCashierCubit get(context) => BlocProvider.of(context);

  Future<void> AddCahier({
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
    required String nid,
  }) async {
    emit(AddCahierLoading());

    var response;
    var postData = {
      "name": name,
      "email": email,
      "password": password,
      "phone": phoneNumber,
      "nid": nid,
      // Add other key-value pairs for your form data
    };

    try {
      response = await MyHttp.post(
        endPoint: EndPoints.addAdmin,
        data: postData,
      );
      print('Name: $name');
      if (response != null) {
        print('Response Status Code: ${response.statusCode}');
        if (response.statusCode == 200) {
          emit(AddCahierSuccess());
        } else {
          emit(AddCahierFailure());
        }
      } else {
        // Handle null response
        print('Null response received');
        emit(AddCahierFailure());
      }
    } catch (e) {
      print('Exception occurred: $e');
      emit(AddCahierFailure());
    }
  }
}
