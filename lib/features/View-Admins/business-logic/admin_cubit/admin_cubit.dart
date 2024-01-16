import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reservationapp_admin/core/Api/my_http.dart';
import 'package:reservationapp_admin/core/utilies/easy_loading.dart';
import 'package:reservationapp_admin/features/View-Admins/data/models/admin-model.dart';
import 'package:reservationapp_admin/features/View-users/data/models/acceptance-model.dart';
import '../../../../Core/Api/endPoints.dart'; // Import the library that defines 'getCategories'.
import 'package:reservationapp_admin/core/helpers/extensions.dart';
part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit() : super(UsersInitial());

  static AdminCubit get(context) => BlocProvider.of(context);
  static const Duration timeoutDuration = Duration(seconds: 30);

  List<Data> admins = [];

  Future<void> getadmins() async {
    emit(GetAdminsLoading());
    try {
      var response = await MyDio.get(endPoint: EndPoints.getAdmins);
      print(response!.statusCode);
      if (response.statusCode == 200) {
        print(response.data);
        var decodedData = json.decode(response.data);
        var jsonResponse = AdminModel.fromJson(decodedData);
        if (jsonResponse.success!) {
          admins = jsonResponse.data!;
          print(admins);
          emit(GetAdminsSuccess());
        } else {
          print(response.data);
          print(response.statusCode);
          emit(GetAdminsFailure());
        }
      } else {
        print(response.data);
        print(response.statusCode);
        emit(GetAdminsFailure());
      }
    } catch (e) {
      print(e);
      emit(GetAdminsFailure());
    }
  }

  Future<void> deleteAdmin({required String id, context}) async {
    emit(DeleteAdminLoading());
    showLoading();
    try {
      var response = await MyDio.post(endPoint: EndPoints.deleteAdmin, data: {
        'id': id,
      });
      print(response!);
      var data = response.data;
      print(data);
      var decodedData = json.decode(response.data);
      var jsonResponse = AcceptanceModel.fromJson(decodedData);
      if (jsonResponse.success == true) {
        showSuccess("تم مسح المستخدم بنجاح");
        emit(DeleteAdminSuccess());
      } else {
        showError("حدث خطأ ما");
        emit(DeleteAdminFailure());
      }
    } catch (e) {
      print(e.toString());
      showError("حدث خطأ ما");
      emit(DeleteAdminFailure());
    }
  }
}
