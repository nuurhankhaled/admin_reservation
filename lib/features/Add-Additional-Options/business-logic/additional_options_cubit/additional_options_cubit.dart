import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reservationapp_admin/core/Api/my_http.dart';
import 'package:reservationapp_admin/core/utilies/easy_loading.dart';
import 'package:reservationapp_admin/features/View-Additional-Options/data/models/additional-options-model.dart';
import '../../../../Core/Api/endPoints.dart'; // Import the library that defines 'getCategories'.
import 'package:reservationapp_admin/core/helpers/extensions.dart';
part 'additional_options_state.dart';

class AdditionalOptionsCubit extends Cubit<AdditionalOptionsState> {
  AdditionalOptionsCubit() : super(AdditionalOptionsInitial());

  static AdditionalOptionsCubit get(context) => BlocProvider.of(context);
  static const Duration timeoutDuration = Duration(seconds: 30);

  Future<void> AddAdditionalOptions(
      {required categoryId, required name, required price, context}) async {
    emit(AddAdditionalOptionsLoading());
    showLoading();
    try {
      var response =
          await MyDio.post(endPoint: EndPoints.addAdditionalOptions, data: {
        "category_id": categoryId,
        "name": name,
        "price": price,
      });
      if (response!.statusCode == 200) {
        hideLoading();
        showSuccess("تم اضافه المرفق بنجاح");
        emit(AddAdditionalOptionsSuccess());
      } else {
        showError("حدث خطأ ما");
      }
    } catch (e) {
      showError("حدث خطأ ما");
      emit(AddAdditionalOptionsFailure());
    }
  }

  List<Data> additionalOptions = [];

  Future<void> getAllAdditionalOptions() async {
    emit(GetAdditionalOptionsLoading());
    var response = await MyDio.get(endPoint: EndPoints.getAllAdditionalOptions);
    try {
      if (response!.statusCode == 200) {
        var decodedData = json.decode(response.data);
        var jsonResponse = AdditionalOptionsModel.fromJson(decodedData);
        if (jsonResponse.success!) {
          additionalOptions = jsonResponse.data!;
          print(additionalOptions);
          emit(GetAdditionalOptionsSuccess());
        } else {
          print(response.data);
          print(response.statusCode);
          emit(GetAdditionalOptionsFailure());
        }
      } else {
        print(response.data);
        print(response.statusCode);
        emit(GetAdditionalOptionsFailure());
      }
    } catch (e) {
      print(e);
      emit(GetAdditionalOptionsFailure());
    }
  }

  Future<void> deleteAdditionalOption({required id}) async {
    emit(DeleteAdditionalOptionsLoading());
    showLoading();
    var response =
        await MyDio.post(endPoint: EndPoints.deleteOptiopn, data: {"id": id});
    try {
      if (response!.statusCode == 200) {
        showSuccess("تم حذف المرفق بنجاح");
        emit(DeleteAdditionalOptionsSuccess());
      } else {
        showError("حدث خطأ ما");
        emit(DeleteAdditionalOptionsFailure());
      }
    } catch (e) {
      showError("حدث خطأ ما");
      print(e);
      emit(DeleteAdditionalOptionsFailure());
    }
  }

  Future<void> editAdditionalOption(
      {required id, required name, required price}) async {
    emit(EditAdditionalOptionsLoading());
    showLoading();

    var response = await MyDio.post(
        endPoint: EndPoints.editOptiopn,
        data: {"id": id, "name": name, "price": price});
    try {
      if (response!.statusCode == 200) {
        showSuccess("تم تعديل المرفق بنجاح");
        emit(EditAdditionalOptionsSuccess());
      } else {
        showError("حدث خطأ ما");
        emit(EditAdditionalOptionsFailure());
      }
    } catch (e) {
      showError("حدث خطأ ما");
      print(e);
      emit(EditAdditionalOptionsFailure());
    }
  }
}
