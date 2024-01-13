import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reservationapp_admin/core/Api/my_http.dart';
import 'package:reservationapp_admin/core/utilies/easy_loading.dart';
import 'package:reservationapp_admin/features/View-receptionist/data/models/recetptionist_model.dart';
import '../../../../Core/Api/endPoints.dart'; // Import the library that defines 'getCategories'.
import 'package:reservationapp_admin/core/helpers/extensions.dart';
part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit() : super(UsersInitial());

  static UsersCubit get(context) => BlocProvider.of(context);
  static const Duration timeoutDuration = Duration(seconds: 30);

  List<Data> acceptedUsers = [];

  Future<void> getAcceptedUsers() async {
    emit(GetAcceptedUsersLoading());
    try {
      var response = await MyDio.get(endPoint: EndPoints.getAcceptedUsers);
      print(response!.statusCode);
      if (response!.statusCode == 200) {
        print(response.data);
        var decodedData = json.decode(response.data);
        var jsonResponse = ReceptionistModel.fromJson(decodedData);
        if (jsonResponse.success!) {
          print("categories");
          acceptedUsers = jsonResponse.data!;
          print(acceptedUsers);
          emit(GetAcceptedUsersSuccess());
        } else {
          print(response.data);
          print(response.statusCode);
          emit(GetAcceptedUsersFailure());
        }
      } else {
        print(response.data);
        print(response.statusCode);
        emit(GetAcceptedUsersFailure());
      }
    } catch (e) {
      print(e);
      emit(GetAcceptedUsersFailure());
    }
  }

  List<Data> pendingUsers = [];

  Future<void> getPendingUsers() async {
    emit(GetPendingUsersLoading());
    try {
      var response = await MyDio.get(endPoint: EndPoints.getPendingUsers);
      print(response!.statusCode);
      if (response.statusCode == 200) {
        print(response.data);
        var decodedData = json.decode(response.data);
        var jsonResponse = ReceptionistModel.fromJson(decodedData);
        if (jsonResponse.success!) {
          print("categories");
          pendingUsers = jsonResponse.data!;
          print(pendingUsers);
          emit(GetPendingUsersSuccess());
        } else {
          print(response.data);
          print(response.statusCode);
          emit(GetPendingUsersFailure());
        }
      } else {
        print(response.data);
        print(response.statusCode);
        emit(GetPendingUsersFailure());
      }
    } catch (e) {
      print(e);
      emit(GetPendingUsersFailure());
    }
  }

  List<Data> admins = [];

  Future<void> getadmins() async {
    emit(GetPendingUsersLoading());
    try {
      var response = await MyDio.get(endPoint: EndPoints.getPendingUsers);
      print(response!.statusCode);
      if (response.statusCode == 200) {
        print(response.data);
        var decodedData = json.decode(response.data);
        var jsonResponse = ReceptionistModel.fromJson(decodedData);
        if (jsonResponse.success!) {
          print("categories");
          pendingUsers = jsonResponse.data!;
          print(pendingUsers);
          emit(GetPendingUsersSuccess());
        } else {
          print(response.data);
          print(response.statusCode);
          emit(GetPendingUsersFailure());
        }
      } else {
        print(response.data);
        print(response.statusCode);
        emit(GetPendingUsersFailure());
      }
    } catch (e) {
      print(e);
      emit(GetPendingUsersFailure());
    }
  }
}
