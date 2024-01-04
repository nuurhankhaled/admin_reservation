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
part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());

  static CategoryCubit get(context) => BlocProvider.of(context);
  static const Duration timeoutDuration = Duration(seconds: 30);

  AddCategory({required image, required name, context}) async {
    emit(AddCategoryLoading());
    showLoading();
    try {
      String fileName = image.path.split('/').last;
      FormData formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(image.path, filename: fileName),
        "name": name
      });
      var response =
          await MyDio.post(endPoint: EndPoints.addCategory, data: formData);
      print(response!.data);
      if (response.statusCode == 200) {
        hideLoading();
        showSuccess("تم اضافه المرفق بنجاح");
        emit(AddCategorySuccess());
      } else {
        showError("حدث خطأ ما");
        print(response!.data);
        print(response.statusCode);
      }
    } catch (e) {
      showError("حدث خطأ ما");

      print("Error while uploading image: $e");
      emit(AddCategoryFailure());
    }
  }

  File? pickedImage;

  pickImage(ImageSource source, context) async {
    try {
      final picker = ImagePicker();
      final image = await picker.pickImage(source: source);
      if (image == null) return;
      final imageTemp = File(image.path);
      pickedImage = imageTemp;

      emit(PickImageSuccessState());
    } catch (e) {
      print("failed to pick image : $e");
      emit(PickImageErrorState(e.toString()));
    }
  }

  List<Data> categories = [];

  getCategories() async {
    emit(GetCategoriesLoading());
    try {
      var response = await MyDio.get(endPoint: EndPoints.getCategories);
      print("-----------------  getCategories  -----------------");
      print(response!.statusCode);
      if (response!.statusCode == 200) {
        print(response.data);
        var decodedData = json.decode(response.data);
        var jsonResponse = CategoryModel.fromJson(decodedData);
        if (jsonResponse.success!) {
          print("categories");
          categories = jsonResponse.data!;
          print(categories);
          emit(GetCategoriesSuccess());
        } else {
          print(response.data);
          print(response.statusCode);
          emit(GetCategoriesFailure());
        }
      } else {
        print(response.data);
        print(response.statusCode);
        emit(GetCategoriesFailure());
      }
    } catch (e) {
      print(e);
      emit(GetCategoriesFailure());
    }
  }
}
