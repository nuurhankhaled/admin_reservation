import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reservationapp_admin/core/Api/my_http.dart';
import 'package:reservationapp_admin/core/utilies/easy_loading.dart';
import 'package:reservationapp_admin/features/View-category-details/data/models/items-model.dart';
import '../../../../Core/Api/endPoints.dart'; // Import the library that defines 'getCategories'.
import 'package:reservationapp_admin/core/helpers/extensions.dart';
part 'category_items_state.dart';

class CategoryItemsCubit extends Cubit<CategoryItemsState> {
  CategoryItemsCubit() : super(CategoryItemsInitial());

  static CategoryItemsCubit get(context) => BlocProvider.of(context);
  static const Duration timeoutDuration = Duration(seconds: 30);

  List<Data> categoryItems = [];

  getCategoryItems({
    required String categoryName,
  }) async {
    emit(GetCategoryItemsLoading());
    try {
      var response =
          await MyDio.post(endPoint: EndPoints.getCategoryItems, data: {
        'category_name': categoryName,
      });
      print(response!.statusCode);
      if (response!.statusCode == 200) {
        print(response.data);
        var decodedData = json.decode(response.data);
        var jsonResponse = ItemModel.fromJson(decodedData);
        if (jsonResponse.success!) {
          print("categories");
          categoryItems = jsonResponse.data!;
          print(categoryItems);
          emit(GetCategoryItemsSuccess());
        } else {
          print(response.data);
          print(response.statusCode);
          emit(GetCategoryItemsFailure());
        }
      } else {
        print(response.data);
        print(response.statusCode);
        emit(GetCategoryItemsFailure());
      }
    } catch (e) {
      print(e);
      emit(GetCategoryItemsFailure());
    }
  }
}
