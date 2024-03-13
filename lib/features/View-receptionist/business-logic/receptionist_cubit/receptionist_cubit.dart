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
part 'receptionist_state.dart';

class ReceptionistCubit extends Cubit<ReceptionistState> {
  ReceptionistCubit() : super(ReceptionistsInitial());

  static ReceptionistCubit get(context) => BlocProvider.of(context);
  static const Duration timeoutDuration = Duration(seconds: 30);

  List<Data> receptionists = [];

  Future<void> getReceptionists() async {
    emit(GetReceptionistsLoading());
    try {
      var response = await MyDio.get(endPoint: EndPoints.getReceptionists);
      print(response!.statusCode);
      if (response!.statusCode == 200) {
        print(response.data);
        var decodedData = json.decode(response.data);
        var jsonResponse = ReceptionistModel.fromJson(decodedData);
        if (jsonResponse.success!) {
          print("categories");
          receptionists = jsonResponse.data!;
          print(receptionists);
          emit(GetReceptionistsSuccess());
        } else {
          print(response.data);
          print(response.statusCode);
          emit(GetReceptionistsFailure());
        }
      } else {
        print(response.data);
        print(response.statusCode);
        emit(GetReceptionistsFailure());
      }
    } catch (e) {
      print(e);
      emit(GetReceptionistsFailure());
    }
  }
  
  
  Future<void> changePassword({
    required id,
    required password,
  }) async {
    showLoading();
    emit(ChangePasswordLoading());
    try {
      var response =
          await MyDio.post(endPoint: "/user/change_password.php", data: {
        "id": id,
        "password": password,
      });
      print(response!.statusCode);
      if (response.statusCode == 200) {
        print(response.data);
        var decodedData = json.decode(response.data);
        var jsonResponse = ReceptionistModel.fromJson(decodedData);
        if (jsonResponse.success!) {
          showSuccess("تم تغيير كلمة المرور بنجاح");
          emit(ChangePasswordSuccess());
        } else {
          showError("حدث خطأ ما");
          print(response.data);
          print(response.statusCode);
          emit(ChangePasswordError());
        }
      } else {
        showError("حدث خطأ ما");
        print(response.data);
        print(response.statusCode);
        emit(ChangePasswordError());
      }
    } catch (e) {
      showError("حدث خطأ ما");
      print(e);
      emit(ChangePasswordError());
    }
  }
}
