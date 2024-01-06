import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reservationapp_admin/core/Api/my_http.dart';
import 'package:reservationapp_admin/core/utilies/easy_loading.dart';
import 'package:reservationapp_admin/features/Add-Category/data/models/category_model.dart';
import '../../../../Core/Api/endPoints.dart'; // Import the library that defines 'getCategories'.
import 'package:reservationapp_admin/core/helpers/extensions.dart';
part 'additional_options_state.dart';

class AdditionalOptionsCubit extends Cubit<AdditionalOptionsState> {
  AdditionalOptionsCubit() : super(AdditionalOptionsInitial());

  static AdditionalOptionsCubit get(context) => BlocProvider.of(context);
  static const Duration timeoutDuration = Duration(seconds: 30);

  AddAdditionalOptions(
      {required categoryId, required name, required price, context}) async {
    emit(AdditionalOptionsLoading());
    showLoading();
    try {
      var response =
          await MyDio.post(endPoint: EndPoints.addAdditionalOptions, data: {
        "category_id": categoryId,
        "name": name,
        "price": price,
      });
      print(response!.data);
      if (response.statusCode == 200) {
        hideLoading();
        showSuccess("تم اضافه المرفق بنجاح");
        emit(AdditionalOptionsSuccess());
      } else {
        showError("حدث خطأ ما");
        print(response!.data);
        print(response.statusCode);
      }
    } catch (e) {
      showError("حدث خطأ ما");

      print("Error while uploading image: $e");
      emit(AdditionalOptionsFailure());
    }
  }
}
