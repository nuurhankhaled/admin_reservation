import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reservationapp_admin/core/Api/endPoints.dart';
import 'package:reservationapp_admin/core/Api/my_http.dart';
import 'package:reservationapp_admin/core/utilies/easy_loading.dart';
import 'package:reservationapp_admin/features/View-users/data/models/acceptance-model.dart';
import 'package:reservationapp_admin/core/helpers/extensions.dart';
part 'state.dart';

class AcceptUserCubit extends Cubit<AcceptUserState> {
  AcceptUserCubit() : super(AcceptUserInitial());
  static const Duration timeoutDuration = Duration(seconds: 30);

  static AcceptUserCubit get(context) => BlocProvider.of(context);

  Future<void> AcceptUser({required String Id, context}) async {
    emit(AcceptUserLoading());
    showLoading();
    try {
      var response = await MyDio.post(endPoint: EndPoints.acceptUser, data: {
        'id': Id,
      }).timeout(timeoutDuration, onTimeout: () {
        emit(AcceptUserTimeOut());
      });
      print(response!);
      var data = response.data;
      print(data);
      var decodedData = json.decode(response.data);
      var jsonResponse = AcceptanceModel.fromJson(decodedData);
      if (jsonResponse.success == true) {
        showSuccess("تم قبول المستخدم بنجاح");
        emit(AcceptUserSuccess());
      } else {
        showError("حدث خطأ ما");
        emit(AcceptUserFailure());
      }
    } catch (e) {
      print(e.toString());
      emit(AcceptUserFailure());
    }
  }
}
